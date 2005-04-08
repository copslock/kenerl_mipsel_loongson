Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2005 15:46:09 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:51991 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225410AbVDHOpv>; Fri, 8 Apr 2005 15:45:51 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 8 Apr 2005 10:41:36 -0400
Message-ID: <4256991C.4020601@timesys.com>
Date:	Fri, 08 Apr 2005 10:45:48 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: another 4kc machine check.
References: <42553E49.7080004@timesys.com>
In-Reply-To: <42553E49.7080004@timesys.com>
Content-Type: multipart/mixed;
 boundary="------------010208010801020209030105"
X-OriginalArrivalTime: 08 Apr 2005 14:41:36.0593 (UTC) FILETIME=[1107CC10:01C53C49]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------010208010801020209030105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greg Weeks wrote:

> This is the malta branch with the tlb patch from Ralf applied. The LTP 
> test:
>
>
> -bash-2.05b# shmem_test_06

This test does some mucking with shmat at fixed addresses that might not 
be correct for mips. I still wouldn't expect to see a machine check when 
it goes to free the shared memory areas. I'm going to try it on a 24K 
malta as soon as I get yamon on it and can get it booted.

Greg Weeks


--------------010208010801020209030105
Content-Type: text/x-c;
 name="shmem_test_06.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="shmem_test_06.c"

/*
 *
 *   Copyright (c) International Business Machines  Corp., 2001
 *
 *   This program is free software;  you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
 *   the GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program;  if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

/*
 * Copyright (C) Bull S.A. 1996
 * Level 1,5 Years Bull Confidential and Proprietary Information
 */

/*---------------------------------------------------------------------+
|                           shmem_test_06.c                            |
| ==================================================================== |
| Title:        Segment Register 0xE                                   |
|                                                                      |
| Purpose:      simultaneous attachment of more than ten shared        |
|               memory regions to a process. Using segment registers   |
|               0x3 to 0xC and 0xE .                                   |
|                                                                      |
| Description:  Simplistic test to verify that a process can obtain    |
|               11 shared memory regions in the adress space from      |
|               0x30000000 to 0xCFFFFFFF and 0xE0000000 to 0xEFFFFFFF. |
|                                                                      |
|                                                                      |
| Algorithm:    *  from 1 up to 11                                     |
|               {                                                      |
|               o  Create a key to uniquely identify the shared segment|
|		   using ftok()	subroutine.			       |
|               o  Obtain a unique shared memory identifier with       |
|                  shmget ()                                           |
|               o  Map the shared memory segment to the current        |
|                  process with shmat ()                               |
|               o  Index through the shared memory segment             |
|               }                                                      |
|               *  from 1 up to 11                                     |
|               {                                                      |
|               o  Detach from the segment with shmdt()                |
|               o  Release the shared memory segment with shmctl ()    |
|               }                                                      |
|                                                                      |
| System calls: The following system calls are tested:                 |
|                                                                      |
|               ftok()                                                 |
|               shmget ()                                              |
|               shmat ()                                               |
|               shmdt ()                                               |
|               shmctl ()                                              |
|                                                                      |
| Usage:        shmem_test_06                                          |
|                                                                      |
| To compile:   cc -O -g  shmem_test_06.c -o shmem_test_06 -lbsd       |
|                                                                      |
| Last update:                                                         |
|                                                                      |
| Change Activity                                                      |
|                                                                      |
|   Version  Date    Name  Reason                                      |
|    0.1     010797  J.Malcles  initial version for 4.2.G              |
|                                                                      |
|                                                                      |
+---------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <sys/shm.h>

#include <sys/types.h>
#include <sys/ipc.h>

#include <sys/stat.h>
/*
off_t offsets[] = {
0x20000000,
0x30000000,
0x48000000,
0x50000000,
0x60000000,
0x70000000,
0x80000000,
0x90000000,
0xA0000000,
0xB0000000,
0xBFE00000,
};
*/
off_t offsets[] = {
0x20000000,
0x00000000,
0x48000000,
0x50000000,
0x60000000,
0x60200000,
0x60400000,
0x70200000,
0x70400000,
0x70600000,
0x70800000,
};
int offsets_cnt = sizeof (offsets) /sizeof (offsets[0]);
/* Defines
 *
 * MAX_SHMEM_SIZE: maximum shared memory segment size of 256MB 
 *
 * MAX_SHMEM_NUMBER: maximum number of simultaneous attached shared memory 
 * regions
 *
 * DEFAULT_SHMEM_SIZE: default shared memory size, unless specified with
 * -s command line option
 * 
 * SHMEM_MODE: shared memory access permissions (permit process to read
 * and write access)
 * 
 * USAGE: usage statement
 */
#define MAX_SHMEM_SIZE		256*1024*1024
#define MAX_SHMEM_NUMBER	11
#define DEFAULT_SHMEM_SIZE	1024*1024
#define	SHMEM_MODE		(SHM_R | SHM_W)
#define USAGE	"\nUsage: %s [-s shmem_size]\n\n" \
		"\t-s shmem_size  size of shared memory segment (bytes)\n" \
		"\t               (must be less than 256MB!)\n\n"

#define GOTHERE printf("got to line %d\n", __LINE__);

/*
 * Function prototypes
 *
 * parse_args (): Parse command line arguments
 * sys_error (): System error message function
 * error (): Error message function
 */
