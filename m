Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2015 15:34:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23683 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013931AbbKPOeezpm1R (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2015 15:34:34 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 687016853E60;
        Mon, 16 Nov 2015 14:34:26 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Mon, 16 Nov 2015
 14:34:28 +0000
Date:   Mon, 16 Nov 2015 14:34:27 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Daniel Sanders <Daniel.Sanders@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 1/4] ELF: Add platform-specific AT_FLAGS initialisation
 support
In-Reply-To: <alpine.DEB.2.00.1511161358211.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1511161413200.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511161358211.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-elf-at-flags.diff
Index: linux-sfr-test/fs/binfmt_elf.c
===================================================================
--- linux-sfr-test.orig/fs/binfmt_elf.c	2015-09-08 15:24:00.927208000 +0100
+++ linux-sfr-test/fs/binfmt_elf.c	2015-09-08 15:26:10.318310000 +0100
@@ -72,6 +72,10 @@ static int elf_core_dump(struct coredump
 #define ELF_MIN_ALIGN	PAGE_SIZE
 #endif
 
+#ifndef ELF_FLAGS
+#define ELF_FLAGS	0
+#endif
+
 #ifndef ELF_CORE_EFLAGS
 #define ELF_CORE_EFLAGS	0
 #endif
@@ -238,7 +242,7 @@ create_elf_tables(struct linux_binprm *b
 	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
 	NEW_AUX_ENT(AT_BASE, interp_load_addr);
-	NEW_AUX_ENT(AT_FLAGS, 0);
+	NEW_AUX_ENT(AT_FLAGS, ELF_FLAGS);
 	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
 	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
Index: linux-sfr-test/fs/binfmt_elf_fdpic.c
===================================================================
--- linux-sfr-test.orig/fs/binfmt_elf_fdpic.c	2015-09-08 15:24:00.950209000 +0100
+++ linux-sfr-test/fs/binfmt_elf_fdpic.c	2015-09-08 15:29:25.860980000 +0100
@@ -80,6 +80,10 @@ static int elf_fdpic_map_file_by_direct_
 static int elf_fdpic_core_dump(struct coredump_params *cprm);
 #endif
 
+#ifndef ELF_FLAGS
+#define ELF_FLAGS	0
+#endif
+
 static struct linux_binfmt elf_fdpic_format = {
 	.module		= THIS_MODULE,
 	.load_binary	= load_elf_fdpic_binary,
@@ -616,7 +620,7 @@ static int create_elf_fdpic_tables(struc
 	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
 	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
 	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
-	NEW_AUX_ENT(AT_FLAGS,	0);
+	NEW_AUX_ENT(AT_FLAGS,	ELF_FLAGS);
 	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
 	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
