Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:24:58 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025243AbbDCWX4QJCNB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:23:56 +0200
Date:   Fri, 3 Apr 2015 23:23:56 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 05/48] MIPS: mipsregs.h: Reindent CP0 Cause macros
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504030146310.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46722
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

Reindent CP0 Cause macros for a single space after #define, leaving 
extra indentation for individual Interrupt Pending bits as with CP0 
Status register's Interrupt Mask bits.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-regs-cause.diff
Index: linux/arch/mips/include/asm/mipsregs.h
===================================================================
--- linux.orig/arch/mips/include/asm/mipsregs.h	2015-04-02 20:27:52.045161000 +0100
+++ linux/arch/mips/include/asm/mipsregs.h	2015-04-02 20:27:52.242161000 +0100
@@ -339,10 +339,10 @@
  *
  * Refer to your MIPS R4xx0 manual, chapter 5 for explanation.
  */
-#define	 CAUSEB_EXCCODE		2
-#define	 CAUSEF_EXCCODE		(_ULCAST_(31)  <<  2)
-#define	 CAUSEB_IP		8
-#define	 CAUSEF_IP		(_ULCAST_(255) <<  8)
+#define CAUSEB_EXCCODE		2
+#define CAUSEF_EXCCODE		(_ULCAST_(31)  <<  2)
+#define CAUSEB_IP		8
+#define CAUSEF_IP		(_ULCAST_(255) <<  8)
 #define	 CAUSEB_IP0		8
 #define	 CAUSEF_IP0		(_ULCAST_(1)   <<  8)
 #define	 CAUSEB_IP1		9
@@ -359,16 +359,16 @@
 #define	 CAUSEF_IP6		(_ULCAST_(1)   << 14)
 #define	 CAUSEB_IP7		15
 #define	 CAUSEF_IP7		(_ULCAST_(1)   << 15)
-#define	 CAUSEB_IV		23
-#define	 CAUSEF_IV		(_ULCAST_(1)   << 23)
-#define	 CAUSEB_PCI		26
-#define	 CAUSEF_PCI		(_ULCAST_(1)   << 26)
-#define	 CAUSEB_CE		28
-#define	 CAUSEF_CE		(_ULCAST_(3)   << 28)
-#define	 CAUSEB_TI		30
-#define	 CAUSEF_TI		(_ULCAST_(1)   << 30)
-#define	 CAUSEB_BD		31
-#define	 CAUSEF_BD		(_ULCAST_(1)   << 31)
+#define CAUSEB_IV		23
+#define CAUSEF_IV		(_ULCAST_(1)   << 23)
+#define CAUSEB_PCI		26
+#define CAUSEF_PCI		(_ULCAST_(1)   << 26)
+#define CAUSEB_CE		28
+#define CAUSEF_CE		(_ULCAST_(3)   << 28)
+#define CAUSEB_TI		30
+#define CAUSEF_TI		(_ULCAST_(1)   << 30)
+#define CAUSEB_BD		31
+#define CAUSEF_BD		(_ULCAST_(1)   << 31)
 
 /*
  * Bits in the coprocessor 0 config register.
