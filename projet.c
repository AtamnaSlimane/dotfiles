#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define max_name 20;
#define max_bloc 50;
typedef struct{
  int n_blocs;
  int i_records;
  int d_records;
}Theader;
typedef struct{
 char ID[max_name];
 char name[max_name];
 int age;
 bool is_deleted;
 struct Trecord *next;
}Trecord;
typedef struct{
  int rcount;
  Trecord *rhead;
  Tbloc *next;
}Tbloc;
void initialize_header(FILE *filename)
{
n_blocs=0;
i_records=0;
d_records=0;
}
Trecord* search(Tbloc *fbloc,const char *ID)
{
 Tbloc *cbloc=fbloc;
 while (cbloc!=NULL) {
    Trecord *crecord=cbloc->rhead;
    while (crecord!=NULL) {
     if(strcmp(crecord->ID,ID)==0&&crecord->is_deleted==0)
      {printf("patient found ID:%s,Name:%s,Age:%d\n",crecord->ID,crecord->name,crecord->age);
return crecord;
      };
crecord=crecord->next;
    }
    cbloc=cbloc->next;
 }
 printf("patient not found\n");
  return NULL;
    
}
void add_record(Tbloc *bloc,Theader *header,char *ID,const char *name,int age)
{
Tbloc *cbloc=fbloc;
  if(cbloc==NULL)
  {
    cbloc=malloc(sizeof(Tbloc));
    if(!cbloc){printf("memory allocation failed\n");exit(EXIT_FAILURE);}
    cbloc->rhead=NULL;
    cbloc->rcount=0;
    cbloc->next=NULL;
    *fbloc=cbloc;
  }
  while (cbloc->rcount>=max_bloc&&crecord->next!=NULL) {
    cbloc=cbloc->next;
  }
  if (cbloc->rcount>=max_bloc) {
    Tbloc *nbloc=malloc(sizeof(Tbloc));
    if (!nbloc) {
      printf("memory allocation failed\n");exit(EXIT_FAILURE);
    }
    nbloc->rhead=NULL;
    nbloc->rcount=0;
    nbloc->next=NULL;
    cbloc->next=nbloc;
    cbloc=nbloc;
  }
  Trecord *nrecord= (Trecord*)malloc(sizeof(Trecord));
    if (!nrecord) {
        perror("Memory allocation failed");
        exit(EXIT_FAILURE);
    }
  strncpy(nrecord->id, id, max_bloc);
    nrecord->id[max_bloc] = '\0';
    strncpy(nrecord->name, name, max_bloc - 1);
    nrecord->name[max_bloc - 1] = '\0';
    nrecord->age = age;
    nrecord->is_deleted = 0;
    nrecord->next = cblock->head;

    current_block->head = nrecord;
    current_block->rcount++;
    header->i_records++;

    printf("Record with ID %s inserted.\n", id);
}
void delete(Tbloc *fbloc,Theader *header,const char *ID)
{
Tbloc *cbloc=fbloc;
  while (cbloc!=NULL) {
    Trecord *crecord=cbloc->head;
    while (crecord!=NULL) {
      if (strcmp(crecord->ID,ID)==0&&crecord->is_deleted==0) {
        crecord->is_deleted=1;
        header->d_records++;
        printf("the patient is deleted\n")
      }
      crecord=crecord->next;
    }
    cbloc=cbloc->next;
  }
  printf("patient not found for deletion\n");
}
void search_range(Tbloc *fbloc,const char *s_ID,const char *f_ID)
{
Tbloc *cbloc=fbloc;
  while (cbloc!=NULL) {
    Trecord *crecord=cbloc->head;
    while (crecord!=NULL) {
    
    if(crecord->is_deleted==0 && strcmp(crecord->ID,s_ID)>=0 && strcmp(crecord->ID,f_ID)<=0)
    {
        int found=1;
printf("patient found ID:%s,Name:%s,Age:%d\n",crecord->ID,crecord->name,crecord->age);
    }
    crecord=crecord->next;
  }
  cbloc=cbloc->next;
  }
 if (!found) {
  printf("patients not found\n");}
}

