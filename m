Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 May 2006 04:38:42 +0200 (CEST)
Received: from smtp.osdl.org ([65.172.181.4]:2233 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S8126484AbWE1Cie (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 28 May 2006 04:38:34 +0200
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4S2cN2g005864
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 May 2006 19:38:24 -0700
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k4S2cNwk025105;
	Sat, 27 May 2006 19:38:23 -0700
Date:	Sat, 27 May 2006 19:42:43 -0700
From:	Andrew Morton <akpm@osdl.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	kumba@gentoo.org, linux-mips@linux-mips.org
Subject: Re: Commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f (on_each_cpu():
 disable local interrupts) Breaks SGI IP32
Message-Id: <20060527194243.a8157338.akpm@osdl.org>
In-Reply-To: <20060528010603.GA24997@linux-mips.org>
References: <4478C0F1.8000006@gentoo.org>
	<20060528010603.GA24997@linux-mips.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@osdl.org
Precedence: bulk
X-list: linux-mips

On Sun, 28 May 2006 02:06:03 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Sat, May 27, 2006 at 05:13:21PM -0400, Kumba wrote:
> 
> > Finally managed to track down the git commit causing SGI IP32 (O2) systems 
> > to lock up really early in the boot cycle, but I'm at a loss to understand 
> > why.
> > 
> > Effect:
> > It appears the system silently hangs somewhere in the void between function 
> > calls when trying to invoke the memset() call in __alloc_bootmem_core() in 
> > mm/bootmem.c.  This puts the machine hardware in a state such that a simple 
> > soft reset doesn't clear it -- the machine has to be cold booted to get it 
> > to boot a working kernel again.
> > 
> > Determined Cause:
> > It seems this commit:
> > 78eef01b0fae087c5fadbd85dd4fe2918c3a015f
> > 	[PATCH] on_each_cpu(): disable local interrupts
> > 
> > Is the cause.  I've verified this by reversing this one change on a 
> > 2.6.17-rc4 tree, and it'll boot to a mini-userland (initramfs-based) and 
> > appears to function normally.
> > 
> > 
> > But this is as far as I can trace this.  I'm not sure what this change is 
> > doing internally that's triggering this lockup on O2 systems.  It doesn't 
> > appear to affect Octane (IP30) systems or Origin (IP27).  I haven't 
> > test-ran it on IP22/IP28 hardware yet, so only IP32 is known to be 
> > affected.  Unsure about non-SGI MIPS hardware.
> 
> on_each_cpu is re-enabling interrupt.  This may crash the system if it
> happens before interrupt handlers have been installed.

on_each_cpu() calls smp_call_function().  It is not correct to call
smp_call_function() with local interrupts disabled, because it can lead to
deadlocks.

Therefore on_each_cpu() also must not be called with local interrupts
disabled.  Therefore on_each_cpu() may use
local_irq_disable()/local_irq_enable().

>  A while ago I've
> fixes all such calls but I may have missed some instances.
> 
> Andrew, what was the reason for 78eef01b0fae087c5fadbd85dd4fe2918c3a015f ?
> 

That change made the various calling environments consistent, as described
in the changelog.

If it's really, really not deadlocky to call smp_call_function() with
interrupts disabled at that time in the MIPS kernel bringup then I'd
suggest you should open-code an smp_call_function() and put a big comment
over it explaining why it's done this way, and why it isn't deadlocky.

<tries to remember what the deadlock is>

If CPU A is running smp_call_function() it's waiting for CPU B to run the
handler.

But if CPU B is presently _also_ running smp_call_function(), it's waiting
for CPU A to run the handler.

If either of those CPUs is waiting for the other with local interrupts
disabled, that CPU will never respond to the other CPU's IPI and they'll
deadlock.
