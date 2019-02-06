Return-Path: <SRS0=AiVX=QN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD680C282C2
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 05:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E372080A
	for <linux-mips@archiver.kernel.org>; Wed,  6 Feb 2019 05:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="En3UWbPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfBFFy5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:54:57 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:52632 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfBFFy5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 6 Feb 2019 00:54:57 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x165rFwH000606;
        Wed, 6 Feb 2019 14:53:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x165rFwH000606
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1549432396;
        bh=EAMSas9e9ZpOKu1AlrETT49oj7kQOjKvDZG70kzoBUs=;
        h=From:To:Cc:Subject:Date:From;
        b=En3UWbPQ4JGsTiPUNM0iOLIeWaYYYAOWeCyaV1KJLZTPxL7pkvIiFUeICThUoa8xK
         o/gOxHbDmPVc/F1QlIozdL/Kd7NBhNeK0KpMp9/Eb7QJuQxien21vRBqJeT+hQ4v0R
         zz8NgNB7Ek2Mnx4VPUS8ErGY7UDUA4+Ioqj1S22Zm71l62hyoWksTqHByliJTShcrI
         nZIFMFGGFQyiFRHrlJ+jbBuPIKLJiIb2BlPNGWv++GW+rq22bo7agz62RDIQavjcin
         KdpeduzBirndIWQUpzKeipCTWbo6HDWFUQsq8eq2w+HdVZZwdfL20l5b1mB3bW0BAE
         +hh57mLV0sO2A==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=8F=AB=ADm=8F=AB=A1=8F=AB=DA?= 
        <rkrcmar@redhat.com>, kvm@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] KVM: export <linux/kvm_para.h> and <asm/kvm_para.h> iif KVM is supported
Date:   Wed,  6 Feb 2019 14:53:10 +0900
Message-Id: <1549432390-11457-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

I do not see any consistency about headers_install of <linux/kvm_para.h>
and <asm/kvm_para.h>.

According to my analysis of Linux 5.0-rc5, there are 3 groups:

 [1] Both <linux/kvm_para.h> and <asm/kvm_para.h> are exported

    alpha, arm, hexagon, mips, powerpc, s390, sparc, x86

 [2] <asm/kvm_para.h> is exported, but <linux/kvm_para.h> is not

    arc, arm64, c6x, h8300, ia64, m68k, microblaze, nios2, openrisc

 [3] Neither <linux/kvm_para.h> nor <asm/kvm_para.h> is exported

    csky, nds32, riscv

This does not match to the actual KVM support. At least, [2] is
half-baked.

Nor do arch maintainers look like they care about this. For example,
commit 0add53713b1c ("microblaze: Add missing kvm_para.h to Kbuild")
exported <asm/kvm_para.h> to user-space in order to fix an in-kernel
build error.

We have two ways to make this consistent:

 [A] export both <linux/kvm_para.h> and <asm/kvm_para.h> for all
     architectures, irrespective of the KVM support

 [B] Match the header export of <linux/kvm_para.h> and <asm/kvm_para.h>
     to the KVM support

My first attempt was [A] because the code looks better, but Paolo
showed preference in [B].

  https://patchwork.kernel.org/patch/10794919/

So, this commit is the implementation of [B].

For most architectures, <asm/kvm_para.h> was moved to the kernel-space.
I changed include/uapi/linux/Kbuild so that it checks generated
asm/kvm_para.h as well as check-in ones.

After this commit, there will be two groups:

 [1] Both <linux/kvm_para.h> and <asm/kvm_para.h> are exported

    arm arm64 mips powerpc s390 x86

 [2] Neither <linux/kvm_para.h> nor <asm/kvm_para.h> is exported

    alpha arc c6x csky h8300 hexagon ia64 m68k microblaze nds32 nios2
    openrisc parisc riscv sh sparc unicore32 xtensa

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

The alternative solution [A] is available at:
https://patchwork.kernel.org/patch/10794919/

Comparing the code diff, I personally prefer [A]...


 arch/alpha/include/asm/Kbuild            | 1 +
 arch/alpha/include/uapi/asm/kvm_para.h   | 2 --
 arch/arc/include/asm/Kbuild              | 1 +
 arch/arc/include/uapi/asm/Kbuild         | 1 -
 arch/arm/include/uapi/asm/Kbuild         | 1 +
 arch/arm/include/uapi/asm/kvm_para.h     | 2 --
 arch/c6x/include/asm/Kbuild              | 1 +
 arch/c6x/include/uapi/asm/Kbuild         | 1 -
 arch/h8300/include/asm/Kbuild            | 1 +
 arch/h8300/include/uapi/asm/Kbuild       | 1 -
 arch/hexagon/include/asm/Kbuild          | 1 +
 arch/hexagon/include/uapi/asm/kvm_para.h | 2 --
 arch/ia64/include/asm/Kbuild             | 1 +
 arch/ia64/include/uapi/asm/Kbuild        | 1 -
 arch/m68k/include/asm/Kbuild             | 1 +
 arch/m68k/include/uapi/asm/Kbuild        | 1 -
 arch/microblaze/include/asm/Kbuild       | 1 +
 arch/microblaze/include/uapi/asm/Kbuild  | 1 -
 arch/mips/include/uapi/asm/Kbuild        | 1 +
 arch/mips/include/uapi/asm/kvm_para.h    | 5 -----
 arch/nios2/include/asm/Kbuild            | 1 +
 arch/nios2/include/uapi/asm/Kbuild       | 1 -
 arch/openrisc/include/asm/Kbuild         | 1 +
 arch/openrisc/include/uapi/asm/Kbuild    | 1 -
 arch/parisc/include/asm/Kbuild           | 1 +
 arch/parisc/include/uapi/asm/Kbuild      | 1 -
 arch/s390/include/uapi/asm/Kbuild        | 1 +
 arch/s390/include/uapi/asm/kvm_para.h    | 8 --------
 arch/sh/include/asm/Kbuild               | 1 +
 arch/sh/include/uapi/asm/Kbuild          | 1 -
 arch/sparc/include/asm/Kbuild            | 1 +
 arch/sparc/include/uapi/asm/kvm_para.h   | 2 --
 arch/unicore32/include/asm/Kbuild        | 1 +
 arch/unicore32/include/uapi/asm/Kbuild   | 1 -
 arch/xtensa/include/asm/Kbuild           | 1 +
 arch/xtensa/include/uapi/asm/Kbuild      | 1 -
 include/uapi/linux/Kbuild                | 2 ++
 37 files changed, 20 insertions(+), 33 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/arm/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/hexagon/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/mips/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/s390/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/sparc/include/uapi/asm/kvm_para.h

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index dc0ab28..70b7833 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += exec.h
 generic-y += export.h
 generic-y += fb.h
 generic-y += irq_work.h
+generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += preempt.h
diff --git a/arch/alpha/include/uapi/asm/kvm_para.h b/arch/alpha/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/arch/alpha/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index caa2702..6e165e1 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -10,6 +10,7 @@ generic-y += hardirq.h
 generic-y += hw_irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/arc/include/uapi/asm/Kbuild b/arch/arc/include/uapi/asm/Kbuild
index 0febf1a..c1b06dc 100644
--- a/arch/arc/include/uapi/asm/Kbuild
+++ b/arch/arc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index eee8f7d..482e5ec 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -4,3 +4,4 @@ include include/uapi/asm-generic/Kbuild.asm
 generated-y += unistd-common.h
 generated-y += unistd-oabi.h
 generated-y += unistd-eabi.h
+generic-y += kvm_para.h
diff --git a/arch/arm/include/uapi/asm/kvm_para.h b/arch/arm/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/arch/arm/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 63b4a17..249c9f6 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -19,6 +19,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 0febf1a..c1b06dc 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 961c1dc..c86e3e7 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -24,6 +24,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index 0febf1a..c1b06dc 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index b25fd42..d046e8c 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -19,6 +19,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/hexagon/include/uapi/asm/kvm_para.h b/arch/hexagon/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/arch/hexagon/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 43e21fe..11f1916 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -2,6 +2,7 @@ generated-y += syscall_table.h
 generic-y += compat.h
 generic-y += exec.h
 generic-y += irq_work.h
+generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += preempt.h
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index 5b819e5..1d5c4aa 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_64.h
-generic-y += kvm_para.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 95f8f63..2c359d9 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 960bf1e..439f515 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += kvm_para.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 791cc8d5..1a8285c 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -17,6 +17,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index 97823ec..3f03cf6 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
index 0851c10..57dd982 100644
--- a/arch/mips/include/uapi/asm/Kbuild
+++ b/arch/mips/include/uapi/asm/Kbuild
@@ -6,3 +6,4 @@ generated-y += unistd_o32.h
 generated-y += unistd_nr_n32.h
 generated-y += unistd_nr_n64.h
 generated-y += unistd_nr_o32.h
+generic-y += kvm_para.h
diff --git a/arch/mips/include/uapi/asm/kvm_para.h b/arch/mips/include/uapi/asm/kvm_para.h
deleted file mode 100644
index 7e16d7c..0000000
--- a/arch/mips/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#ifndef _UAPI_ASM_MIPS_KVM_PARA_H
-#define _UAPI_ASM_MIPS_KVM_PARA_H
-
-
-#endif /* _UAPI_ASM_MIPS_KVM_PARA_H */
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 8fde4fa..88a667d 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -23,6 +23,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
index 0febf1a..c1b06dc 100644
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ b/arch/nios2/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 1f04844b..ad06de9 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -21,6 +21,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 0febf1a..c1b06dc 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 0b1e354..3abb960 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -12,6 +12,7 @@ generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index c54353d..214a39a 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -2,4 +2,3 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generated-y += unistd_64.h
-generic-y += kvm_para.h
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index da3e0d4..96ad5d7 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -3,3 +3,4 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generated-y += unistd_64.h
+generic-y += kvm_para.h
diff --git a/arch/s390/include/uapi/asm/kvm_para.h b/arch/s390/include/uapi/asm/kvm_para.h
deleted file mode 100644
index b9ab584..0000000
--- a/arch/s390/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * User API definitions for paravirtual devices on s390
- *
- * Copyright IBM Corp. 2008
- *
- *    Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
- */
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index a6ef3fe..7bf2cb6 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index eaa30bc..0ec45ff 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -2,5 +2,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index b82f64e..a22cfd5 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += exec.h
 generic-y += export.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
+generic-y += kvm_para.h
 generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
diff --git a/arch/sparc/include/uapi/asm/kvm_para.h b/arch/sparc/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/arch/sparc/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 1d1544b..d77d953 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -18,6 +18,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 0febf1a..c1b06dc 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index e255683..d474c34 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -15,6 +15,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
index 960bf1e..439f515 100644
--- a/arch/xtensa/include/uapi/asm/Kbuild
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += kvm_para.h
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index 5f24b50..059dc2b 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -7,5 +7,7 @@ no-export-headers += kvm.h
 endif
 
 ifeq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/uapi/asm/kvm_para.h),)
+ifeq ($(wildcard $(objtree)/arch/$(SRCARCH)/include/generated/uapi/asm/kvm_para.h),)
 no-export-headers += kvm_para.h
 endif
+endif
-- 
2.7.4

