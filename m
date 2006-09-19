Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Sep 2006 18:16:29 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:34539 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S20038644AbWISRQ1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Sep 2006 18:16:27 +0100
Received: from lagash (mipsfw.mips-uk.com [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id C041944A5F; Tue, 19 Sep 2006 19:16:26 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GPjCq-00063D-6n; Tue, 19 Sep 2006 18:16:24 +0100
Date:	Tue, 19 Sep 2006 18:16:24 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Eric DeVolder <edevolder@razamicroelectronics.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Differing results from cross and native compilers
Message-ID: <20060919171624.GA24864@networkno.de>
References: <2E96546B3C2C8B4CA739323C6058204A0163548C@hq-ex-mb01.razamicroelectronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E96546B3C2C8B4CA739323C6058204A0163548C@hq-ex-mb01.razamicroelectronics.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Eric DeVolder wrote:
> Yes, it appears to me that the compiler (cc1) and assembler (as)
> invocations are the same. I've included the "-v" output of each
> below for reference. Furthermore, the -save-temps output .i files
> are effectively the same (differences due to cross vs. native paths,
> but that is it). Nonetheless, the output assembly source still
> contains differences!
>  
> I'm curious if anybody examined the output of a cross and native
> toolchain of the same (recent) version?

I get the same (properly optimised) result from both compilers:

  gcc (GCC) 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)
  mips-linux-gnu-gcc (GCC) 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)


I haven't tried a 3.4 crosscompiler, but the native one also behaves
as expected:

  gcc-3.4 (GCC) 3.4.6 (Debian 3.4.6-4)


Thiemo
