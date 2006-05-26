Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 May 2006 17:46:00 +0200 (CEST)
Received: from rtsoft2.corbina.net ([85.21.88.2]:23739 "HELO
	mail.dev.rtsoft.ru") by ftp.linux-mips.org with SMTP
	id S8133780AbWEZPpv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 26 May 2006 17:45:51 +0200
Received: (qmail 4880 invoked from network); 26 May 2006 19:53:42 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 26 May 2006 19:53:42 -0000
Message-ID: <44772276.2020005@ru.mvista.com>
Date:	Fri, 26 May 2006 19:44:54 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Linux MIPS <linux-mips@linux-mips.org>
CC:	Jordan Crouse <jordan.crouse@amd.com>, ralf@linux-mips.org
Subject: [PATCH] Save write-only Config.OD from being clobbered (take 4)
References: <20051122205938.GR18119@cosmic.amd.com> <43838957.2020106@ru.mvista.com> <442457A6.4080508@dev.rtsoft.ru> <44767979.6020106@ru.mvista.com>
In-Reply-To: <44767979.6020106@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------040907030909060805030307"
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040907030909060805030307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

    Save the Config.OD bit from being clobbered by coherency_setup(). This
bit, when set, fixes various errata in the early steppings of Au1x00 SOCs.
Unfortunately, the bit was write-only on the most early of them. In
addition, also restore the bit after a wakeup from sleep.

WBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------040907030909060805030307
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
@@ -1136,6 +1136,31 @@ static void __init setup_scache(void)
 	c->options |= MIPS_CPU_SUBSET_CACHES;
 }
 
+void au1x00_fixup_config_od(void)
+{
+	/*
+	 * c0_config.od (bit 19) was write only (and read as 0)
+	 * on the early revisions of Alchemy SOCs.  It disables the bus
+	 * transaction overlapping and needs to be set to fix various errata.
+	 */
+	switch (read_c0_prid()) {
+	case 0x00030100: /* Au1000 DA */
+	case 0x00030201: /* Au1000 HA */
+	case 0x00030202: /* Au1000 HB */
+	case 0x01030200: /* Au1500 AB */
+	/*
+	 * Au1100 errata actually keeps silence about this bit, so we set it
+	 * just in case for those revisions that require it to be set according
+	 * to arch/mips/au1000/common/cputable.c
+	 */
+	case 0x02030200: /* Au1100 AB */
+	case 0x02030201: /* Au1100 BA */
+	case 0x02030202: /* Au1100 BC */
+		set_c0_config(1 << 19);
+		break;
+	}
+}
+
 static inline void coherency_setup(void)
 {
 	change_c0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);
@@ -1156,6 +1181,15 @@ static inline void coherency_setup(void)
 	case CPU_R4400MC:
 		clear_c0_config(CONF_CU);
 		break;
+	/*
+	 * We need to catch the ealry Alchemy SOCs with
+	 * the write-only co_config.od bit and set it back to one...
+	 */
+	case CPU_AU1000: /* rev. DA, HA, HB */
+	case CPU_AU1100: /* rev. AB, BA, BC ?? */
+	case CPU_AU1500: /* rev. AB */
+		au1x00_fixup_config_od();
+		break;
 	}
 }
 


--------------040907030909060805030307--
