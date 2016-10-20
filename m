Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2016 22:28:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63755 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993048AbcJTU2InOgvK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Oct 2016 22:28:08 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 2B25DF0AD6702;
        Thu, 20 Oct 2016 21:27:58 +0100 (IST)
Received: from localhost (10.100.200.119) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 20 Oct
 2016 21:28:02 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 3/6] kbuild: Keep PCI fixups through dead code elimination
Date:   Thu, 20 Oct 2016 21:27:02 +0100
Message-ID: <20161020202705.3783-4-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161020202705.3783-1-paul.burton@imgtec.com>
References: <20161020202705.3783-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.119]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55532
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

With CONFIG_LD_DEAD_CODE_DATA_ELIMINATION enabled we must ensure that we
keep PCI fixups or they will be discarded during the link & we'll lose
support for any PCI fixups.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
---

 include/asm-generic/vmlinux.lds.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 06673d6..e710593 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -288,28 +288,28 @@
 	/* PCI quirks */						\
 	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
 		VMLINUX_SYMBOL(__start_pci_fixups_early) = .;		\
-		*(.pci_fixup_early)					\
+		KEEP(*(.pci_fixup_early))				\
 		VMLINUX_SYMBOL(__end_pci_fixups_early) = .;		\
 		VMLINUX_SYMBOL(__start_pci_fixups_header) = .;		\
-		*(.pci_fixup_header)					\
+		KEEP(*(.pci_fixup_header))				\
 		VMLINUX_SYMBOL(__end_pci_fixups_header) = .;		\
 		VMLINUX_SYMBOL(__start_pci_fixups_final) = .;		\
-		*(.pci_fixup_final)					\
+		KEEP(*(.pci_fixup_final))				\
 		VMLINUX_SYMBOL(__end_pci_fixups_final) = .;		\
 		VMLINUX_SYMBOL(__start_pci_fixups_enable) = .;		\
-		*(.pci_fixup_enable)					\
+		KEEP(*(.pci_fixup_enable))				\
 		VMLINUX_SYMBOL(__end_pci_fixups_enable) = .;		\
 		VMLINUX_SYMBOL(__start_pci_fixups_resume) = .;		\
-		*(.pci_fixup_resume)					\
+		KEEP(*(.pci_fixup_resume))				\
 		VMLINUX_SYMBOL(__end_pci_fixups_resume) = .;		\
 		VMLINUX_SYMBOL(__start_pci_fixups_resume_early) = .;	\
-		*(.pci_fixup_resume_early)				\
+		KEEP(*(.pci_fixup_resume_early))			\
 		VMLINUX_SYMBOL(__end_pci_fixups_resume_early) = .;	\
 		VMLINUX_SYMBOL(__start_pci_fixups_suspend) = .;		\
-		*(.pci_fixup_suspend)					\
+		KEEP(*(.pci_fixup_suspend))				\
 		VMLINUX_SYMBOL(__end_pci_fixups_suspend) = .;		\
 		VMLINUX_SYMBOL(__start_pci_fixups_suspend_late) = .;	\
-		*(.pci_fixup_suspend_late)				\
+		KEEP(*(.pci_fixup_suspend_late))			\
 		VMLINUX_SYMBOL(__end_pci_fixups_suspend_late) = .;	\
 	}								\
 									\
-- 
2.10.0
