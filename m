Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 01:45:19 +0100 (BST)
Received: from hall.aurel32.net ([88.191.38.19]:30370 "EHLO hall.aurel32.net")
	by ftp.linux-mips.org with ESMTP id S20021681AbXHIApL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2007 01:45:11 +0100
Received: from aurel32 by hall.aurel32.net with local (Exim 4.63)
	(envelope-from <aurel32@hall.aurel32.net>)
	id 1IIw69-0001P7-0g; Thu, 09 Aug 2007 02:41:57 +0200
Date:	Thu, 9 Aug 2007 02:41:56 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	linux-mips@linux-mips.org
Cc:	Andrew Morton <akpm@linux-foundation.org>, mb@bu3sch.de,
	nbd@openwrt.org, jolt@tuxbox.org
Subject: [PATCH 0/4][RFC] MIPS BCM947xx CPUs support
Message-ID: <20070809004156.GA4682@hall.aurel32.net>
References: <20070806150900.GG24308@hall.aurel32.net> <200708062005.29657.mb@bu3sch.de> <20070806183316.GB32465@hall.aurel32.net> <200708062037.05995.mb@bu3sch.de> <20070806191712.GA2019@hall.aurel32.net> <20070807094045.2c6eaa38.yoichi_yuasa@tripeaks.co.jp> <20070807121638.GA9953@hall.aurel32.net> <20070807183302.1e38a4df.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20070807183302.1e38a4df.akpm@linux-foundation.org>
X-Mailer: Mutt 1.5.13 (2006-08-11)
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <aurel32@hall.aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Hi,

Thanks a lot for all your comments. You will find in the next mails a
new version of the BCM947xx patches which include fixes for your
comments. The big changes concerns the serial driver which now uses a
platform driver for the configuration. This fixes the case where
CONFIG_SERIAL_8250=m.

Given the current mess wrt SSB patches, I don't ask them to be merged
now, but if would be nice if you can review them. Thanks.

Regards,
Aurelien


The following series of patches add basic support for the BCM947xx 
CPUs. CFE support still needs work and thus is not included in those 
patches, so the command line has to be included in the kernel. 
Everything else is fully functional and the resulting kernel works
fine on a Netgear WGT634U.

Patch #1: MIPS: Detect BCM947xx CPUs
Patch #2: MIPS: BCM947xx support
Patch #3: MIPS: Add BCM947XX to Kconfig
Patch #4: MIPS: Add BCM947xx to Makefile

Cc: Michael Buesch <mb@bu3sch.de>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Florian Schirmer <jolt@tuxbox.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
