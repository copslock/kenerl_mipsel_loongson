Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 14:08:51 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:46866 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133607AbWAROIc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jan 2006 14:08:32 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 11F8664D54; Wed, 18 Jan 2006 14:11:29 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 0CD458456; Wed, 18 Jan 2006 14:10:59 +0000 (GMT)
Date:	Wed, 18 Jan 2006 14:10:59 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: CONFIG_64BIT and CONFIG_BUILD_ELF64
Message-ID: <20060118141059.GU6827@deprecation.cyrius.com>
References: <20060118123110.GA21786@deprecation.cyrius.com> <Pine.LNX.4.64N.0601181240090.18424@blysk.ds.pg.gda.pl> <20060118125127.GA3555@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118125127.GA3555@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2006-01-18 12:51]:
> At this stage support for gcc 2.95 is decaying and soon may be removed
> entirely from the kernel.  So the time to hardwire CONFIG_BUILD_ELF64=y
> may have come.

[mips] Enable BUILD_ELF64 when 64BIT is set

New toolchain does not support building 32-bit ELF objects with 64-bit
code, so we enable BUILD_ELF64 when 64bit is on.

Ralf Baechle: "At this stage support for gcc 2.95 is decaying and soon
may be removed entirely from the kernel.  So the time to hardwire
CONFIG_BUILD_ELF64=y may have come."

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

---
 Kconfig |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- linux-mips/arch/mips/Kconfig	2006-01-10 11:21:15.000000000 +0000
+++ new/arch/mips/Kconfig	2006-01-18 14:07:15.000000000 +0000
@@ -1722,17 +1722,7 @@
 config BUILD_ELF64
 	bool "Use 64-bit ELF format for building"
 	depends on 64BIT
-	help
-	  A 64-bit kernel is usually built using the 64-bit ELF binary object
-	  format as it's one that allows arbitrary 64-bit constructs.  For
-	  kernels that are loaded within the KSEG compatibility segments the
-	  32-bit ELF format can optionally be used resulting in a somewhat
-	  smaller binary, but this option is not explicitly supported by the
-	  toolchain and since binutils 2.14 it does not even work at all.
-
-	  Say Y to use the 64-bit format or N to use the 32-bit one.
-
-	  If unsure say Y.
+	default y
 
 config BINFMT_IRIX
 	bool "Include IRIX binary compatibility"

-- 
Martin Michlmayr
http://www.cyrius.com/
