Return-Path: <SRS0=HQ/I=PP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F9FC43612
	for <linux-mips@archiver.kernel.org>; Mon,  7 Jan 2019 13:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143CB21736
	for <linux-mips@archiver.kernel.org>; Mon,  7 Jan 2019 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867156;
	bh=haEl7muVCQu0QiqmCBCruTBspB2gMF8LfR+RaNYaCK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cH+ZN63DtjTL3BGcEn/C+5vXtrzM+4omwAw5/7U9avJ8VddzQJa3k2YXQVBOABwc/
	 uZxtjrqTHKXqlYMXGzbscPLajpIsTgIkG/5TEU79BioZtGzRJcclpnhPiVKHh+WlDa
	 4mdQplYn5NoZijgOa7BIerLveS/duB1UjPQxGoP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbfAGNTF (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:19:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729954AbfAGM6Q (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Mon, 7 Jan 2019 07:58:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB2A2089F;
        Mon,  7 Jan 2019 12:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865895;
        bh=haEl7muVCQu0QiqmCBCruTBspB2gMF8LfR+RaNYaCK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IO3+P8hWux2Ft4Q33pbYpDdeEPIgsoKw8fFa9pwczEriEzXPrCePzjyMCZk5uQMr5
         h6l1n0WEg1OeUNtS0+gCZc0wGeUMdgXgC0B/ln7pZfflOrFvgldgSJ9ixrxfDkPMDx
         aaXNRqZ3Bx0BN4Yf6padto1ctmA/bbc+gsmyRlBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Rich Felker <dalias@libc.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 4.19 150/170] MIPS: math-emu: Write-protect delay slot emulation pages
Date:   Mon,  7 Jan 2019 13:32:57 +0100
Message-Id: <20190107104510.662706762@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit adcc81f148d733b7e8e641300c5590a2cdc13bf3 upstream.

Mapping the delay slot emulation page as both writeable & executable
presents a security risk, in that if an exploit can write to & jump into
the page then it can be used as an easy way to execute arbitrary code.

Prevent this by mapping the page read-only for userland, and using
access_process_vm() with the FOLL_FORCE flag to write to it from
mips_dsemul().

This will likely be less efficient due to copy_to_user_page() performing
cache maintenance on a whole page, rather than a single line as in the
previous use of flush_cache_sigtramp(). However this delay slot
emulation code ought not to be running in any performance critical paths
anyway so this isn't really a problem, and we can probably do better in
copy_to_user_page() anyway in future.

A major advantage of this approach is that the fix is small & simple to
backport to stable kernels.

Reported-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 432c6bacbd0c ("MIPS: Use per-mm page to execute branch delay slot instructions")
Cc: stable@vger.kernel.org # v4.8+
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>
Cc: David Daney <david.daney@cavium.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/vdso.c     |    4 ++--
 arch/mips/math-emu/dsemul.c |   38 ++++++++++++++++++++------------------
 2 files changed, 22 insertions(+), 20 deletions(-)

--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -126,8 +126,8 @@ int arch_setup_additional_pages(struct l
 
 	/* Map delay slot emulation page */
 	base = mmap_region(NULL, STACK_TOP, PAGE_SIZE,
-			   VM_READ|VM_WRITE|VM_EXEC|
-			   VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+			   VM_READ | VM_EXEC |
+			   VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
 			   0, NULL);
 	if (IS_ERR_VALUE(base)) {
 		ret = base;
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -214,8 +214,9 @@ int mips_dsemul(struct pt_regs *regs, mi
 {
 	int isa16 = get_isa16_mode(regs->cp0_epc);
 	mips_instruction break_math;
-	struct emuframe __user *fr;
-	int err, fr_idx;
+	unsigned long fr_uaddr;
+	struct emuframe fr;
+	int fr_idx, ret;
 
 	/* NOP is easy */
 	if (ir == 0)
@@ -250,27 +251,31 @@ int mips_dsemul(struct pt_regs *regs, mi
 		fr_idx = alloc_emuframe();
 	if (fr_idx == BD_EMUFRAME_NONE)
 		return SIGBUS;
-	fr = &dsemul_page()[fr_idx];
 
 	/* Retrieve the appropriately encoded break instruction */
 	break_math = BREAK_MATH(isa16);
 
 	/* Write the instructions to the frame */
 	if (isa16) {
-		err = __put_user(ir >> 16,
-				 (u16 __user *)(&fr->emul));
-		err |= __put_user(ir & 0xffff,
-				  (u16 __user *)((long)(&fr->emul) + 2));
-		err |= __put_user(break_math >> 16,
-				  (u16 __user *)(&fr->badinst));
-		err |= __put_user(break_math & 0xffff,
-				  (u16 __user *)((long)(&fr->badinst) + 2));
+		union mips_instruction _emul = {
+			.halfword = { ir >> 16, ir }
+		};
+		union mips_instruction _badinst = {
+			.halfword = { break_math >> 16, break_math }
+		};
+
+		fr.emul = _emul.word;
+		fr.badinst = _badinst.word;
 	} else {
-		err = __put_user(ir, &fr->emul);
-		err |= __put_user(break_math, &fr->badinst);
+		fr.emul = ir;
+		fr.badinst = break_math;
 	}
 
-	if (unlikely(err)) {
+	/* Write the frame to user memory */
+	fr_uaddr = (unsigned long)&dsemul_page()[fr_idx];
+	ret = access_process_vm(current, fr_uaddr, &fr, sizeof(fr),
+				FOLL_FORCE | FOLL_WRITE);
+	if (unlikely(ret != sizeof(fr))) {
 		MIPS_FPU_EMU_INC_STATS(errors);
 		free_emuframe(fr_idx, current->mm);
 		return SIGBUS;
@@ -282,10 +287,7 @@ int mips_dsemul(struct pt_regs *regs, mi
 	atomic_set(&current->thread.bd_emu_frame, fr_idx);
 
 	/* Change user register context to execute the frame */
-	regs->cp0_epc = (unsigned long)&fr->emul | isa16;
-
-	/* Ensure the icache observes our newly written frame */
-	flush_cache_sigtramp((unsigned long)&fr->emul);
+	regs->cp0_epc = fr_uaddr | isa16;
 
 	return 0;
 }


