Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 00:34:38 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27025302AbbDCW1BVHSvV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 00:27:01 +0200
Date:   Fri, 3 Apr 2015 23:27:01 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH 38/48] MIPS: math-emu: Move long fixed-point support into an
 `ar' library
In-Reply-To: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.11.1504031856060.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46755
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

Complement 593d33fe [MIPS: math-emu: Move various objects into an ar 
library.] and also move sp_tlong.o, sp_flong.o, dp_tlong.o, and 
dp_flong.o into an `ar' library.  These objects implement long 
fixed-point format support that can be omitted from MIPS I, MIPS II and 
MIPS32r1 configurations.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
Ralf,

 Please note however that contrary to your comment for 593d33fe 
sp_sqrt.o and dp_sqrt.o will be omitted from MIPS I configurations only.

  Maciej

linux-mips-emu-lib.diff
Index: linux/arch/mips/math-emu/Makefile
===================================================================
--- linux.orig/arch/mips/math-emu/Makefile	2015-04-02 20:18:48.993504000 +0100
+++ linux/arch/mips/math-emu/Makefile	2015-04-02 20:27:57.896229000 +0100
@@ -2,12 +2,15 @@
 # Makefile for the Linux/MIPS kernel FPU emulation.
 #
 
-obj-y	+= cp1emu.o ieee754dp.o ieee754sp.o ieee754.o dp_div.o dp_mul.o \
-	   dp_sub.o dp_add.o dp_fsp.o dp_cmp.o dp_simple.o dp_tint.o \
-	   dp_fint.o dp_tlong.o dp_flong.o sp_div.o sp_mul.o sp_sub.o \
-	   sp_add.o sp_fdp.o sp_cmp.o sp_simple.o sp_tint.o sp_fint.o \
-	   sp_tlong.o sp_flong.o dsemul.o
+obj-y	+= cp1emu.o ieee754dp.o ieee754sp.o ieee754.o \
+	   dp_div.o dp_mul.o dp_sub.o dp_add.o dp_fsp.o dp_cmp.o dp_simple.o \
+	   dp_tint.o dp_fint.o \
+	   sp_div.o sp_mul.o sp_sub.o sp_add.o sp_fdp.o sp_cmp.o sp_simple.o \
+	   sp_tint.o sp_fint.o \
+	   dsemul.o
 
-lib-y	+= ieee754d.o dp_sqrt.o sp_sqrt.o
+lib-y	+= ieee754d.o \
+	   dp_tlong.o dp_flong.o dp_sqrt.o \
+	   sp_tlong.o sp_flong.o sp_sqrt.o
 
 obj-$(CONFIG_DEBUG_FS) += me-debugfs.o
