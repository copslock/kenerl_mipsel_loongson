Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Aug 2007 16:07:10 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:10182 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20026185AbXHFPHI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Aug 2007 16:07:08 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1II4Af-0006Qa-Gj; Mon, 06 Aug 2007 17:07:01 +0200
Date:	Mon, 6 Aug 2007 17:07:01 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org
Cc:	Michael Buesch <mb@bu3sch.de>, Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: [PATCH -mm 0/4] MIPS BCM947xx CPUs support
Message-ID: <20070806150701.GE24308@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

The following series of patches add basic support for the BCM947xx 
CPUs. CFE support still needs work and thus is not included in those 
patches, so the command line has to be included in the kernel. 
Everything else is fully functional and the resulting kernel works
fine on a Netgear WGT634U.

I am submitting those patches for inclusion into -mm as they depend
on features that are not present in the linux-mips git tree, but are
present in the -mm series, namely Sonic Silicon Backplane bus support.

Patch #1: MIPS: Detect BCM947xx CPUs
Patch #2: MIPS: BCM947xx support
Patch #3: MIPS: Add BCM947XX to Kconfig
Patch #4: MIPS: Add BCM947xx to Makefile

Cc: Michael Buesch <mb@bu3sch.de>
Cc: Waldemar Brodkorb <wbx@openwrt.org>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Florian Schirmer <jolt@tuxbox.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
