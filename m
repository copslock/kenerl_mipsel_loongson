Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2007 22:34:08 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:23259 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20023264AbXIKVd7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Sep 2007 22:33:59 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IVDJq-0005CI-00
	for linux-mips@linux-mips.org; Tue, 11 Sep 2007 23:30:50 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id 47B27FAB72; Tue, 11 Sep 2007 23:30:48 +0200 (CEST)
Date:	Tue, 11 Sep 2007 23:30:48 +0200
To:	linux-mips@linux-mips.org
Subject: IP22 64bit kernel
Message-ID: <20070911213048.GA20579@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

I finally figured out, why 64bit SGI IP22 kernels are broken (at
least when booted with SGI sash). Looks like sash jumps to an uncached
XPHYS address instead of the KSEG0 address indicated by the ELF start.
This messes up bogomips calculation.

I found an interesting piece of code in head.S:

        .macro  ARC64_TWIDDLE_PC
#if defined(CONFIG_ARC64) || defined(CONFIG_MAPPED_KERNEL)
        /* We get launched at a XKPHYS address but the kernel is linked
 * to
           run at a KSEG0 address, so jump there.  */
        PTR_LA  t0, \@f
        jr      t0
\@:
#endif
        .endm


Enabling this for (CONFIG_SGI_IP22 && CONFIG_64BIT) fixes the boot problem.
It's not big deal to add this, but I'm wondering why we not just always
use this macro ? What platforms do it break with it ?

Thomas.
 
-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
