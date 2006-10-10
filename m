Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 00:25:09 +0100 (BST)
Received: from [69.90.147.196] ([69.90.147.196]:50903 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20037404AbWJJXZH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2006 00:25:07 +0100
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id A29A015D4005;
	Tue, 10 Oct 2006 16:48:50 -0700 (PDT)
Subject: Re: calibrate_delay function
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	mlachwani <mlachwani@mvista.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <452C20FC.6000705@mvista.com>
References: <1160520180.6521.29.camel@sandbar.kenati.com>
	 <452C20FC.6000705@mvista.com>
Content-Type: text/plain
Date:	Tue, 10 Oct 2006 16:34:30 -0700
Message-Id: <1160523270.8185.4.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips


> > start_kernel() calls calibrate_delay() which can be found in 
> > init/calibrate.c

Thanks, I did find it and put in a few printk s to debug the problem.

i have pasted part of the calibrate_delay function where the kernel gets stuck..
It is getting stuck at the second while loop where it goes into an infinite loop!
the value of ash_count keeps incrementing and thats all i see in the log buffer!

i can see why the kernel is stuck -- its because ticks=jiffies is the command just before infinitely looping based on the condition that ticks==jiffies!
Am I not looking in the right place?

Regards,
Ashlesha.
>  printk(KERN_DEBUG "Calibrating delay loop... ");
>                 while ((loops_per_jiffy <<= 1) != 0) {
>                         printk("within the while loop\n");
>                         /* wait for "start of" clock tick */
>                         ticks = jiffies;
>                         while (ticks == jiffies)
>                                 printk("%d\n",++ash_count);
>                                 /* nothing ; infinite loop, control never comes out of here*/
>                         /* Go .. */

On Tue, 2006-10-10 at 15:38 -0700, mlachwani wrote:
> Ashlesha Shintre wrote:
> > Hi,
> > I m working on the Encore M3 board that has the AU1500 MIPS processor on
> > it.  I aim to port the 2.6 linux kernel to the board which is already
> > supported in the 2.4 kernel.
> >
> > The start_kernel function in linux/init/main.c file, calls a function
> > calibrate_delay found in the arch/frv/kernel/setup.c file.  Why does the
> > kernel call this function which is a part of the Fujitsu FR-V
> > architecture?  
> >
> > When I build the image, this is the point where the kernel is stuck and
> > the last contents of the log buffer show the following printk message
> > from the calibrate_delay function:
> >
> >
> >   
> >> Calibrating delay loop...
> >>     
> >
> > Thanks,
> > Ashlesha.
> >
> >
> >
> >
> >   

> > start_kernel() calls calibrate_delay() which can be found in 
> > init/calibrate.c
> > 
> thanks,
> Manish Lachwani
