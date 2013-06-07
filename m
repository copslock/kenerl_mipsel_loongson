Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:10:58 +0200 (CEST)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:57638 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835170Ab3FGXD7Ct2vS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:03:59 +0200
Received: by mail-ie0-f182.google.com with SMTP id 9so12101373iec.13
        for <multiple recipients>; Fri, 07 Jun 2013 16:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mx23w+vrmCLgT0cbXWmdHcohMpXBQwMGGsJZJhaJqqA=;
        b=tG7KjEZtFrc6IaG5N61Pv45002tSzUhuNG19sqLJUFxG1D+eI0smNSQ8cEU6SYJuaj
         yJmMNuRvmKxdtGpWVSWT7g+evPk0cPYv3HEjgC9IwXxaqKg23FihdsU/dFnwBVz93yJI
         iaqKnPJorEPJPOx3Ln9nFWJ9oA7He+WFaquNzZGjEGvN0oHdTmA0z0TL6mFTCHPSvkru
         xy3naoH8bTjM3f4nQIslV0Fuw7q+zOccK8GdOBJ2yKLrorrNMofzpMb5FgrNGTSZGPs7
         6bucm7ZuCT7Fda1snDhsY9q+F0YawuMK+gPA5bA9qJ+PMuqHX3N107fa0HpOMU522pwA
         EFbA==
X-Received: by 10.50.25.194 with SMTP id e2mr360226igg.111.1370646232911;
        Fri, 07 Jun 2013 16:03:52 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id vc15sm163475igb.7.2013.06.07.16.03.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:03:52 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r57N3nqt006690;
        Fri, 7 Jun 2013 16:03:49 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r57N3nDA006689;
        Fri, 7 Jun 2013 16:03:49 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 20/31] mips/kvm: Hook into TLB fault handlers.
Date:   Fri,  7 Jun 2013 16:03:24 -0700
Message-Id: <1370646215-6543-21-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36737
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

If the CPU is operating in guest mode when a TLB related excpetion
occurs, give KVM a chance to do emulation.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/mm/fault.c       | 8 ++++++++
 arch/mips/mm/tlbex-fault.S | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 0fead53..9391da49 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -26,6 +26,7 @@
 #include <asm/ptrace.h>
 #include <asm/highmem.h>		/* For VMALLOC_END */
 #include <linux/kdebug.h>
+#include <asm/kvm_mips_vz.h>
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -50,6 +51,13 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs, unsigned long writ
 	       field, regs->cp0_epc);
 #endif
 
+#ifdef CONFIG_KVM_MIPSVZ
+	if (test_tsk_thread_flag(current, TIF_GUESTMODE)) {
+		if (mipsvz_page_fault(regs, write, address))
+			return;
+	}
+#endif
+
 #ifdef CONFIG_KPROBES
 	/*
 	 * This is to notify the fault handler of the kprobes.	The
diff --git a/arch/mips/mm/tlbex-fault.S b/arch/mips/mm/tlbex-fault.S
index 318855e..df0f70b 100644
--- a/arch/mips/mm/tlbex-fault.S
+++ b/arch/mips/mm/tlbex-fault.S
@@ -14,6 +14,12 @@
 	NESTED(tlb_do_page_fault_\write, PT_SIZE, sp)
 	SAVE_ALL
 	MFC0	a2, CP0_BADVADDR
+#ifdef CONFIG_KVM_MIPSVZ
+	mfc0	v0, CP0_BADINSTR
+	mfc0	v1, CP0_BADINSTRP
+	sw	v0, PT_BADINSTR(sp)
+	sw	v1, PT_BADINSTRP(sp)
+#endif
 	KMODE
 	move	a0, sp
 	REG_S	a2, PT_BVADDR(sp)
-- 
1.7.11.7
