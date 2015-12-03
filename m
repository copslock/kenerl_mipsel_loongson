Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 11:09:26 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14196 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012273AbbLCKIaeJB4Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 11:08:30 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id C858DDD4F81EC
        for <linux-mips@linux-mips.org>; Thu,  3 Dec 2015 10:08:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 3 Dec 2015 10:08:24 +0000
Received: from mredfearn-linux.le.imgtec.org (192.168.154.116) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 3 Dec 2015 10:08:24 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH 3/9] MIPS: Reserve space for relocation table
Date:   Thu, 3 Dec 2015 10:08:11 +0000
Message-ID: <1449137297-30464-4-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50308
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

When CONFIG_RELOCATABLE is enabled, add a new section in the memory map
to be filled with relocation data.

CONFIG_RELOCATION_TABLE_SIZE allows the amount of space reserved to be
adjusted if necessary.

The relocs tool will populate this reserved space with relocation
information. The space is reserved within the elf by filling it with
0's, and an invalid entry is left at the start of the space such that
kernel relocation will be aborted if the table is empty.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
 arch/mips/Kconfig              | 14 ++++++++++++++
 arch/mips/kernel/vmlinux.lds.S | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index e3aa5b0b4ef1..b8ed64dfaafc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2431,6 +2431,20 @@ config NUMA
 config SYS_SUPPORTS_NUMA
 	bool
 
+config RELOCATION_TABLE_SIZE
+	hex "Relocation table size"
+	depends on RELOCATABLE
+	range 0x0 0x01000000
+	default "0x00100000"
+	---help---
+	  A table of relocation data will be appended to the kernel binary
+	  and parsed at boot to fix up the relocated kernel.
+
+	  This option allows the amount of space reserved for the table to be
+	  adjusted, although the default of 1Mb should be ok in most cases.
+
+	  If unsure, leave at the default value.
+
 config NODES_SHIFT
 	int
 	default "6"
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 07d32a4aea60..27d70423f1dd 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -128,6 +128,26 @@ SECTIONS
 #ifdef CONFIG_SMP
 	PERCPU_SECTION(1 << CONFIG_MIPS_L1_CACHE_SHIFT)
 #endif
+
+#ifdef CONFIG_RELOCATABLE
+	. = ALIGN(4);
+
+	.data.reloc : {
+		_relocation_start = .;
+		/* Space for relocation table
+		 * This needs to be filled so that the
+		 * relocs tool can overwrite the content.
+		 * An invalid value is left at the start of the
+		 * section to abort relocation if the table
+		 * has not been filled in.
+		 */
+		LONG(0xFFFFFFFF);
+		FILL(0);
+		. += CONFIG_RELOCATION_TABLE_SIZE - 4;
+		_relocation_end = .;
+	}
+#endif
+
 #ifdef CONFIG_MIPS_RAW_APPENDED_DTB
 	__appended_dtb = .;
 	/* leave space for appended DTB */
-- 
2.1.4
