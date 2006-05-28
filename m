Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2006 03:06:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:42671 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133912AbWE1BGE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 May 2006 03:06:04 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4S164Uh025475;
	Sun, 28 May 2006 02:06:04 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4S163TV025474;
	Sun, 28 May 2006 02:06:03 +0100
Date:	Sun, 28 May 2006 02:06:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kumba <kumba@gentoo.org>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>, akpm@osdl.org
Subject: Re: Commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f (on_each_cpu(): disable local interrupts) Breaks SGI IP32
Message-ID: <20060528010603.GA24997@linux-mips.org>
References: <4478C0F1.8000006@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4478C0F1.8000006@gentoo.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, May 27, 2006 at 05:13:21PM -0400, Kumba wrote:

> Finally managed to track down the git commit causing SGI IP32 (O2) systems 
> to lock up really early in the boot cycle, but I'm at a loss to understand 
> why.
> 
> Effect:
> It appears the system silently hangs somewhere in the void between function 
> calls when trying to invoke the memset() call in __alloc_bootmem_core() in 
> mm/bootmem.c.  This puts the machine hardware in a state such that a simple 
> soft reset doesn't clear it -- the machine has to be cold booted to get it 
> to boot a working kernel again.
> 
> Determined Cause:
> It seems this commit:
> 78eef01b0fae087c5fadbd85dd4fe2918c3a015f
> 	[PATCH] on_each_cpu(): disable local interrupts
> 
> Is the cause.  I've verified this by reversing this one change on a 
> 2.6.17-rc4 tree, and it'll boot to a mini-userland (initramfs-based) and 
> appears to function normally.
> 
> 
> But this is as far as I can trace this.  I'm not sure what this change is 
> doing internally that's triggering this lockup on O2 systems.  It doesn't 
> appear to affect Octane (IP30) systems or Origin (IP27).  I haven't 
> test-ran it on IP22/IP28 hardware yet, so only IP32 is known to be 
> affected.  Unsure about non-SGI MIPS hardware.

on_each_cpu is re-enabling interrupt.  This may crash the system if it
happens before interrupt handlers have been installed.  A while ago I've
fixes all such calls but I may have missed some instances.

Andrew, what was the reason for 78eef01b0fae087c5fadbd85dd4fe2918c3a015f ?

  Ralf
