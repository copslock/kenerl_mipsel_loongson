Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Aug 2004 05:01:25 +0100 (BST)
Received: from nwd2mail2.analog.com ([IPv6:::ffff:137.71.25.51]:47051 "EHLO
	nwd2mail2.analog.com") by linux-mips.org with ESMTP
	id <S8224896AbUHFEBV>; Fri, 6 Aug 2004 05:01:21 +0100
Received: from nwd2mhb1.analog.com (nwd2mhb1.analog.com [137.71.5.12])
	by nwd2mail2.analog.com (8.12.10/8.12.10) with ESMTP id i7641GfT001707
	for <linux-mips@linux-mips.org>; Fri, 6 Aug 2004 00:01:16 -0400
Received: from jasmine.cpgindia.analog.com ([10.121.13.30])
	by nwd2mhb1.analog.com (8.9.3 (PHNE_28810+JAGae91741)/8.9.3) with ESMTP id AAA09577
	for <linux-mips@linux-mips.org>; Fri, 6 Aug 2004 00:01:07 -0400 (EDT)
Received: from asingh2d01 ([10.121.13.93])
	by jasmine.cpgindia.analog.com (8.9.1/8.9.1) with SMTP id JAA04143
	for <linux-mips@linux-mips.org>; Fri, 6 Aug 2004 09:31:04 +0530 (IST)
From: "akshay" <akshay.singh@analog.com>
To: <linux-mips@linux-mips.org>
Subject: pthread uClibc
Date: Fri, 6 Aug 2004 09:43:03 +0530
Message-ID: <006101c47b6b$abbd6610$5d0d790a@asingh2d01>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-Scanned-By: MIMEDefang 2.41
Return-Path: <akshay.singh@analog.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5611
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akshay.singh@analog.com
Precedence: bulk
X-list: linux-mips


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
