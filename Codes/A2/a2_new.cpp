#include<bits/stdc++.h>
#include<pthread.h>
using namespace std;
int *a;
int n;

class node
{
public:
    int first;
    int last; 

};

int partition(int low,int high)
{

    int pivot=a[high];
    int i=low-1;
    // cout<<pivot<<endl;
    for(int j=low;j<high;j++)
    {

        if(a[j]<=pivot)
        {
            i++;
            swap(a[i],a[j]);
        }
    }
    swap(a[i+1],a[high]);

    return i+1;
}

void* quicksort(void *obj)
{
    pthread_t threads[2];
    node* temp=(node*)obj;
    int low=temp->first;
    int high=temp->last;
    int pivot;  
    pthread_t id= pthread_self();
    if(low<high)
    {
    
        pivot=partition(low,high);
        cout<<"Thread Id "<<id<<" Pivot "<<pivot<<endl;
    
        node n1;
        n1.first=low;
        n1.last=pivot-1;
        
        pthread_create(&threads[0],NULL,&quicksort,(void *)&n1);
        
        node n2;
        n2.first=pivot+1;
        n2.last=high;
        
        pthread_create(&threads[1],NULL,&quicksort,(void *)&n2);

        pthread_join(threads[0],NULL);
        pthread_join(threads[1],NULL);


    }

}

int main()
{
    cout<<"Enter number of elements\n";
    cin>>n;
    a=new int[n+1];
    cout<<"Enter array"<<endl;
    for(int i=1;i<=n;i++)
        cin>>a[i];

    node *obj=new node();
    obj->first=1;
    obj->last=n;

    quicksort((void*)obj);

    cout<<"Sorted Array"<<endl;
    for(int i=1;i<=n;i++)
        cout<<a[i]<<" ";
    cout<<endl;

    return 0;
}

// *********************************OUTPUT******************************
// [be@dbsl15 4246]$ g++ a2.cpp -pthread
// [be@dbsl15 4246]$ ./a.out
