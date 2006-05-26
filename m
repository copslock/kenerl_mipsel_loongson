Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 05:45:03 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:38852 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133435AbWEZDoz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 May 2006 05:44:55 +0200
Received: (qmail 24580 invoked from network); 26 May 2006 07:52:44 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 26 May 2006 07:52:44 -0000
Message-ID: <44767979.6020106@ru.mvista.com>
Date:	Fri, 26 May 2006 07:43:53 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	Jordan Crouse <jordan.crouse@amd.com>, ralf@linux-mips.org
Subject: Re: [PATCH] Save write-only Config.OD from being clobbered
References: <20051122205938.GR18119@cosmic.amd.com> <43838957.2020106@ru.mvista.com> <442457A6.4080508@dev.rtsoft.ru>
In-Reply-To: <442457A6.4080508@dev.rtsoft.ru>
Content-Type: multipart/mixed;
 boundary="------------050206050908010208040503"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------050206050908010208040503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Save the Config.OD bit from being clobbered by coherency_setup(). This
bit, when set, fixes various errata in the early steppings of Au1x00 SOCs.
Unfortunately, the bit was write-only on the most early of them. In addition,
also restore the bit after a wakeup from sleep.

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------050206050908010208040503
Content-Type: text/plain;
 name="Au1x00-retain-OD-bit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Au1x00-retain-OD-bit.patch"

Index: linux-mips/arch/mips/au1000/common/sleeper.S
===================================================================
--- linux-mips.orig/arch/mips/au1000/common/sleeper.S
+++ linux-mips/arch/mips/au1000/common/sleeper.S
@@ -112,6 +112,11 @@ sdsleep:
 	mtc0	k0, CP0_PAGEMASK
 	lw	k0, 0x14(sp)
 	mtc0	k0, CP0_CONFIG
+
+	/* We need to catch the ealry Alchemy SOCs with
+	 * the write-only Config[OD] bit and set it back to one...
+	 */
+	jal	au1x00_fixup_config_od
 	lw	$1, PT_R1(sp)
 	lw	$2, PT_R2(sp)
 	lw	$3, PT_R3(sp)
Index: linux-mips/arch/mips/mm/c-r4k.c
===================================================================
--- linux-mips.orig/arch/mips/mm/c-r4k.c
+++ linux-mips/arch/mips/mm/c-r4k.c
@@ -1136,6 +1136,26 @@ static void __init setup_scache(void)
 	c->options |= MIPS_CPU_SUBSET_CACHES;
 }
 
+void au1x00_fixup_config_od(void)
+{
+	/*
+	 * c0_config.od (bit 19) was write only (and read as 0)
+	 * on the early revisions of Alchemy SOCs.  It disables the bus
+	 * transaction overlapping and needs to be set to fix various errata.
+	 */
+	switch (current_cpu_data.cputype) {
+	case CPU_AU1000: /* rev. DA, HA, HB */
+	case CPU_AU1100: /* rev. AB, BA, BC ?? */
+		if ((read_c0_prid() & 0xff) < 3)
+			set_c0_config(1 << 19);
+		break;
+	case CPU_AU1500: /* rev. AB */
+		if ((read_c0_prid() & 0xff) < 1)
+			set_c0_config(1 << 19);
+		break;
+	}
+}
+
 static inline void coherency_setup(void)
 {
 	change_c0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
@@ -1156,6 +1176,13 @@ static inline void coherency_setup(void)
 	case CPU_R4400MC:
 		clear_c0_config(CONF_CU);
 		break;
+	default:
+		/*
+		 * We need to catch the ealry Alchemy SOCs with
+		 * the write-only co_config.od bit and set it back to one...
+		 */
+		au1x00_fixup_config_od();
+		break;
 	}
 }
 



--------------050206050908010208040503--
