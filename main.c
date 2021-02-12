#include <stdio.h>
#include <string.h>
#define MAXLIM 10
void searching ( char str[] , char dest[]);
void substring(char S[], char Sub[], int P, int L);
void Join_String(char str1[], char str2[]);
void capitalize(char str[]);
void upper_lower(char para[]);
int main()
{
    char str1[MAXLIM] , str2[MAXLIM],temp;
    int selectop ;
    printf("Welcome at our project \nthis is a program that make some operation at strings \nlet's start...\n");
    printf("...very good... \nnow what's the operation do u need to do\n ...please type number of this operation...\n");
    printf("1 -Search on a specific word/character \n2- find substring \n3- Join 2 strings\n4- Capitalize first letter in each word\n5- Convert all characters in the paragraph to Lower/upper case\n");
    scanf("%d",&selectop);
    if ( selectop == 1  )
    {
        printf("enter paragraph : \n");
        scanf("%c",&temp); // temp statement to clear buffer
        scanf("%[^\n]",str1);
        printf("enter destination word : ");
        scanf("%c",&temp); // temp statement to clear buffer
        scanf("%[^\n]",str2);
        searching(str1,str2);
    }
    else if (selectop == 2 )
    {
        int position, length;
        char NewSubStr[MAXLIM];
        printf("enter full string : ");
        scanf("%c",&temp); // temp statement to clear buffer
        scanf("%[^\n]",str1);
        printf("Enter the position and length of substring\n");
        scanf("%c",&temp); // temp statement to clear buffer
        scanf("%d%d", &position, &length);
        substring(str1, NewSubStr, position, length);
        printf("Required substring is \"%s\"\n",NewSubStr);
    }
    else if ( selectop == 3 )
    {
        printf("enter 1st string : ");
        scanf("%c",&temp); // temp statement to clear buffer
        scanf("%[^\n]",str1);
        printf("enter 2nd string : ");
        scanf("%c",&temp); // temp statement to clear buffer
        scanf("%[^\n]",str2);
        Join_String(str1,str2);

    }
    else if ( selectop == 4 )
    {
        printf("Enter a string: "); //input string
        scanf("%c",&temp); // temp statement to clear buffer
        scanf("%[^\n]",str1); //read string with spaces
        capitalize(str1); // call function
        printf("Capitalize string is: %s\n",str1);// print result of function
    }
    else if ( selectop == 5 )
    {
        printf("enter full string : ");
        scanf("%c",&temp); // temp statement to clear buffer
        scanf("%[^\n]",str1);
        upper_lower(str1);
    }
    else
    {
        printf("am i joke with u ! ! !\n");
    }
    return 0;
}
void searching ( char str[] , char dest[])
{
    int startIndex = -1  ;
    int endIndex = -1 ;
    for (int j = 0 , i = 0 ; j < strlen(dest) && i < strlen(str)&& endIndex == -1 ; i++)
    {
        if(str[i] == dest[j]){
            if(startIndex == -1){
                startIndex = i ;
            }
            if( j  == strlen(dest) -1 ){
                endIndex = i;
            }
            j++;
        }
        else{
            if(startIndex != -1){
                i = startIndex +1;
                j = 0 ;
                startIndex = -1;
            }

        }
    }

    if(startIndex != -1 && endIndex != -1){
        printf("dest of %s is at index[%d,%d]",dest,startIndex,endIndex);
    }
    else{
        printf("not found");
    }
}
void substring(char S[], char Sub[], int P, int L)
{
    int C = 0;

    while (C < L)
    {
        Sub[C] = S[P+C-1];
        C++;
    }
    Sub[C] = '\0';
}
void Join_String(char str1[], char str2[])
{
    printf("%s%s",str1 ,str2);
}
void  capitalize(char str[])
{
    //capitalize first character of words
    for(int i=0; str[i]!='\0'; i++)
    {

        //check first character is lowercase alphabet
        if(i==0)
        {
            if((str[i]>='a' && str[i]<='z'))
                str[i]=str[i]-32; //subtract 32 to make it capital 32 that is differentiate between capitalize letters and small letters
            continue; //continue to the loop
        }
        if(str[i]==' ')//check space
        {
            i++; //if space is found, check next character
            //check next character is lowercase alphabet
            if(str[i]>='a' && str[i]<='z')

                str[i]=str[i]-32; //subtract 32 to make it capital 32 that is differentiate between  capitalize letters and small letters
        }

    }
}
void upper_lower(char para[])
{
    for(int i=0; i<= strlen(para) ; i++){
        if(para[i]>='a'&&para[i]<='z')
            para[i]=para[i]-32;
    }
    printf("\nParagraph in upper case is : %s",para);

    for(int i=0; i<= strlen(para) ; i++)
    {
        if(para[i]>='A'&&para[i]<='Z')
            para[i]=para[i]+32;
    }
    printf("\nParagraph in lower case is : %s",para);
}
