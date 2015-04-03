Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:24:42 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025242AbbDCWXuv6QAg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:23:50 +0200
Date:   Fri, 3 Apr 2015 23:23:50 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 04/48] MIPS: mipsregs.h: Move TX39 macros out of the way
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030136340.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

TX39 CP0 Configuration Register 3 macro definitions have been randomly 
thrown in the middle of a block of CP0 Status register value macros.  
Move them to the end of the whole CP0 register value macro block, 
complementing the location of the TX39 Cache register name macro at the 
end of the CP0 register name macro block.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-regs-tx39-conf.diff
Index: linux/arch/mips/include/asm/mipsregs.h
===================================================================
--- linux.orig/arch/mips/include/asm/mipsregs.h	2015-04-02 20:27:51.855157000 +0100
+++ linux/arch/mips/include/asm/mipsregs.h	2015-04-02 20:27:52.045161000 +0100
@@ -277,39 +277,6 @@
 #define ST0_MX			0x01000000
 
 /*
- * Bitfields in the TX39 family CP0 Configuration Register 3
- */
-#define TX39_CONF_ICS_SHIFT	19
-#define TX39_CONF_ICS_MASK	0x00380000
-#define TX39_CONF_ICS_1KB	0x00000000
-#define TX39_CONF_ICS_2KB	0x00080000
-#define TX39_CONF_ICS_4KB	0x00100000
-#define TX39_CONF_ICS_8KB	0x00180000
-#define TX39_CONF_ICS_16KB	0x00200000
-
-#define TX39_CONF_DCS_SHIFT	16
-#define TX39_CONF_DCS_MASK	0x00070000
-#define TX39_CONF_DCS_1KB	0x00000000
-#define TX39_CONF_DCS_2KB	0x00010000
-#define TX39_CONF_DCS_4KB	0x00020000
-#define TX39_CONF_DCS_8KB	0x00030000
-#define TX39_CONF_DCS_16KB	0x00040000
-
-#define TX39_CONF_CWFON		0x00004000
-#define TX39_CONF_WBON		0x00002000
-#define TX39_CONF_RF_SHIFT	10
-#define TX39_CONF_RF_MASK	0x00000c00
-#define TX39_CONF_DOZE		0x00000200
-#define TX39_CONF_HALT		0x00000100
-#define TX39_CONF_LOCK		0x00000080
-#define TX39_CONF_ICE		0x00000020
-#define TX39_CONF_DCE		0x00000010
-#define TX39_CONF_IRSIZE_SHIFT	2
-#define TX39_CONF_IRSIZE_MASK	0x0000000c
-#define TX39_CONF_DRSIZE_SHIFT	0
-#define TX39_CONF_DRSIZE_MASK	0x00000003
-
-/*
  * Status register bits available in all MIPS CPUs.
  */
 #define ST0_IM			0x0000ff00
@@ -673,6 +640,39 @@
 #define MIPS_PWCTL_PSN_SHIFT	0
 #define MIPS_PWCTL_PSN_MASK	0x0000003f
 
+/*
+ * Bitfields in the TX39 family CP0 Configuration Register 3
+ */
+#define TX39_CONF_ICS_SHIFT	19
+#define TX39_CONF_ICS_MASK	0x00380000
+#define TX39_CONF_ICS_1KB	0x00000000
+#define TX39_CONF_ICS_2KB	0x00080000
+#define TX39_CONF_ICS_4KB	0x00100000
+#define TX39_CONF_ICS_8KB	0x00180000
+#define TX39_CONF_ICS_16KB	0x00200000
+
+#define TX39_CONF_DCS_SHIFT	16
+#define TX39_CONF_DCS_MASK	0x00070000
+#define TX39_CONF_DCS_1KB	0x00000000
+#define TX39_CONF_DCS_2KB	0x00010000
+#define TX39_CONF_DCS_4KB	0x00020000
+#define TX39_CONF_DCS_8KB	0x00030000
+#define TX39_CONF_DCS_16KB	0x00040000
+
+#define TX39_CONF_CWFON		0x00004000
+#define TX39_CONF_WBON		0x00002000
+#define TX39_CONF_RF_SHIFT	10
+#define TX39_CONF_RF_MASK	0x00000c00
+#define TX39_CONF_DOZE		0x00000200
+#define TX39_CONF_HALT		0x00000100
+#define TX39_CONF_LOCK		0x00000080
+#define TX39_CONF_ICE		0x00000020
+#define TX39_CONF_DCE		0x00000010
+#define TX39_CONF_IRSIZE_SHIFT	2
+#define TX39_CONF_IRSIZE_MASK	0x0000000c
+#define TX39_CONF_DRSIZE_SHIFT	0
+#define TX39_CONF_DRSIZE_MASK	0x00000003
+
 
 /*
  * Coprocessor 1 (FPU) register names
