Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Nov 2014 23:07:41 +0100 (CET)
Received: from relay1.mentorg.com ([192.94.38.131]:54453 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013740AbaKOWHbhqfOF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Nov 2014 23:07:31 +0100
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtp 
        id 1XplV7-0003h6-Gq from Maciej_Rozycki@mentor.com ; Sat, 15 Nov 2014 14:07:25 -0800
Received: from localhost (137.202.0.76) by SVR-IES-FEM-01.mgc.mentorg.com
 (137.202.0.104) with Microsoft SMTP Server (TLS) id 14.3.181.6; Sat, 15 Nov
 2014 22:07:24 +0000
Date:   Sat, 15 Nov 2014 22:07:21 +0000
From:   "Maciej W. Rozycki" <macro@codesourcery.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 2/7] MIPS: mm: Only build one microassembler that is
 suitable
In-Reply-To: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
Message-ID: <alpine.DEB.1.10.1411140205400.2881@tp.orcam.me.uk>
References: <alpine.DEB.1.10.1411140122420.2881@tp.orcam.me.uk>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-Path: <Maciej_Rozycki@mentor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@codesourcery.com
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

The microMIPS microassembler is only suitable for configurations where
the kernel itself is built to microMIPS machine code and not where only
user microMIPS software is supported.  The former is controlled with the
CPU_MICROMIPS configuration setting, whereas SYS_SUPPORTS_MICROMIPS is
used for the latter.

Not only that, but with a given microMIPS vs standard MIPS kernel 
configuration only one microassembler is needed, that matches the ISA 
selected -- CP0.Config3.ISAOnExc is mandatory on microMIPS processors, 
so there is never a need to mix microMIPS and standard MIPS code.

Consequently build only the microassembler that matches the ISA selected 
for the kernel.

Signed-off-by: Maciej W. Rozycki <macro@codesourcery.com>
---
linux-mips-uasm-micromips.diff
Index: linux-3.17-stable-malta/arch/mips/mm/Makefile
===================================================================
--- linux-3.17-stable-malta.orig/arch/mips/mm/Makefile	2014-11-14 19:44:22.000000000 +0000
+++ linux-3.17-stable-malta/arch/mips/mm/Makefile	2014-11-14 19:44:52.031933464 +0000
@@ -4,7 +4,13 @@
 
 obj-y				+= cache.o dma-default.o extable.o fault.o \
 				   gup.o init.o mmap.o page.o page-funcs.o \
-				   tlbex.o tlbex-fault.o tlb-funcs.o uasm-mips.o
+				   tlbex.o tlbex-fault.o tlb-funcs.o
+
+ifdef CONFIG_CPU_MICROMIPS
+obj-y				+= uasm-micromips.o
+else
+obj-y				+= uasm-mips.o
+endif
 
 obj-$(CONFIG_32BIT)		+= ioremap.o pgtable-32.o
 obj-$(CONFIG_64BIT)		+= pgtable-64.o
@@ -22,5 +28,3 @@ obj-$(CONFIG_IP22_CPU_SCACHE)	+= sc-ip22
 obj-$(CONFIG_R5000_CPU_SCACHE)	+= sc-r5k.o
 obj-$(CONFIG_RM7000_CPU_SCACHE) += sc-rm7k.o
 obj-$(CONFIG_MIPS_CPU_SCACHE)	+= sc-mips.o
-
-obj-$(CONFIG_SYS_SUPPORTS_MICROMIPS) += uasm-micromips.o
