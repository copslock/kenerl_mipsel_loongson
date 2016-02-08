Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 16:44:51 +0100 (CET)
Received: from mail.bmw-carit.de ([62.245.222.98]:47649 "EHLO
        linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011484AbcBHPouUvMXk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2016 16:44:50 +0100
Received: from localhost (handman.bmw-carit.intra [192.168.101.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linuxmail.bmw-carit.de (Postfix) with ESMTPS id 2D5555C440;
        Mon,  8 Feb 2016 16:27:59 +0100 (CET)
From:   Daniel Wagner <daniel.wagner@bmw-carit.de>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH v3 2/3] crash_dump: Add vmcore_elf32_check_arch
Date:   Mon,  8 Feb 2016 16:44:37 +0100
Message-Id: <1454946278-13859-3-git-send-email-daniel.wagner@bmw-carit.de>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1454946278-13859-1-git-send-email-daniel.wagner@bmw-carit.de>
References: <alpine.DEB.2.00.1602061624460.15885@tp.orcam.me.uk>
 <1454946278-13859-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-Path: <daniel.wagner@oss.bmw-carit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.wagner@bmw-carit.de
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

parse_crash_elf{32|64}_headers will check the headers via the
elf_check_arch respectively vmcore_elf64_check_arch macro.

The MIPS architecture implements those two macros differently.
In order to make the differentiation more explicit, let's introduce
an vmcore_elf32_check_arch to allow the archs to overwrite it.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Suggested-by: Maciej W. Rozycki <macro@imgtec.com>
---
 fs/proc/vmcore.c           | 2 +-
 include/linux/crash_dump.h | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 4e61388..c8ed209 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1068,7 +1068,7 @@ static int __init parse_crash_elf32_headers(void)
 	/* Do some basic Verification. */
 	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0 ||
 		(ehdr.e_type != ET_CORE) ||
-		!elf_check_arch(&ehdr) ||
+		!vmcore_elf32_check_arch(&ehdr) ||
 		ehdr.e_ident[EI_CLASS] != ELFCLASS32||
 		ehdr.e_ident[EI_VERSION] != EV_CURRENT ||
 		ehdr.e_version != EV_CURRENT ||
diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 3849fce..3873697 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -34,9 +34,13 @@ void vmcore_cleanup(void);
 
 /*
  * Architecture code can redefine this if there are any special checks
- * needed for 64-bit ELF vmcores. In case of 32-bit only architecture,
- * this can be set to zero.
+ * needed for 32-bit ELF or 64-bit ELF vmcores.  In case of 32-bit
+ * only architecture, vmcore_elf64_check_arch can be set to zero.
  */
+#ifndef vmcore_elf32_check_arch
+#define vmcore_elf32_check_arch(x) elf_check_arch(x)
+#endif
+
 #ifndef vmcore_elf64_check_arch
 #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
 #endif
-- 
2.5.0
