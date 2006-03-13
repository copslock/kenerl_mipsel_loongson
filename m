Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 20:39:38 +0000 (GMT)
Received: from bender.bawue.de ([193.7.176.20]:51079 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133814AbWCMUja (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2006 20:39:30 +0000
Received: from lagash (unknown [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 4AFFC45655; Mon, 13 Mar 2006 21:48:32 +0100 (MET)
Received: from ths by lagash with local (Exim 4.60)
	(envelope-from <ths@networkno.de>)
	id 1FItyJ-0004yn-RK; Mon, 13 Mar 2006 20:48:55 +0000
Date:	Mon, 13 Mar 2006 20:48:55 +0000
To:	Kurt Schwemmer <kurts@vitesse.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cross compile kernel w/ buildroot toolchain
Message-ID: <20060313204855.GC15212@networkno.de>
References: <389E6A416914954182ECDFCD844D8269434FBE@MX-COS.vsc.vitesse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389E6A416914954182ECDFCD844D8269434FBE@MX-COS.vsc.vitesse.com>
User-Agent: Mutt/1.5.11+cvs20060126
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

On Mon, Mar 13, 2006 at 01:17:09PM -0700, Kurt Schwemmer wrote:
> I'm trying to figure out a toolchain to use for my system. I can compile
> the kernel just fine using the MIPS SDE based distribution, but you
> can't cross compile apps with that. I downloaded and built buildroot and
> I'm trying to (cross) compile the kernel with it too (I'd like to just
> use one compiler for everything). I had it use gcc 3.4.5. When I try to
> compile the kernel with:
> 
> make
> CROSS_COMPILE=~/buildroot/build_mipsel/staging_dir/bin/mipsel-linux-
> 
> I eventually get an error while assembling entry.o:
>   AS      arch/mips/kernel/entry.o
> arch/mips/kernel/entry.S: Assembler messages:
> arch/mips/kernel/entry.S:157: Error: opcode not supported on this
> processor: mips32 (mips32) `jr.hb $31'
> make[1]: *** [arch/mips/kernel/entry.o] Error 1
> make: *** [arch/mips/kernel] Error 2
> 
> I guess this is a "hazard barrier" instruction. Why doesn't gcc 3.4.5
> know about it? What do I need to do to get this to work?

It is gas which fails, because it either got fed options which don't
enable MIPS32R2, or because your version of binutils is very old and
doesn't know about jr.hb.

Compile with V=1 to find out the actual gcc invocation.


Thiemo
