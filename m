Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2003 10:15:38 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:14039 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8225352AbTIPJPe> convert rfc822-to-8bit;
	Tue, 16 Sep 2003 10:15:34 +0100
Received: (qmail 1540 invoked from network); 16 Sep 2003 09:01:33 -0000
Received: from unknown (HELO xing) (159.226.39.104)
  by mail.ict.ac.cn with SMTP; 16 Sep 2003 09:01:33 -0000
From: "Guangxing Zhang" <guangxing@ict.ac.cn>
To: linux-mips@linux-mips.org <linux-mips@linux-mips.org>
Subject: kernel module problems with tq_timer on mips_linux
X-mailer: Foxmail 4.2 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Content-Transfer-Encoding: 8BIT
Date: Tue, 16 Sep 2003 17:16:0 +0800
Message-Id: <20030916091534Z8225352-1272+5481@linux-mips.org>
Return-Path: <guangxing@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guangxing@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Hi, Everyone ,
    I have written a simple kernle module for the mips_linux (2.4.20-pre6-sb20021114-1).
It can work well in my linux(2.4.18-3 ,not for mips),but when I port it to mips_linux some
error occur(when i try to "insmod" , there is the error report!).
    In my kernle module , I use the tq_timer and queue_task() to implement scheduale a
function to be called on every timer interrupt.In the bottom , there is my source codes.
Of course it is a simplified verison of the example of "Chapter 11.Scheduling Tasks" of 
<<The Linux Kernel Module Programming Guide>>. 
    The error it reports is as follow and use "lsmod" I can see my kernle module is here .
    Anyone can tell why ? Eagering your helps!~ 
    Thank you in advance!
-----------------------------------------------------------------------------------
[root@(none) root]# insmod sch_example.o 
Unhandled kernel unaligned access in unaligned.c::emulate_load_store_insn, line:
$0 : 00000000 30001f00 00000001 00000040 c11291d0 00000002 c112946c 81000020
$8 : 00000000 b00200c8 00000000 00000000 00000000 2acf114c 00000000 00000000
$16: ffffffea c1129000 0000000b 00000060 8fe02ea0 0000000b 8d427000 1000ab40
$24: 00000000 2ac4d2a0                   80714000 80715e78 1000ae70 8011714c
Hi : 0877c629
Lo : 4672619f
epc  : c11291e4    Not tainted
Status: 30001f03
Cause : 00808010
Process insmod (pid: 104, stackpage=80714000)
Stack:    c1129000 c1129480 ffffffea c1129000 8011714c 80133e1c 8034d500
 00030002 00000000 80139158 00000060 c1124000 c1129060 00000480 00000000
 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 8d426000 80b67f60 1000a628 10008ad8 1000aae0
 00000000 ...
Call Trace:   [<c1129480>] [<8011714c>] [<80133e1c>] [<80139158>] [<c1129060>]
 [<8010aef4>]

Code: 3c06c113  24c6946c  24020001 <d0c40008> 00821825  f0c30008  1060fffc  008
Segmentation fault
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
[root@(none) root]# lsmod
Module                  Size  Used by    Not tainted
sch_example             1152   1  (initializing)
-------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------
/*  sched.c - scheduale a function to be called on every timer interrupt.
 *
 *  Copyright (C) 2001 by Peter Jay Salzman
 */

/* The necessary header files */

/* Standard in kernel modules */
#include <linux/kernel.h>                   /* We're doing kernel work */
#include <linux/module.h>                   /* Specifically, a module */

#include <linux/interrupt.h>

/* We scheduale tasks here */
#include <linux/tqueue.h>

/* We also need the ability to put ourselves to sleep and wake up later */
#include <linux/sched.h>

/* In 2.2.3 /usr/include/linux/version.h includes a macro for this, but
 * 2.0.35 doesn't - so I add it here if necessary.
 */
#ifndef KERNEL_VERSION
#define KERNEL_VERSION(a,b,c) (((a)<<16)+((b)<<8)+(c))
#endif

/*Basic Info. of this module
*/
MODULE_LICENSE("GPL");           // Get rid of taint message by declaring code as GPL
MODULE_DESCRIPTION("Just to test!"); // What does this module do?

/* The number of times the timer interrupt has been called so far */
static int TimerIntrpt = 0;

/* This is used by cleanup, to prevent the module from being unloaded while
 * intrpt_routine is still in the task queue
 */
static volatile int my_ctl = 0;

static void intrpt_routine(void *);

/* The task queue structure for this task, from tqueue.h */
static struct tq_struct Task = {
   {NULL,NULL},   /* Next item in list - queue_task will do this for us */
   0,             /* A flag meaning we haven't been inserted into a task
                   * queue yet 
                   */
   intrpt_routine, /* The function to run */
   NULL,           /* The void* parameter for that function */
};

/* This function will be called on every timer interrupt. Notice the void*
 * pointer - task functions can be used for more than one purpose, each time 
 * getting a different parameter.
 */
static void intrpt_routine(void *irrelevant)
{
   	/* Increment the counter */
   	TimerIntrpt++;
   	//printk("<1>Ok,It is the time to do something!\n");
   	//if (WaitQ != NULL){
   	if (my_ctl==1){
   		//wake_up(&WaitQ);
   		my_ctl = 0;
   		return;
   	}
   	else {	
      		if ((TimerIntrpt%1000)==0){
			printk("<1>It is the time to do something!\n");
       		}
      		queue_task(&Task, &tq_timer);
       	}
 
}



/* Initialize the module */
int init_module()
{
   /* Put the task in the tq_timer task queue, so it will be executed at
    * next timer interrupt
    */
 	queue_task(&Task, &tq_timer);
  	printk("<1>Insert It Ok\n");
   	return 0;
  
}

/* Cleanup */
void cleanup_module()
{
   printk("<1>Say 886\n");
   my_ctl = 1;
   while (my_ctl);
   //sleep_on(&WaitQ);
}  

--------------------------------------------------------------------------------------

    

	

　	

　　　　　　　　Guangxing Zhang
　　　　　　　　guangxing@ict.ac.cn
　　　　　　　　　　2003-09-16
