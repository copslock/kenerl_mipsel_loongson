Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 12:35:27 +0100 (BST)
Received: from p508B67B0.dip.t-dialin.net ([IPv6:::ffff:80.139.103.176]:32708
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225240AbTFLLfZ>; Thu, 12 Jun 2003 12:35:25 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5CBZMbY008644;
	Thu, 12 Jun 2003 04:35:23 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5CBZLv2008642;
	Thu, 12 Jun 2003 13:35:21 +0200
Date: Thu, 12 Jun 2003 13:35:20 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Trevor Woerner <mips081@vtnet.ca>
Cc: linux-mips@linux-mips.org
Subject: Re: 64-bit sysinfo
Message-ID: <20030612113520.GA8390@linux-mips.org>
References: <200306120659.26501.mips081@vtnet.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306120659.26501.mips081@vtnet.ca>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2003 at 06:59:26AM -0400, Trevor Woerner wrote:

> (good to see some familiar and friendly faces from the PPC list! :-)
> 
> I ran into a problem yesterday and I just don't know how I'm going to 
> approach solving it.
> 
> I compiled a 64-bit MIPS kernel, then built a busybox-based ramdisk. At 
> first I couldn't get busybox's 'init' to work but later solved it by 
> disabling the 'check_memory()' call.
> 
> Further investigation into why the 'check_memory()' call was failing 
> revealed a problem with the 'sysinfo()' system call. The kernel is 
> 64-bit, therefore when it fills in the 'struct sysinfo' (as it does 
> when 'sys_meminfo()' is called) unsigned int's are 64 bits. But back in 
> userspace, the 'struct sysinfo' that gets allocated thinks that 
> unsigned int's are 32 bits.
> 
> This causes a crash if the 'struct sysinfo' is allocated on the stack 
> back in userspace, and causes seg faults if it's allocated in the .data 
> section (globally).
> 
> I'm crossing my fingers and hoping that my solution is to build all 
> user-space apps with some switch that will set the sizes of data types 
> to be the same between user space and kernel space. Does some such 
> option exist?

Userspace really shouldn't need to know what kind of kernel it's running
on ...

The kernel has a wrapper for 32-bit code (see sys32_sysinfo) and that one
seems to look correct to me.

Can you check that your program is actually using the right syscall,
that is syscall number 4116?  If it's using 5097 it's using the native
64-bit syscall which obviously would explain your observation.

Any piece of usercode that's directly using <asm/unistd.h> is likely
to do something like this.  In short, using <asm/unistd.h> from userspace
is a really bad idea ...

  Ralf
