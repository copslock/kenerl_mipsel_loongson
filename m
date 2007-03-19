Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 14:50:04 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:6807 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20021875AbXCSOt7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 14:49:59 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id 88A35B82D2;
	Mon, 19 Mar 2007 15:45:06 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1HTJ6w-00012d-CO; Mon, 19 Mar 2007 14:45:22 +0000
Date:	Mon, 19 Mar 2007 14:45:22 +0000
To:	Kumba <kumba@gentoo.org>
Cc:	Franck <vagabon.xyz@gmail.com>,
	Linux MIPS List <linux-mips@linux-mips.org>,
	Arnaud Giersch <arnaud.giersch@free.fr>
Subject: Re: IP32 prom crashes due to __pa() funkiness
Message-ID: <20070319144522.GB28895@networkno.de>
References: <45D8B070.7070405@gentoo.org> <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com> <45FC46F0.3070300@gentoo.org> <87irczzglc.fsf@groumpf.homeip.net> <45FC9E39.7010506@gentoo.org> <45FE95EE.5030108@innova-card.com> <45FE9D22.1030407@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45FE9D22.1030407@gentoo.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Kumba wrote:
[snip]
> Most of this is because IP22 (Indy/Idigo2 R4xx) and IP32 (O2 R5xxx), while 
> supporting 64bit kernels (same for cobalt, since it's a mips4-level CPU), 
> we had to "trick" them into accepting 64bit code.  IP32 at one point ran 
> 32bit kernels only, but it was later converted to supporting only 64bit 
> kernels, hence the hackery involved.  We describe it as wrapping 64bit code 
> into a 32bit object, because their proms will only recognize 32bit objects 
> (specifically, IP22 will only boot 32bit objects; crash on 64bit; IP32 will 
> take both, but likes 32bit better).
> 
> So really, CONFIG_BUILD_ELF64 was probably part of this "magic" to stuff 
> 64bit code into a candy-coated 32bit wrapper for the Indy (And later the 
> O2) to suck down w/o complaint.  Hence, __pa() probably needs to replicate 
> this support, or we all need to brainstorm a proper way to get these 
> systems to boot.

BUILD_ELF64 + -sym32 + objcopy into a ELF32 file is supposed to be the
full replacement for the old o64-in-o32 hack.

> Octane, Origin, IP28 (Indigo2 R10000). et al, don't complain, and don't 
> need this hacker, because their proms boot proper 64bit binaries only (they 
> reject all else).
> 
> So probably the following is true (someone correct me if not)
> 
> if (CONFIG_BUILD_ELF64=y and (!CONFIG_SGI_IP22 or !CONFIG_SGI_IP32 or 
> !CONFIG_COBALT)) then kernel load address must be in XKPHYS
> else load address must be in CKSEG0
> if CONFIG_BUILD_ELF64=n then kernel load address must be in CKSEG0

The 64/64 configs can do both:

                      |  BUILD_ELF64  | BUILD_ELF32
---------------------------------------------------
64bit firmware loader | CKSEG0/XKPHYS |   CKSEG0
32bit firmware loader |     CKSEG0    |   CKSEG0


Thiemo
