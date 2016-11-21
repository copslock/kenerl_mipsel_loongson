Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2016 11:24:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:31143 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992166AbcKUKXvvqlBJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2016 11:23:51 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 68B27DBFB7218;
        Mon, 21 Nov 2016 10:23:43 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 21 Nov 2016 10:23:45 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] MIPS: elfcore: add correct copy_regs implementations
Date:   Mon, 21 Nov 2016 11:23:39 +0100
Message-ID: <1479723819-14557-2-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1479723819-14557-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1479723819-14557-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55835
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

MIPS does not currently define ELF_CORE_COPY_REGS macros and as a result
the generic implementation is used. The generic version attempts to do
directly map (struct pt_regs) into (elf_gregset_t), which isn't correct
for MIPS platforms and also triggers a BUG() at runtime in
include/linux/elfcore.h:16 (BUG_ON(sizeof(*elfregs) != sizeof(*regs)))

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/include/asm/elf.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index f61a4a1..588a691 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -224,6 +224,9 @@ void mips_dump_regs64(u64 *uregs, const struct pt_regs *regs);
  */
 #define ELF_CLASS	ELFCLASS32
 
+#define ELF_CORE_COPY_REGS(dest, regs) \
+	mips_dump_regs32((u32 *)&(dest), (regs))
+
 #endif /* CONFIG_32BIT */
 
 #ifdef CONFIG_64BIT
@@ -237,6 +240,9 @@ void mips_dump_regs64(u64 *uregs, const struct pt_regs *regs);
  */
 #define ELF_CLASS	ELFCLASS64
 
+#define ELF_CORE_COPY_REGS(dest, regs) \
+	mips_dump_regs64((u64 *)&(dest), (regs))
+
 #endif /* CONFIG_64BIT */
 
 /*
-- 
2.7.4
