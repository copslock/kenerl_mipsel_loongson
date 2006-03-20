Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 04:31:56 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:47631 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133770AbWCTE3n (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Mar 2006 04:29:43 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 092F764D3D; Mon, 20 Mar 2006 04:39:21 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 0DA0166ED5; Mon, 20 Mar 2006 04:39:02 +0000 (GMT)
Date:	Mon, 20 Mar 2006 04:39:02 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	akpm@osdl.org
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 1/12] [MIPS] Improve description of VR41xx based machines
Message-ID: <20060320043902.GA20416@deprecation.cyrius.com>
References: <20060320043802.GA20389@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320043802.GA20389@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

MIPS supports various NEC VR41XX chips and not just the VR4100.
Update Kconfig accordingly, thereby bringing the file in sync with
the linux-mips tree.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>


--- linux-2.6/arch/mips/Kconfig	2006-03-13 18:45:54.000000000 +0000
+++ mips.git/arch/mips/Kconfig	2006-03-20 03:22:02.000000000 +0000
@@ -503,7 +503,7 @@
 	  ether port USB, AC97, PCI, etc.
 
 config MACH_VR41XX
-	bool "Support for NEC VR4100 series based machines"
+	bool "Support for NEC VR41XX-based machines"
 	select SYS_HAS_CPU_VR41XX
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
@@ -1134,7 +1134,7 @@
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	help
-	  The options selects support for the NEC VR4100 series of processors.
+	  The options selects support for the NEC VR41xx series of processors.
 	  Only choose this option if you have one of these processors as a
 	  kernel built with this option will not run on any other type of
 	  processor or vice versa.

-- 
Martin Michlmayr
http://www.cyrius.com/
