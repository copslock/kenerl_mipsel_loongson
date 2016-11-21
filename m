Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2016 13:26:08 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33512 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992437AbcKUM0BskHIu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2016 13:26:01 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C3EFB2B762602;
        Mon, 21 Nov 2016 12:25:52 +0000 (GMT)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 21 Nov 2016 12:25:55 +0000
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH] elfcore.h: add trailing semi-colon in elf_core_copy_regs()
Date:   Mon, 21 Nov 2016 13:25:52 +0100
Message-ID: <1479731152-676-1-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55838
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

Invocation of ELF_CORE_COPY_REGS macro is missing a trailing semi-colon
thus requiring all macro implementations to include one, which is
contrary to the typical kernel coding style and checkpatch.pl
complains about such macro definitions.
This makes it also consistent with all other ELF_CORE_* macro
invocations throughout this file.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 include/linux/elfcore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index 698d51a..be55557 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -11,7 +11,7 @@ struct coredump_params;
 static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
 {
 #ifdef ELF_CORE_COPY_REGS
-	ELF_CORE_COPY_REGS((*elfregs), regs)
+	ELF_CORE_COPY_REGS((*elfregs), regs);
 #else
 	BUG_ON(sizeof(*elfregs) != sizeof(*regs));
 	*(struct pt_regs *)elfregs = *regs;
-- 
2.7.4
