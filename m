Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 May 2009 19:06:49 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:55170 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S20025889AbZEJSGn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 10 May 2009 19:06:43 +0100
Received: (qmail invoked by alias); 10 May 2009 18:06:36 -0000
Received: from p548B20B0.dip0.t-ipconnect.de (EHLO [192.168.120.26]) [84.139.32.176]
  by mail.gmx.net (mp006) with SMTP; 10 May 2009 20:06:36 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX19maj8UezRmwkJxKuLc1Sa1MJe35HxDwvHqkQ+VF3
	v1hVh8fpzpRVVR
Message-ID: <4A0717AA.8060603@gmx.de>
Date:	Sun, 10 May 2009 20:06:34 +0200
From:	Johannes Dickgreber <tanzy@gmx.de>
User-Agent: Thunderbird 2.0.0.21 (X11/20090310)
MIME-Version: 1.0
To:	Kumba <kumba@gentoo.org>
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Help getting IP30/Octane fixed?
References: <4A06100F.7020105@gentoo.org>
In-Reply-To: <4A06100F.7020105@gentoo.org>
X-Enigmail-Version: 0.95.7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips

Kumba schrieb:
> Well, I've been keeping the Octane/IP30 port alive for quite some time
> lately, but the bitrot in the code is making the functionality get
> progressively worse.  As of 2.6.30, the following will _not_ work:
> 
> - SMP capabilities (hangs on boot)
This is whats wrong with SMP: from file include/asm/mach-ip30/heart.h

#define HEART_IMR(x)		((volatile ulong *)0x900000000ff10000 + (8 * (x)))

I schould be

#define HEART_IMR(x)		((volatile ulong *)0x900000000ff10000 + (x))

or it schould be

#define HEART_IMR(x)		((volatile ulong *) (0x900000000ff10000 + (8 * (x))))

The IRQ MASK Register for the different CPUs are side by side.
In your version the factor 8 is used twice. First explicit inside the braces
and second, because of the pointer to ulong implicit done by the
compiler.
I checked it by dissambling the code and my smp-kernel is working if i start
only with one cpu. With 2 cpus the smp-kernel is booting, but the init process
hangs then.


> 5012_2.6.22-ioc3-revert_commit_691cd0c.patch
> 
> This is a reversal of a patch committed to upstream almost 2 years ago
> (possibly longer), which broke IOC3 (when using the above metadriver) by
> making Linux enforce adherence to the PCI specification (I think,
> anyways.  It's been too long).  Without reversing this patch, none of
> the IOC3 sub-devices are accessible.
> 
> Original submission of it (with description) is here:
> http://lkml.org/lkml/2007/1/26/67
> 
the revert is not needed anymore, because of code in arch/mips/pci/ops-bridge.c
look for the function emulate_ioc3_cfg
> 
> 5041_2.6.30-ip30-octane-support-r28.patch
> 
> This is the base code for the Octane port.  I've largely maintained it
> via bandaid fixes, but even bandaids can't keep a ship from sinking
> forever.  I managed to figure out the IRQ stuff to move Octane to using
> set_irq_and_chip_handler, which got it booting again, but this broke the
> Impact video driver, which will oops the kernel on initialization.  SMP
> code broke back in 2.6.24 due to improper conversion to dyntick, and
> I've never been able to figure out why, because my only SMP CPU module
> turned out to have died while in storage.
> 
> 
> So if anyone wants to help, take a look, and let me know if there are
> any questions.  I'll answer what I can.
> 
> Thanks!,
> 
I hope it helps

i have done some more work on the older patches and have a working kernel.
if someone wants this patch, i can send it.


bye  
