import java.io.IOException;
import java.util.*; 
import org.apache.hadoop.fs.Path; 
import org.apache.hadoop.io.*; 
import org.apache.hadoop.mapred.*;
import org.apache.hadoop.util.*;
public class MapReduce
{ 
public static final int userId=17; 
public static class Map extends MapReduceBase implements Mapper<LongWritable, Text, IntWritable, Text>
{ 
private Text word = new Text();
@Override
public void map(LongWritable key, Text value,OutputCollector<IntWritable, Text> output, Reporter reporter) throws IOException
	{
	StringTokenizer tokenizer = new StringTokenizer(value.toString(), ","); 
	if( Integer.parseInt(tokenizer.nextToken()) == userId )
		{
		 word.set(tokenizer.nextToken());
		 int hitCount = Integer.parseInt(tokenizer.nextToken()); 
		 output.collect(new IntWritable(hitCount), word);
		 }
	}
}//class map ends
public static class Reduce extends MapReduceBase implements Reducer<IntWritable, Text, IntWritable, Text>
{
@Override
public void reduce(IntWritable key, Iterator<Text> values,OutputCollector<IntWritable, Text> output, Reporter reporter) throws IOException
	{ 
	while(values.hasNext()){ 
		output.collect(key, values.next());
		}
	}
}//reduce ends
public static void main(String []args) throws Exception
{
System.out.println("\n-------------WELCOME TO MAPREDUCE JOB -------");
System.out.println("\nMapReduce Job Starting...\n"); 
JobConf conf = new JobConf(MapReduce.class); 
conf.setJobName("MapReduce Job"); 
conf.setMapperClass(Map.class);
conf.setReducerClass(Reduce.class);
conf.setOutputKeyClass(IntWritable.class); 
conf.setOutputValueClass(Text.class); 
conf.setInputFormat(TextInputFormat.class); 
conf.setOutputFormat(TextOutputFormat.class);
FileInputFormat.setInputPaths(conf, new Path(args[0]));
FileOutputFormat.setOutputPath(conf, new Path(args[1]));
JobClient.runJob(conf);
}//main ends
}
