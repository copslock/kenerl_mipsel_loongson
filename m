Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 29 Jun 2014 01:59:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50584 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859955AbaF1X7fdb8tr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 29 Jun 2014 01:59:35 +0200
Date:   Sun, 29 Jun 2014 00:59:35 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Richard Sandiford <rdsandiford@googlemail.com>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: SB1: Check optional compilation flags one by one
Message-ID: <alpine.LFD.2.11.1406290026280.15455@eddie.linux-mips.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40913
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

This fixes a regression caused by commit 
bb6c0bd3fdb67c8a1fceea1d4700b9ee593309f9 [MIPS: SB1: Fix excessive kernel 
warnings.], that makes `-march=r5000' selected for compilation flags 
rather than supposed `-march=sb1' with compilers that do not support the 
ASE selection flags introduced with that change.

For example GCC 4.1.2 supports `-mips3d'/`-mno-mips3d' (and obviously 
`-march=sb1'), however it does not support `-mdmx'/`-mno-mdmx'.  As a 
result the whole selection of flags fails and compilation resorts to using 
`-march=r5000', meant for really old compilers indeed only.

It is always best to pick the flags individually unless we are absolutely 
sure a set of flags was introduced to the toolchain together (`-march=sb1' 
and `-mtune=sb1' would be a good example), and this change makes it happen 
for CONFIG_CPU_SB1.  Consequently the flags ultimately selected with GCC 
4.1.2 are `-march=sb1 -Wa,--trap -mno-mips3d'

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 Ralf, I think we might want to go back to the discussion on using 
`-march=' vs `-mtune=' -- of course we need to be careful, because 
occasionally `-march=' does enable instructions useful in the kernel (such 
as MADD on the NEC Vr5500) beyond ones enabled by the corresponding base 
architecture (MIPS IV in the case of NEC Vr5500), however in many cases 
there is indeed no benefit.

 Richard, this makes me concerned again about backward compatibility of 
toolchain components.  I've been using binutils 2.20.1 for these kernel 
builds simply because sorting out some unrelated Linux kernel issues took 
precedence over upgrading old cross-binutils used.  However this makes me 
believe that `-mdmx' and `-mips3d' are now implied in GAS for `-march=sb1' 
-- has it been always the place?  I'm asking because one should in 
principle be able to upgrade binutils under an old version of the compiler 
and things are supposed to work unchanged, modulo bug fixes, as long as no 
new features are used.

 Overall, perhaps we should try harder here and stick `-Wa,-mno-mdmx' and 
`-Wa,-mno-mips3d' to be sure as well.  I'll see if they are indeed needed 
when I get to upgrading binutils, and send another patch if so (unless 
someone else beats me to it, that is, of course).

  Maciej

linux-mips-sb1.patch
Index: linux-20140623-swarm64/arch/mips/Makefile
===================================================================
--- linux-20140623-swarm64.orig/arch/mips/Makefile
+++ linux-20140623-swarm64/arch/mips/Makefile
@@ -151,8 +151,10 @@ cflags-$(CONFIG_CPU_NEVADA)	+= $(call cc
 			-Wa,--trap
 cflags-$(CONFIG_CPU_RM7000)	+= $(call cc-option,-march=rm7000,-march=r5000) \
 			-Wa,--trap
-cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-march=sb1 -mno-mdmx -mno-mips3d,-march=r5000) \
+cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-march=sb1,-march=r5000) \
 			-Wa,--trap
+cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-mno-mdmx)
+cflags-$(CONFIG_CPU_SB1)	+= $(call cc-option,-mno-mips3d)
 cflags-$(CONFIG_CPU_R8000)	+= -march=r8000 -Wa,--trap
 cflags-$(CONFIG_CPU_R10000)	+= $(call cc-option,-march=r10000,-march=r8000) \
 			-Wa,--trap
