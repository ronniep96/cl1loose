package huffman;
import java.util.*;
import java.io.*;
public class HuffmanCode {
public static HuffmanTree buildTree(int[] charFreqs) {
PriorityQueue<HuffmanTree> trees = new PriorityQueue<HuffmanTree>();
for (int i = 0; i < charFreqs.length; i++)
if (charFreqs[i] > 0)
trees.offer(new HuffmanLeaf(charFreqs[i], (char)i));
assert trees.size() > 0;
while (trees.size() > 1) {
HuffmanTree a = trees.poll();
HuffmanTree b = trees.poll();
trees.offer(new HuffmanNode(a, b));
}
return trees.poll();
}
public static void printCodes(HuffmanTree tree,
 StringBuffer prefix, PrintWriter out) {
assert tree != null;
if (tree instanceof HuffmanLeaf) {
HuffmanLeaf leaf = (HuffmanLeaf)tree;
out.print("<tr>");
out.print("<td>"+leaf.value+"</td>"+"<td>"+
leaf.frequency+"</td>"+"<td>"+prefix+"</td>");
out.print("</tr>");
} else if (tree instanceof HuffmanNode) {
HuffmanNode node = (HuffmanNode)tree;
prefix.append('0');
printCodes(node.left, prefix, out);
prefix.deleteCharAt(prefix.length()-1);
prefix.append('1');
printCodes(node.right, prefix, out);
prefix.deleteCharAt(prefix.length()-1);
}
}
}
