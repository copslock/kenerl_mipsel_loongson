Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QEZN320337
	for linux-mips-outgoing; Tue, 26 Feb 2002 06:35:23 -0800
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QEZI920334
	for <linux-mips@oss.sgi.com>; Tue, 26 Feb 2002 06:35:18 -0800
Message-Id: <200202261435.g1QEZI920334@oss.sgi.com>
Received: (qmail 31202 invoked from network); 26 Feb 2002 13:39:13 -0000
Received: from unknown (HELO foxsen) (@159.226.40.150)
  by 159.226.39.4 with SMTP; 26 Feb 2002 13:39:13 -0000
Date: Tue, 26 Feb 2002 21:32:8 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: Scott A McConnell <samcconn@cotw.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Re: MIPS, i8259 and spurious interrupts.
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,
 then check your interrupt mask code,i suffered from this problem
some time ago too. You can check the list for those threads(more than
one). In short,the reason i was seeing spurious interrupt is:
   1. the code i used to decide which interrupt coming in used to have a bug
      (the IRR bit may still set for current interrupt even after i masked it, 
       when a new 8259 interrupt come in,i detect it as the old one)
   2. write to 8259 didn't really reach device for some time,some barrier needed

>
>No this is an instrumentation mistake. Yes it never returns...
>Because I reenter the interrupt handler before it completes.

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
