Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2007 20:02:29 +0100 (BST)
Received: from phoenix.bawue.net ([193.7.176.60]:25786 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20022038AbXC0TC1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2007 20:02:27 +0100
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id E389F84513;
	Tue, 27 Mar 2007 21:00:52 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HWGuy-00041H-7J; Tue, 27 Mar 2007 20:01:16 +0100
Date:	Tue, 27 Mar 2007 20:01:16 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	kumba@gentoo.org, linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
Message-ID: <20070327190116.GH23564@networkno.de>
References: <4607CF1D.50904@gentoo.org> <20070326.234316.23009158.anemo@mba.ocn.ne.jp> <46086A90.7070402@gentoo.org> <20070327.235310.128618679.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070327.235310.128618679.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Mon, 26 Mar 2007 20:51:28 -0400, Kumba <kumba@gentoo.org> wrote:
> > Lets try this one; the kernel was built with gcc-4.1.2 and binutils-2.17 this 
> > time around, and I tested it before running objdump on it.  It just hangs right 
> > after loading:
> > 
> >  > bootp(): console=ttyS0,38400 root=/dev/md0
> > Setting $netaddr to 192.168.1.12 (from server )
> > Obtaining  from server
> > 4358278+315290 entry: 0x80401000
> 
> Now I can not see any problem with the disassembled code.  No idea why
> it does not work at all...
> 
> BTW, why IP32 does not support 32-bit kernel, though it has 32-bit
> firmware?

It wants to do 64bit register accesses, and supports more memory than
KSEG0 can hold. The resulting 32bit kernel was ugly enough to kill it
and replace it with a 64bit one.


Thiemo
