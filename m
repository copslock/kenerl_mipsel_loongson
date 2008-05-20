Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2008 23:57:18 +0100 (BST)
Received: from smtp5.pp.htv.fi ([213.243.153.39]:13455 "EHLO smtp5.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S28575640AbYETW5P (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2008 23:57:15 +0100
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id 4F3905BC01C;
	Wed, 21 May 2008 01:57:12 +0300 (EEST)
Date:	Wed, 21 May 2008 01:55:02 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org,
	"Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [2.6 patch] mips/kernel/Makefile: remove CONFIG_CPU_R4000 line
Message-ID: <20080520225502.GC16264@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

The existing options are named CONFIG_CPU_R4300 and CONFIG_CPU_R4X00, 
and they are directly below.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
372ea8980a1d94e474b512bd20d870ee3ea15099 diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
index cc02440..65e46a6 100644
--- a/arch/mips/kernel/Makefile
+++ b/arch/mips/kernel/Makefile
@@ -30,7 +30,6 @@ obj-$(CONFIG_CPU_LOONGSON2)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS32)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_MIPS64)	+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R3000)		+= r2300_fpu.o r2300_switch.o
-obj-$(CONFIG_CPU_R4000)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R4300)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R4X00)		+= r4k_fpu.o r4k_switch.o
 obj-$(CONFIG_CPU_R5000)		+= r4k_fpu.o r4k_switch.o
