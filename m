Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Aug 2004 07:30:53 +0100 (BST)
Received: from host73.ipowerweb.com ([IPv6:::ffff:12.129.211.254]:57566 "EHLO
	host73.ipowerweb.com") by linux-mips.org with ESMTP
	id <S8224844AbUHFGas> convert rfc822-to-8bit; Fri, 6 Aug 2004 07:30:48 +0100
Received: from c-67-170-233-233.client.comcast.net ([67.170.233.233] helo=ratwin1)
	by host73.ipowerweb.com with asmtp (Exim 3.36 #1)
	id 1BsyER-0008LJ-00; Thu, 05 Aug 2004 23:29:35 -0700
Reply-To: <ratin@koperasw.com>
From: "Ratin Kumar" <ratin@koperasw.com>
To: "'akshay'" <akshay.singh@analog.com>, <linux-mips@linux-mips.org>
Subject: RE: pthread uClibc
Date: Thu, 5 Aug 2004 23:30:22 -0700
Organization: Kopera Software Inc.
Message-ID: <00bc01c47b7e$de436130$6401a8c0@ratwin1>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <006101c47b6b$abbd6610$5d0d790a@asingh2d01>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host73.ipowerweb.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - koperasw.com
Return-Path: <ratin@koperasw.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ratin@koperasw.com
Precedence: bulk
X-list: linux-mips

It might make a bit more sense if you talk a bit about your setup/toolchain
(cross??) and version of libraries used....

-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of akshay
Sent: Thursday, August 05, 2004 9:13 PM
To: linux-mips@linux-mips.org
Subject: pthread uClibc


Hi,

I am trying to use pthread on mips based platform.

I have simple program to just create pthreads and when I run my program, it
goes in infinite loop and never comes back.
Though when I hit enter on console, I see following message on console.

pt: assertion failed in manager.c:154.

pt: assertion failed in manager.c:193.

Can someone plz help me here .



Here is the code for my program.
==============================================================
#include <stdio.h>
#include <pthread.h>

void print_message_function( void *ptr );

     pthread_t thread1;
     char *message1 = "Thread 1";

main()
{
     int  iret1, iret2;

    /* Create independant threads each of which will execute function */

     iret1 = pthread_create( &thread1, NULL, (void*)&print_message_function,
(v
oid*) message1);

printf("threads created ....\n");
     /* Wait till threads are complete before main continues. Unless we  */
     /* wait we run the risk of executing an exit which will terminate   */
     /* the process and all threads before the threads have completed.   */

     pthread_join( thread1, NULL);

     printf("Thread 1 returns: %d\n",iret1);
     exit(0);
}

void print_message_function( void *ptr )
{
     char *message;
     message = (char *) ptr;
     printf("%s \n", message);
}





Thanks,
Akshay
