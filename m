Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:11:16 +0200 (CEST)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:58294 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835172Ab3FGXD7E2QuS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:59 +0200
Received: by mail-ie0-f174.google.com with SMTP id aq17so12143477iec.33
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AjazvHu+yz1tQmetb5r/jjtuylzR9sTq2HLSlYtsyhM=;
        b=iM8sz/8/7fDpl/f0YiyUvpig6/Qg+YVIB7zduu7qxgeYSiqArvcDJsK3DSdV9zbIGQ
         Oe+JTdAWXv/u3WWBLy3YENa2ud59CcWuVmJulv/836r/ubKTcU1RpYjwOrkbsBCmxPbz
         eBVtKK3Mj6JQYPN5AYJUQ8gfBxC+BTPqd8euxUuly1VGVUqHybJUy4fzVpM2IBvN5yjE
         1reb74twgQNqaYOQRdz8wjSWiqu7vAInO5O4vsZiG2J9wlWW3Sqx0/DTqwHawbEhVLhP
         i9UxnyeypM39NZuRvLuoLgr0574mFFXY8yDbUBgo36KVY9r2CosRntVDzkYVBR5dNIR+
         upOA==
X-Received: by 10.50.4.69 with SMTP id i5mr2100885igi.16.1370646232552;
        Fri, 07 Jun 2013 16:03:52 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id wn10sm215315igb.2.2013.06.07.16.03.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:51 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3nqI006686;
        Fri, 7 Jun 2013 16:03:49 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3njV006685;
        Fri, 7 Jun 2013 16:03:49 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 19/31] mips/kvm: Add host definitions for MIPS VZ based host.
Date:   Fri,  7 Jun 2013 16:03:23 -0700
Message-Id: <1370646215-6543-20-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/kvm_mips_vz.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 arch/mips/include/asm/kvm_mips_vz.h

diff --git a/arch/mips/include/asm/kvm_mips_vz.h b/arch/mips/include/asm/kvm_mips_vz.h
new file mode 100644
index 0000000..dfc6951
--- /dev/null
+++ b/arch/mips/include/asm/kvm_mips_vz.h
@@ -0,0 +1,29 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2013 Cavium, Inc.
+ */
+#ifndef _ASM_KVM_MIPS_VZ_H
+#define _ASM_KVM_MIPS_VZ_H
+
+struct kvm;
+
+struct kvm_mips_vz {
+	struct mutex guest_mm_lock;
+	pgd_t *pgd;			/* Translations for this host. */
+	spinlock_t irq_chip_lock;
+	struct page *irq_chip;
+	unsigned int asid[NR_CPUS];	/* Per CPU ASIDs for pgd. */
+};
+
+bool mipsvz_page_fault(struct pt_regs *regs, unsigned long write,
+		       unsigned long address);
+
+bool mipsvz_cp_unusable(struct pt_regs *regs);
+int mipsvz_arch_init(void *opaque);
+int mipsvz_arch_hardware_enable(void *garbage);
+int mipsvz_init_vm(struct kvm *kvm, unsigned long type);
+
+#endif /* _ASM_KVM_MIPS_VZ_H */
-- 
1.7.11.7
