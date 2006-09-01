Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Sep 2006 18:39:04 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:30394 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038524AbWIARjC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Sep 2006 18:39:02 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 0812C46590; Fri,  1 Sep 2006 19:39:21 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GJCxO-00067I-9x; Fri, 01 Sep 2006 18:37:30 +0100
Date:	Fri, 1 Sep 2006 18:37:30 +0100
To:	Jonathan Day <imipak@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Broadcom SB1 query
Message-ID: <20060901173730.GC4893@networkno.de>
References: <20060901163839.49311.qmail@web31504.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901163839.49311.qmail@web31504.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Jonathan Day wrote:
> Hi,
> 
> Can anyone verify that the current kernel in
> linux-mips git archive will work on a Broadcom 1250
> (SB1), specifically the "Swarm" or the "Sentosa"
> flavours of the BCM91250.

A 2.6.18-rc4 from a one week old git checkout works fine on a SWARM
here, booted via tftp. The same kernel fails to boot on another
SWARM board from the onboard IDE, I guess the swarm-ide is currently
broken.

> I have not been able to get anything more recent than
> a 2.6.17 kernel to compile and boot, the 2.6.18-rc
> kernels seem to randomly either lock up or reboot very
> early on in the kernel initialization. However, I am
> undecided whether it's a kernel issue,

I presume you know that PCI devices and more than 1 GB of RAM don't
work under Linux.

> a hardware
> issue (we've had nothing but trouble from these
> boards) or a toolchain issue (versions: gcc 4.1.1,
> libc 2.4, binutils 2.17.50) as I've found a few large
> projects that should compile just fine are blowing the
> compiler up.

Hm, libc 2.4 means NPTL, that's not yet widely deployed and could well
account for some exciting failures.

> If someone can post (or e-mail me direct) on what the
> latest combination of kernel and toolchain that works
> on the Swarm is, I would greatly appreciate it. This
> problem is driving me nuts. (Ok, more nuts than
> usual.)

Current Debian unstable works for me.


Thiemo
