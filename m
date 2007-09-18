Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2007 14:45:33 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:1702 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021879AbXIRNpX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Sep 2007 14:45:23 +0100
Received: (qmail 26049 invoked by uid 511); 18 Sep 2007 13:56:18 -0000
Received: from unknown (HELO ?172.16.2.41?) (222.92.8.142)
  by lemote.com with SMTP; 18 Sep 2007 13:56:18 -0000
Message-ID: <46EFD623.7050800@lemote.com>
Date:	Tue, 18 Sep 2007 21:44:03 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Add Loongson document, compared with MIPS III and MIPS 64
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Songmao Tian <tiansm@lemote.com>
---
 Documentation/mips/Loongson.README |   86 
++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/mips/Loongson.README

diff --git a/Documentation/mips/Loongson.README 
b/Documentation/mips/Loongson.README
new file mode 100644
index 0000000..e347b32
--- /dev/null
+++ b/Documentation/mips/Loongson.README
@@ -0,0 +1,86 @@
+Differences between Loongson 2, MIPS III and MIPS 64
+
+Last modified: 2007-09-17 by Songmao Tian <tiansm@lemote.com>
+
+The following material is translated from Loongson 2F user manual,
+but holds true to Loongson 2E.
+
+1. CP0 $22 Diagnostic
+===========================
+Loongson:
+  tblwi/tlbwr doesn't affect ITLB, a write to first bit of $22 is
+needed to flush ITLB.
+MIPS III:
+  Use tlbwi/tblwr directly
+MIPS 64:
+  The same as MIPS III
+
+2. CP0 $24 $25
+===========================
+Loongson:
+  They are used for performance counter.
+MIPS III:
+  They are reserved in MIPS R4000, and $24 is reserved in R10000.
+MIPS 64:
+  $24 is defined as DEPC, used for EJTAG.
+
+3. CP0 $27
+===========================
+Loongson:
+  CacheErr($27) is reserved in Loonson. When ERL is set, ErrEPC doesn't
+stored return address and the first 512MB user space won't change to
+unmapped, uncached.
+MIPS III:
+  CacheErr Exception is supported both in R4k and R10000.
+MIPS 64:
+  CPU varient dependent.
+
+4. TLB Entry
+===========================
+Loongson:
+  Every TLB Entry maps to same page size.
+MIPS III:
+  R4k and R10000 support different tlb entry maps to different page size.
+MIPS 64:
+  The same as MIPS III.
+
+5. Address Error Exception.
+===========================
+Loongson:
+  Loongson disables address error exception when loading data into $0,
+facilitating instruction prefetch when compiling.
+MIPS III:
+  If address error occur or translation failed when loading data into $0,
+address error exception will occur.
+MIPS 64:
+  The same as MIP III.
+
+6. Floating point
+===========================
+Loongson:
+  In floating point computations, invalid operation causes FPU to 
supply 0x80000000
+or 0x80000000 00000000, when corresponding enable bit is cleared.
+MIPS III:
+  FPU supplies 0x7fffffff or 0x7fffffff ffffffff.
+MIPS 64:
+  The same as MIPS III.
+
+7. Floating CSR
+===========================
+Loongson:
+  [CC2:CC7] bits in FSCR register are read-only, and always get zero 
when read.
+MIPS III:
+  The same as Loongson.
+MIPS 64:
+  These bits are available.
+
+8. TLB exception
+===========================
+Loongson:
+  Loongson doesn't support KX, UX, SX. Exception entry of XTLB and TLB 
refill is the same.
+MIPS III:
+  KX, UX, and SX are used to determine wheather 64-bit address is used, 
and entry of TLB and
+XTLB are different.
+MIPS 64:
+  The same as MIPS III.
+
