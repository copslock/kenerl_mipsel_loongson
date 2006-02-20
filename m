Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 00:05:03 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:54797 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133727AbWBTAEs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Feb 2006 00:04:48 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 6CE2E64D3D; Mon, 20 Feb 2006 00:11:33 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 61BFF8D5D; Mon, 20 Feb 2006 00:11:26 +0000 (GMT)
Date:	Mon, 20 Feb 2006 00:11:26 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	yoichi_yuasa@tripeaks.co.jp
Subject: Re: Diff between Linus' and linux-mips git: VR4181
Message-ID: <20060220001126.GA17967@deprecation.cyrius.com>
References: <20060219234318.GA16311@deprecation.cyrius.com> <20060220000141.GX10266@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220000141.GX10266@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

It seems the following VR4181 change never made it into mainline.


--- linux-2.6.16-rc4/arch/mips/Kconfig	2006-02-19 20:08:02.000000000 +0000
+++ mips-2.6.16-rc4/arch/mips/Kconfig	2006-02-19 20:14:36.000000000 +0000
@@ -503,10 +503,7 @@
 	  ether port USB, AC97, PCI, etc.
 
 config MACH_VR41XX
-	bool "Support for NEC VR4100 series based machines"
-	select SYS_HAS_CPU_VR41XX
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_64BIT_KERNEL if EXPERIMENTAL
+	bool "Support for NEC VR41XX-based machines"
 
 config PMC_YOSEMITE
 	bool "Support for PMC-Sierra Yosemite eval board"
@@ -1019,6 +1016,9 @@
 config HAVE_STD_PC_SERIAL_PORT
 	bool
 
+config VR4181
+	bool
+
 config ARC_CONSOLE
 	bool "ARC console support"
 	depends on SGI_IP22 || SNI_RM200_PCI
@@ -1130,7 +1130,7 @@
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	help
-	  The options selects support for the NEC VR4100 series of processors.
+	  The options selects support for the NEC VR41xx series of processors.
 	  Only choose this option if you have one of these processors as a
 	  kernel built with this option will not run on any other type of
 	  processor or vice versa.
--- linux-2.6.16-rc4/arch/mips/kernel/cpu-probe.c	2006-02-19 20:08:04.000000000 +0000
+++ mips-2.6.16-rc4/arch/mips/kernel/cpu-probe.c	2006-02-19 20:14:37.000000000 +0000
@@ -242,9 +242,15 @@
 		break;
 	case PRID_IMP_VR41XX:
 		switch (c->processor_id & 0xf0) {
+#ifndef CONFIG_VR4181
 		case PRID_REV_VR4111:
 			c->cputype = CPU_VR4111;
 			break;
+#else
+		case PRID_REV_VR4181:
+			c->cputype = CPU_VR4181;
+			break;
+#endif
 		case PRID_REV_VR4121:
 			c->cputype = CPU_VR4121;
 			break;

-- 
Martin Michlmayr
http://www.cyrius.com/
