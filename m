Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Dec 2002 13:14:11 +0100 (CET)
Received: from webmail33.rediffmail.com ([203.199.83.245]:29923 "HELO
	rediffmail.com") by linux-mips.org with SMTP id <S8225302AbSLFMOL>;
	Fri, 6 Dec 2002 13:14:11 +0100
Received: (qmail 29706 invoked by uid 510); 6 Dec 2002 12:14:29 -0000
Date: 6 Dec 2002 12:14:29 -0000
Message-ID: <20021206121429.29705.qmail@mailweb33.rediffmail.com>
Received: from unknown (219.65.138.173) by rediffmail.com via HTTP; 06 dec 2002 12:14:29 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: ret_from_sys_call in entry.S
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Hello ,

Excuse me for putting a tentative question.

I have a obscure problem of pagefault at unlikely address
that is pinned down to ret_from_sys_call called from
nopage_tlbl -> DO_FAULT -> ret_from_sys_call(nowdays ret_from 
excep-
tion) during execing userspace programmes.

also due to sone resons out of my control my working source tree
appears to be hacked too much.

I have one entry.S in linux 2.4.17 having top line like

/* $Id: entry.S,v 1.19 1999/12/08 22:05:10 harald Exp

with ret_from_sys_call like

EXPORT(ret_from_sys_call)
         MEASURED_CLI

         /* Check to see if the current task
          * needs to be resscheduled
          */
         lw      t2, TASK_NEED_RESCHED($28)
         nop
         bnez    t2, reschedule
         nop

and one entry.S in some earlier version of entry.S with top line
   /* $Id: entry.S,v 1.1.1.2 2001/04/30 10:53:58 carstenl Exp $

here the ret_from_sys_call is just Blank like this

EXPORT(ret_from_sys_call)

EXPORT(ret_from_irq)
                 .type   ret_from_irq,@function
                 ......
                 ......

i am curently using this later one .
but i amn't able to follow the changes for ret_from_sys_call 
between these two versions.

Best Regards,
Atul

________________________________________________________________
  NIIT supports World Computer Literacy Day on 2nd December.
  Enroll for NIIT SWIFT Jyoti till 2nd December for only Rs. 749
  and get free Indian Languages Office software worth Rs. 2500.
  For details contact your nearest NIIT centre, SWIFT Point
  or click here http://swift.rediff.com/