void parse_args (int, char **);
void sys_error (const char *, int);
void error (const char *, int);

/*
 * Global variables
 * 
 * shmem_size: shared memory segment size (in bytes)
 */
int shmem_size = DEFAULT_SHMEM_SIZE;


/*---------------------------------------------------------------------+
|                               main                                   |
| ==================================================================== |
|                                                                      |
|                                                                      |
| Function:  Main program  (see prolog for more details)               |
|                                                                      |
| Returns:   (0)  Successful completion                                |
|            (-1) Error occurred                                       |
|                                                                      |
+---------------------------------------------------------------------*/
int main (int argc, char **argv)
{
  off_t offset;
  int i;
  
  int shmid[MAX_SHMEM_NUMBER];	/* (Unique) Shared memory identifier */
  
  char *shmptr[MAX_SHMEM_NUMBER];	/* Shared memory segment address */
  char	*ptr;		/* Index into shared memory segment */
  
  int value = 0;	/* Value written into shared memory segment */
  
  key_t mykey[MAX_SHMEM_NUMBER];
  char * null_file = "/dev/null";
  char  proj[MAX_SHMEM_NUMBER] = {
    '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'E'
  };
  
  
  /*
   * Parse command line arguments and print out program header
   */
  parse_args (argc, argv);
  printf ("%s: IPC Shared Memory TestSuite program\n", *argv);
  
  for (i=0; i<offsets_cnt; i++) 
    {
      char tmpstr[256];
      /*
       * Create a key to uniquely identify the shared segment
       */
      
      mykey[i] = ftok(null_file,proj[i]);
      
      printf ("\n\tmykey to uniquely identify the shared memory segment 0x%x\n",mykey[i]);
      
      printf ("\n\tGet shared memory segment (%d bytes)\n", shmem_size);
      /*
       * Obtain a unique shared memory identifier with shmget ().
       */
      
      if ((long)(shmid[i]= shmget (mykey[i], shmem_size, IPC_CREAT | 0666 )) < 0)
	sys_error ("shmget failed", __LINE__);
      
      
      printf ("\n\tAttach shared memory segment to process\n");
      /*
       * Attach the shared memory segment to the process
       */
      offset = offsets[i];

      if ((long)(shmptr[i] = (char *) shmat (shmid[i], (const void*)offset, 0)) == -1)
	{
	  sprintf(tmpstr, "shmat failed - return: %p", shmptr[i]);
	  sys_error (tmpstr, __LINE__);
	}

      
      printf ("\n\tShared memory segment address : 0x%p \n",shmptr[i]);
      
      printf ("\n\tIndex through shared memory segment ...\n");
      
      /*
       * Index through the shared memory segment
       */
      
      for (ptr=shmptr[i]; ptr < (shmptr[i] + shmem_size); ptr++)
	*ptr = value++;
      
    } // for 1..11

  printf ("\n\tDetach from the segment using the shmdt subroutine\n");
  
  printf ("\n\tRelease shared memory\n");
  
  for (i=0; i<offsets_cnt; i++) 
    {
      // Detach from the segment
      
      shmdt( shmptr[i] );
      
      // Release shared memory
      
      if (shmctl (shmid[i], IPC_RMID, 0) < 0)
	sys_error ("shmctl failed", __LINE__);
      
    } // 2nd for 1..11
  /* 
   * Program completed successfully -- exit
   */
  
  printf ("\nsuccessful!\n");
  
  return (0);
  
}


/*---------------------------------------------------------------------+
|                             parse_args ()                            |
| ==================================================================== |
|                                                                      |
| Function:  Parse the command line arguments & initialize global      |
|            variables.                                                |
|                                                                      |
| Updates:   (command line options)                                    |
|                                                                      |
|            [-s] size: shared memory segment size                     |
|                                                                      |
+---------------------------------------------------------------------*/
void parse_args (int argc, char **argv)
{
  int	i;
  int	errflag = 0;
  char	*program_name = *argv;
  extern char 	*optarg;	/* Command line option */
  
  while ((i = getopt(argc, argv, "s:?")) != EOF) {
    switch (i) {
    case 's':
      shmem_size = atoi (optarg);
      break;
    case '?':
      errflag++;
      break;
    }
  }
  
  if (shmem_size < 1 || shmem_size > MAX_SHMEM_SIZE)
    errflag++;
  
  if (errflag) {
    fprintf (stderr, USAGE, program_name);
    exit (2);
  }
}


/*---------------------------------------------------------------------+
  |                             sys_error ()                             |
  | ==================================================================== |
  |                                                                      |
  | Function:  Creates system error message and calls error ()           |
  |                                                                      |
  +---------------------------------------------------------------------*/
void sys_error (const char *msg, int line)
{
  char syserr_msg [256];
  
  sprintf (syserr_msg, "%s: %s\n", msg, strerror (errno));
  error (syserr_msg, line);
}


/*---------------------------------------------------------------------+
|                               error ()                               |
| ==================================================================== |
|                                                                      |
| Function:  Prints out message and exits...                           |
|                                                                      |
+---------------------------------------------------------------------*/
void error (const char *msg, int line)
{
  fprintf (stderr, "ERROR [line: %d] %s\n", line, msg);
  exit (-1);
}

--------------010208010801020209030105--
