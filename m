Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Dec 2003 03:18:26 +0000 (GMT)
Received: from p508B6095.dip.t-dialin.net ([IPv6:::ffff:80.139.96.149]:41098
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225425AbTLDDS0>; Thu, 4 Dec 2003 03:18:26 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hB43IMA0016785
	for <linux-mips@linux-mips.org>; Thu, 4 Dec 2003 04:18:23 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hB43ILOn016767
	for linux-mips@linux-mips.org; Thu, 4 Dec 2003 04:18:21 +0100
Date: Thu, 4 Dec 2003 04:18:19 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: Less generic kernels
Message-ID: <20031204031818.GA7212@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3702
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

A side effect of cleaning the processor specific code a while ago was that
every system was carrying every bit of cpu-specific code such as cache
code with it that Linux only had to offer.  I cleaned that, this are the
savings for two default configurations:

   text    data     bss     dec     hex filename
2388266  275076   92456 2755798  2a0cd6 vmlinux         defconfig	old
2385522  275076   92456 2753054  2a021e vmlinux         defconfig	new
                                                                                
-> 2744 bytes saved
                                                                                
2197189  641168  128048 2966405  2d4385 vmlinux         defconfig-ip27	old
2190310  641168  128048 2959526  2d28a6 vmlinux         defconfig-ip27	new
                                                                                
-> 6879 bytes saved

Of course this also means faster, more efficient code.

How to make use of this for a particular system?

Just provide a include/asm-mips/mach-<system>/cpu-feature-overrides.h file.
Any values you don't define in that file will receive default values from
include/asm-mips/cpu-features.h.

That means if a particular macro isn't a constant for a particular system,
just don't define the cpu_* macro that tests for it.  Better even, if you
don't know every little detail about your processor, just don't define the
test macro and Linux will 

Who gains most?

Obviously the most restrictive configurations gain most.  Generally that's
the case for typical embedded systems.  Most of the size reduction can be
achieved by knowing the cache line size in advance.  This means the kernel
will only carry one version for a particular processor around.

Oh, and this is a 2.6 only ...

  Ralf
