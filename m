Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 00:04:22 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7657 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491092Ab1AXXET (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 00:04:19 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3e05a20000>; Mon, 24 Jan 2011 15:05:06 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 15:04:17 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 15:04:17 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0ON4DSa023658;
        Mon, 24 Jan 2011 15:04:13 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0ON4AUI023657;
        Mon, 24 Jan 2011 15:04:10 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] binfmt_elf: Quiet GCC-4.6 'set but not used' warning in load_elf_binary()
Date:   Mon, 24 Jan 2011 15:04:09 -0800
Message-Id: <1295910249-23626-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 24 Jan 2011 23:04:17.0398 (UTC) FILETIME=[06C62960:01CBBC1B]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

With GCC-4.6 we get warnings about things being 'set but not used'.

In load_elf_binary() this can happen with reloc_func_desc if
ELF_PLAT_INIT is defined, but doesn't use the reloc_func_desc
argument.

Quiet the warning/error by marking reloc_func_desc as __maybe_unused.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 fs/binfmt_elf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index d5b640b..b2fae009 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -570,7 +570,7 @@ static int load_elf_binary(struct linux_binprm *bprm, struct pt_regs *regs)
 	unsigned long elf_entry;
 	unsigned long interp_load_addr = 0;
 	unsigned long start_code, end_code, start_data, end_data;
-	unsigned long reloc_func_desc = 0;
+	unsigned long reloc_func_desc __maybe_unused = 0;
 	int executable_stack = EXSTACK_DEFAULT;
 	unsigned long def_flags = 0;
 	struct {
-- 
1.7.2.3
