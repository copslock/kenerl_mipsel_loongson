Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2015 01:48:21 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30133 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013479AbbKMAr53oLYl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2015 01:47:57 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 9554EC31F0416;
        Fri, 13 Nov 2015 00:47:45 +0000 (GMT)
Received: from [10.100.200.62] (10.100.200.62) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server id 14.3.235.1; Fri, 13 Nov 2015
 00:47:48 +0000
Date:   Fri, 13 Nov 2015 00:47:48 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] ELF: Also pass any interpreter's file header to
 `arch_check_elf'
In-Reply-To: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1511130006190.7097@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1511111418430.7097@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.62]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49914
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

Also pass any interpreter's file header to `arch_check_elf' so that any 
architecture handler can have a look at it if needed.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
---
linux-arch-check-elf-interp.diff
Index: linux-sfr-test/arch/mips/include/asm/elf.h
===================================================================
--- linux-sfr-test.orig/arch/mips/include/asm/elf.h	2015-11-10 18:06:16.547399000 +0000
+++ linux-sfr-test/arch/mips/include/asm/elf.h	2015-11-11 02:20:02.099077000 +0000
@@ -448,7 +448,7 @@ struct arch_elf_state {
 extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
 			    bool is_interp, struct arch_elf_state *state);
 
-extern int arch_check_elf(void *ehdr, bool has_interpreter,
+extern int arch_check_elf(void *ehdr, bool has_interpreter, void *interp_ehdr,
 			  struct arch_elf_state *state);
 
 extern void mips_set_personality_fp(struct arch_elf_state *state);
Index: linux-sfr-test/arch/mips/kernel/elf.c
===================================================================
--- linux-sfr-test.orig/arch/mips/kernel/elf.c	2015-11-11 02:19:56.376032000 +0000
+++ linux-sfr-test/arch/mips/kernel/elf.c	2015-11-11 02:20:02.104077000 +0000
@@ -128,7 +128,7 @@ int arch_elf_pt_proc(void *_ehdr, void *
 	return 0;
 }
 
-int arch_check_elf(void *_ehdr, bool has_interpreter,
+int arch_check_elf(void *_ehdr, bool has_interpreter, void *_interp_ehdr,
 		   struct arch_elf_state *state)
 {
 	union {
Index: linux-sfr-test/fs/binfmt_elf.c
===================================================================
--- linux-sfr-test.orig/fs/binfmt_elf.c	2015-11-10 18:08:00.126238000 +0000
+++ linux-sfr-test/fs/binfmt_elf.c	2015-11-11 02:20:02.126077000 +0000
@@ -490,6 +490,7 @@ static inline int arch_elf_pt_proc(struc
  * arch_check_elf() - check an ELF executable
  * @ehdr:	The main ELF header
  * @has_interp:	True if the ELF has an interpreter, else false.
+ * @interp_ehdr: The interpreter's ELF header
  * @state:	Architecture-specific state preserved throughout the process
  *		of loading the ELF.
  *
@@ -501,6 +502,7 @@ static inline int arch_elf_pt_proc(struc
  *         with that return code.
  */
 static inline int arch_check_elf(struct elfhdr *ehdr, bool has_interp,
+				 struct elfhdr *interp_ehdr,
 				 struct arch_elf_state *state)
 {
 	/* Dummy implementation, always proceed */
@@ -828,7 +830,9 @@ static int load_elf_binary(struct linux_
 	 * still possible to return an error to the code that invoked
 	 * the exec syscall.
 	 */
-	retval = arch_check_elf(&loc->elf_ex, !!interpreter, &arch_state);
+	retval = arch_check_elf(&loc->elf_ex,
+				!!interpreter, &loc->interp_elf_ex,
+				&arch_state);
 	if (retval)
 		goto out_free_dentry;
 
