Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 10:38:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42824 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008709AbaIKIhhThs0A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 10:37:37 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D699B91541ACD;
        Thu, 11 Sep 2014 09:37:28 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 09:37:30 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 11 Sep 2014 08:31:34 +0100
Received: from pburton-laptop.home (192.168.159.78) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 11 Sep
 2014 08:31:29 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 02/10] binfmt_elf: load interpreter program headers earlier
Date:   Thu, 11 Sep 2014 08:30:15 +0100
Message-ID: <1410420623-11691-3-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
References: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.78]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42505
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

Load the program headers of an ELF interpreter early enough in
load_elf_binary that they can be examined before it's too late to return
an error from an exec syscall. This patch does not perform any such
checking, it merely lays the groundwork for a further patch to do so.

No functional change is intended.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 fs/binfmt_elf.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 64ca110..61dabe0 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -447,9 +447,8 @@ out:
 
 static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 		struct file *interpreter, unsigned long *interp_map_addr,
-		unsigned long no_base)
+		unsigned long no_base, struct elf_phdr *interp_elf_phdata)
 {
-	struct elf_phdr *elf_phdata;
 	struct elf_phdr *eppnt;
 	unsigned long load_addr = 0;
 	int load_addr_set = 0;
@@ -467,17 +466,14 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	if (!interpreter->f_op->mmap)
 		goto out;
 
-	elf_phdata = load_elf_phdrs(interp_elf_ex, interpreter);
-	if (!elf_phdata)
-		goto out;
-
-	total_size = total_mapping_size(elf_phdata, interp_elf_ex->e_phnum);
+	total_size = total_mapping_size(interp_elf_phdata,
+					interp_elf_ex->e_phnum);
 	if (!total_size) {
 		error = -EINVAL;
-		goto out_close;
+		goto out;
 	}
 
-	eppnt = elf_phdata;
+	eppnt = interp_elf_phdata;
 	for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
 		if (eppnt->p_type == PT_LOAD) {
 			int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
@@ -504,7 +500,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				*interp_map_addr = map_addr;
 			error = map_addr;
 			if (BAD_ADDR(map_addr))
-				goto out_close;
+				goto out;
 
 			if (!load_addr_set &&
 			    interp_elf_ex->e_type == ET_DYN) {
@@ -523,7 +519,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 			    eppnt->p_memsz > TASK_SIZE ||
 			    TASK_SIZE - eppnt->p_memsz < k) {
 				error = -ENOMEM;
-				goto out_close;
+				goto out;
 			}
 
 			/*
@@ -553,7 +549,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 		 */
 		if (padzero(elf_bss)) {
 			error = -EFAULT;
-			goto out_close;
+			goto out;
 		}
 
 		/* What we have mapped so far */
@@ -562,13 +558,10 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 		/* Map the last of the bss segment */
 		error = vm_brk(elf_bss, last_bss - elf_bss);
 		if (BAD_ADDR(error))
-			goto out_close;
+			goto out;
 	}
 
 	error = load_addr;
-
-out_close:
-	kfree(elf_phdata);
 out:
 	return error;
 }
@@ -605,7 +598,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	int load_addr_set = 0;
 	char * elf_interpreter = NULL;
 	unsigned long error;
-	struct elf_phdr *elf_ppnt, *elf_phdata;
+	struct elf_phdr *elf_ppnt, *elf_phdata, *interp_elf_phdata = NULL;
 	unsigned long elf_bss, elf_brk;
 	int retval, i;
 	unsigned long elf_entry;
@@ -729,6 +722,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		/* Verify the interpreter has a valid arch */
 		if (!elf_check_arch(&loc->interp_elf_ex))
 			goto out_free_dentry;
+
+		/* Load the interpreter program headers */
+		interp_elf_phdata = load_elf_phdrs(&loc->interp_elf_ex,
+						   interpreter);
+		if (!interp_elf_phdata)
+			goto out_free_dentry;
 	}
 
 	/* Flush all traces of the currently running executable */
@@ -912,7 +911,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		elf_entry = load_elf_interp(&loc->interp_elf_ex,
 					    interpreter,
 					    &interp_map_addr,
-					    load_bias);
+					    load_bias, interp_elf_phdata);
 		if (!IS_ERR((void *)elf_entry)) {
 			/*
 			 * load_elf_interp() returns relocation
@@ -1009,6 +1008,7 @@ out_ret:
 
 	/* error cleanup */
 out_free_dentry:
+	kfree(interp_elf_phdata);
 	allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
-- 
2.0.4
