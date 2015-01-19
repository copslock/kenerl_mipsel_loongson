Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 06:31:46 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22428 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008709AbbASFbofMdM3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 06:31:44 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id CC7B8733627F5;
        Mon, 19 Jan 2015 05:31:36 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 19 Jan 2015 05:31:38 +0000
Received: from localhost (192.168.159.114) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 19 Jan
 2015 05:31:35 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: [PATCH] MIPS: bypass FP mode checks when CONFIG_MIPS_O32_FP64_SUPPORT==n
Date:   Sun, 18 Jan 2015 21:31:16 -0800
Message-ID: <1421645476-13532-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.114]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45289
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

The FP mode checks introduced to support the FP modes indicated by the
new PT_MIPS_ABIFLAGS program header & .MIPS.abiflags section have been
found to cause some compatibility issues when mixing binaries with such
mode information & an ELF interpreter without it, or vice-versa[1]. The
mode checks serve little purpose unless the kernel actually supports the
FP64 modes as indicated by CONFIG_MIPS_O32_FP64_SUPPORT, which currently
defaults to disabled & is marked experimental. Bypass the mode checks
when the FP64 support is disabled in order to avoid compatibility issues
with v3.19 until the logic is fixed.

[1]: http://www.linux-mips.org/archives/linux-mips/2015-01/msg00279.html

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>
Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
---
Ralf: if people agree with this approach, it would be great to get this
      in for v3.19.
---
 arch/mips/kernel/elf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
index c92b15d..bb73c7c 100644
--- a/arch/mips/kernel/elf.c
+++ b/arch/mips/kernel/elf.c
@@ -68,6 +68,15 @@ int arch_check_elf(void *_ehdr, bool has_interpreter,
 	struct elfhdr *ehdr = _ehdr;
 	unsigned fp_abi, interp_fp_abi, abi0, abi1;
 
+	if (!config_enabled(CONFIG_MIPS_O32_FP64_SUPPORT)) {
+		/*
+		 * Temporarily bypass this logic when the o32 FP64 support is
+		 * not enabled, until all compatibility issues are resolved.
+		 */
+		state->overall_abi = MIPS_ABI_FP_DOUBLE;
+		return 0;
+	}
+
 	/* Ignore non-O32 binaries */
 	if (config_enabled(CONFIG_64BIT) &&
 	    (ehdr->e_ident[EI_CLASS] != ELFCLASS32))
-- 
2.2.1
