Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2004 14:42:29 +0100 (BST)
Received: from smtp.seznam.cz ([IPv6:::ffff:212.80.76.43]:6548 "HELO
	smtp.seznam.cz") by linux-mips.org with SMTP id <S8225551AbUF2NmZ>;
	Tue, 29 Jun 2004 14:42:25 +0100
Received: (qmail 306 invoked from network); 29 Jun 2004 13:42:13 -0000
Received: from unknown (HELO umax645sx) (Ladislav.Michl@160.218.40.4)
  by smtp.seznam.cz with SMTP; 29 Jun 2004 13:42:13 -0000
Received: from ladis by umax645sx with local (Exim 3.36 #1 (Debian))
	id 1BfIsJ-0000nK-00; Tue, 29 Jun 2004 15:42:15 +0200
Date: Tue, 29 Jun 2004 15:42:14 +0200
To: Linux MIPS <linux-mips@linux-mips.org>
Cc: Jorik Jonker <linux-mips@boeventronie.net>
Subject: Re: VINO
Message-ID: <20040629134213.GA2968@umax645sx>
References: <20040608125437.GC19965@hydrogen.boeventronie.net> <20040608220604.GA2578@umax645sx> <20040609122046.GB18364@hydrogen.boeventronie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609122046.GB18364@hydrogen.boeventronie.net>
User-Agent: Mutt/1.5.6+20040523i
From: Ladislav Michl <ladis@linux-mips.org>
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 09, 2004 at 02:20:46PM +0200, Jorik Jonker wrote:
> Well, it seems not that easy for me. As I told, it's very opaque matter to
> me; ie I already figured out that a kernel driver must be built but I really
> have no clue on how to do this. For instance, I don't know what call (if
> there exists any) should access that memory.

PHYS_TO_K1 macro from <sys/mips_addrspace.h> does the trick. Just use
something like:

#define VINO_BASE 0x00080000
unsigned int reg = * (unsigned int *) PHYS_TO_K1(VINO_BASE + ofs);

Note that VINO registers are 64bit, but only lower 32bits are relevant for
us (the only exception is valid bit in descriptor cache register, which
is not important in this case). Please refer to VINO Design
Specification for more details:
ftp://ftp.linux-mips.org/pub/linux/mips/doc/indy/vino/

> My plan was on writing a driver which allows me (through an ioctl to a special
> device) to read/write to the VINO registers. I think I saw a driver example
> in the DevDriver_PG which shows how to communicate through ioctl with
> userspace (or kernelspace, depends on how you look at it), but the part where
> I do the actual 'talking' to the VINO is matter I don't have any clue on how
> to do that.

I hope you'll find time to make your plan reality.

Best regars,
	ladis
