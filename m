Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 19:44:48 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56235 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012224AbbHNRnLKsbu1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 19:43:11 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 454468A6;
        Fri, 14 Aug 2015 17:43:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.1 06/84] MIPS: do_mcheck: Fix kernel code dump with EVA
Date:   Fri, 14 Aug 2015 10:41:34 -0700
Message-Id: <20150814174210.407430905@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150814174210.214822912@linuxfoundation.org>
References: <20150814174210.214822912@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 55c723e181ccec30fb5c672397fe69ec35967d97 upstream.

If a machine check exception is raised in kernel mode, user context,
with EVA enabled, then the do_mcheck handler will attempt to read the
code around the EPC using EVA load instructions, i.e. as if the reads
were from user mode. This will either read random user data if the
process has anything mapped at the same address, or it will cause an
exception which is handled by __get_user, resulting in this output:

 Code: (Bad address in epc)

Fix by setting the current user access mode to kernel if the saved
register context indicates the exception was taken in kernel mode. This
causes __get_user to use normal loads to read the kernel code.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10777/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/traps.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1518,6 +1518,7 @@ asmlinkage void do_mcheck(struct pt_regs
 	const int field = 2 * sizeof(unsigned long);
 	int multi_match = regs->cp0_status & ST0_TS;
 	enum ctx_state prev_state;
+	mm_segment_t old_fs = get_fs();
 
 	prev_state = exception_enter();
 	show_regs(regs);
@@ -1539,8 +1540,13 @@ asmlinkage void do_mcheck(struct pt_regs
 		dump_tlb_all();
 	}
 
+	if (!user_mode(regs))
+		set_fs(KERNEL_DS);
+
 	show_code((unsigned int __user *) regs->cp0_epc);
 
+	set_fs(old_fs);
+
 	/*
 	 * Some chips may have other causes of machine check (e.g. SB1
 	 * graduation timer)
