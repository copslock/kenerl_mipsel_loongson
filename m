Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Sep 2002 15:51:16 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:16902 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122961AbSIMNvQ>;
	Fri, 13 Sep 2002 15:51:16 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17prmd-0001ra-00; Fri, 13 Sep 2002 09:50:59 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17pqqn-0002or-00; Fri, 13 Sep 2002 09:51:13 -0400
Date: Fri, 13 Sep 2002 09:51:13 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Stuart Hughes <seh@zee2.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: cannot debug multi-threaded programs with gdb
Message-ID: <20020913135113.GA10721@nevyn.them.org>
References: <3D81B8D3.1609CD69@zee2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D81B8D3.1609CD69@zee2.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 13, 2002 at 11:07:15AM +0100, Stuart Hughes wrote:
> Hi,
> 
> I've been trying to debug a simple multi-threaded test program using
> gdb, and it always fails as follows:
> 
> [New Thread 1024 (LWP
> 39)]                                                      
>                                                                                 
> Program received signal SIGTRAP, Trace/breakpoint
> trap.                         
> [Switching to Thread 1024 (LWP
> 39)]                                             
> warning: Warning: GDB can't find the start of the function at
> 0xffffffff.       
> 
> I've tried various different compilers, gdb, glibc version but the
> problem is the same.  Note that I can debug non-threaded c/c++ programs
> without any problem.  My environment is as follows:
> 
> CPU:		NEC VR5432
> kernel: 	linux-2.4.10 + patches
> glibc:		2.2.3 + patches

Not enough patches I'd bet.  Glibc 2.2.3 had an incorrect size listed
for elf_gregset_t, and it was fixed in 2.2.5.  That would cause this
problem.

> gdb:		5.2/3 from CVS
> gcc:		3.1 (also tried 3.0.1)
> binutils:	Version 2.11.90.0.25
> 
> Does anyone have any idea what is wrong and how to fix it. 
> 
> Regards, Stuart
> 
> 

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
