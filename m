Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7GIUlRw030308
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 16 Aug 2002 11:30:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7GIUlf0030307
	for linux-mips-outgoing; Fri, 16 Aug 2002 11:30:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from localhost.localdomain (ip68-6-27-208.hu.sd.cox.net [68.6.27.208])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7GIUiRw030298
	for <linux-mips@oss.sgi.com>; Fri, 16 Aug 2002 11:30:44 -0700
Received: (from justin@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g7GIY0K01581;
	Fri, 16 Aug 2002 11:34:00 -0700
X-Authentication-Warning: localhost.localdomain: justin set sender to justinca@cs.cmu.edu using -f
Subject: Re: irq handle of sb1250
From: Justin Carlson <justinca@cs.cmu.edu>
To: bxy@mail.ihep.ac.cn
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
In-Reply-To: <200208160756.g7G7uvR08742@mail.ihep.ac.cn>
References: <200208160756.g7G7uvR08742@mail.ihep.ac.cn>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Aug 2002 11:33:59 -0700
Message-Id: <1029522839.1502.1.camel@xyzzy.rlson.org>
Mime-Version: 1.0
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 2002-08-16 at 01:01, bxy@mail.ihep.ac.cn wrote:
> hi, who is using sb1250/swarm board? i have mapped all the interrupts of
> second cpu to IP7(default IP2). after changing irq.c and irq_handler.S, 
> second cpu can't get any interrupt. I don't know why it is. 

Which cpu gets the interrupt depends on how you've programmed the SCD. 
It's kind of hard to tell you anything useful, when you've posted no
code so we can't see what you're doing.

-Justin
