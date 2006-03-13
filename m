Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2006 20:24:25 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:28326 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133791AbWCMUYO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2006 20:24:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2DKXHqo016740;
	Mon, 13 Mar 2006 20:33:17 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2DKXGN3016739;
	Mon, 13 Mar 2006 20:33:16 GMT
Date:	Mon, 13 Mar 2006 20:33:16 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kurt Schwemmer <kurts@vitesse.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Cross compile kernel w/ buildroot toolchain
Message-ID: <20060313203316.GA16609@linux-mips.org>
References: <389E6A416914954182ECDFCD844D8269434FBE@MX-COS.vsc.vitesse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389E6A416914954182ECDFCD844D8269434FBE@MX-COS.vsc.vitesse.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

I'm looking at the latest kernel sources and can't see how this could be
happening.  Which version of the kernel are you trying to build?

  Ralf
