Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2006 01:44:11 +0000 (GMT)
Received: from [69.90.147.196] ([69.90.147.196]:8157 "EHLO mail.kenati.com")
	by ftp.linux-mips.org with ESMTP id S20039432AbWKWBoG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2006 01:44:06 +0000
Received: from [192.168.1.169] (adsl-71-130-109-177.dsl.snfc21.pacbell.net [71.130.109.177])
	by mail.kenati.com (Postfix) with ESMTP id 3E1A3E401A;
	Wed, 22 Nov 2006 19:12:24 -0800 (PST)
Subject: init cannot spawn shell
From:	Ashlesha Shintre <ashlesha@kenati.com>
Reply-To: ashlesha@kenati.com
To:	mlachwani <mlachwani@mvista.com>, ralf@linux-mips.org,
	sjhill@real.realitydiluted.com
Cc:	linux-mips@linux-mips.org
In-Reply-To: <4564E6DA.1030504@mvista.com>
References: <1164224559.6511.4.camel@sandbar.kenati.com>
	 <20061122221712.GB8819@linux-mips.org>
	 <1164239075.6511.13.camel@sandbar.kenati.com> <4564E6DA.1030504@mvista.com>
Content-Type: text/plain
Date:	Wed, 22 Nov 2006 17:55:53 -0800
Message-Id: <1164246953.6511.25.camel@sandbar.kenati.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Return-Path: <ashlesha@kenati.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ashlesha@kenati.com
Precedence: bulk
X-list: linux-mips


Hi,

So the ">>>> request_module: runaway loop modprobe net-pf-1" problem is
now solved, I dont get the same error again --
Thank you Ralf, Manish and Steve for your prompt responses..

However, the kernel gets stuck now after mounting the filesystem and
freeing memory.  It does not execute the shell.  When I give a boot
argument such as init=/bin/sh, it attempts to kill init.

I m sure that the endianness is not an issue - everything is big endian.

I statically compiled a hello world program and instead of the rcS
script in the init.d directory, put in this entry in the inittab

sys::sysinit:/etc/init.d/hello

however, I dont see "Hello World" on the console! -- meaning the problem
is in userspace?

Any ideas on how to debug this situation?

Thanks,
Ashlesha.


On Wed, 2006-11-22 at 16:10 -0800, mlachwani wrote:
> CONFIG_UNIX is defined in net/unix/Kconfig or simply do a "make 
> menuconfig" and search for UNIX.
> 
> It depends on CONFIG_NET. Check your .config ...
> 
> thanks,
> Manish Lachwani
> 
> 
> Ashlesha Shintre wrote:
> > On Wed, 2006-11-22 at 22:17 +0000, Ralf Baechle wrote:
> >   
> >> On Wed, Nov 22, 2006 at 11:42:39AM -0800, Ashlesha Shintre wrote:
> >>
> >>     
> >>> During boot up on the Encore M3 board (AU1500 MIPS) of the 2.6.14.6
> >>> kernel, the process stops after the NFS filesystem has been mounted,
> >>> memory freed  and spits out the following message:
> >>>
> >>>
> >>>       
> >>>> request_module: runaway loop modprobe net-pf-1
> >>>>         
> >> The kernel tried to open UNIX domain socket but because support is not
> >> compiled it will load the module instead.  Now, glibc-based programs
> >> happen to try to connect to nscd via a UNIX domain socket on startup
> >> and the whole show starts all over.  After a few iterations the kernel
> >> gets tired of the whole game and prints this friendly message.
> >>
> >>     
> >>> What does the net-pf-1 mean?
> >>>       
> >> net-pf-1 is PF_UNIX, see the definitions in include/linux/socket.h.  So
> >> you should set CONFIG_UNIX to y.  
> >>     
> >
> > Thanks for your reply Ralf, but I dont see he CONFIG_UNIX option in my
> > Makefile, so I created one, but still get the same error!
> > is there anything else that i should try?
> >
> > Thanks again,
> > Ashlesha.
> >   
> >> Building it as a module won't work
> >> as you just found :).
> >>
> >>   Ralf
> >>     
> >
> >
> >   
> 
