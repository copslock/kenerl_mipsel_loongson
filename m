Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2018 13:50:08 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:53264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994773AbeAOMtMah6uK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Jan 2018 13:49:12 +0100
Received: from localhost (LFbn-1-12258-90.w90-92.abo.wanadoo.fr [90.92.71.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 06AC2CBD;
        Mon, 15 Jan 2018 12:49:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@mips.com>,
        James Hogan <james.hogan@mips.com>,
        Paul Burton <Paul.Burton@mips.com>,
        Alex Smith <alex@alex-smith.me.uk>,
        Dave Martin <Dave.Martin@arm.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.14 013/118] MIPS: Disallow outsized PTRACE_SETREGSET NT_PRFPREG regset accesses
Date:   Mon, 15 Jan 2018 13:34:00 +0100
Message-Id: <20180115123416.079261592@linuxfoundation.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180115123415.325497625@linuxfoundation.org>
References: <20180115123415.325497625@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62134
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@mips.com>

commit c8c5a3a24d395b14447a9a89d61586a913840a3b upstream.

Complement commit c23b3d1a5311 ("MIPS: ptrace: Change GP regset to use
correct core dump register layout") and also reject outsized
PTRACE_SETREGSET requests to the NT_PRFPREG regset, like with the
NT_PRSTATUS regset.

Signed-off-by: Maciej W. Rozycki <macro@mips.com>
Fixes: c23b3d1a5311 ("MIPS: ptrace: Change GP regset to use correct core dump register layout")
Cc: James Hogan <james.hogan@mips.com>
Cc: Paul Burton <Paul.Burton@mips.com>
Cc: Alex Smith <alex@alex-smith.me.uk>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/17930/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -541,6 +541,9 @@ static int fpr_set(struct task_struct *t
 
 	BUG_ON(count % sizeof(elf_fpreg_t));
 
+	if (pos + count > sizeof(elf_fpregset_t))
+		return -EIO;
+
 	init_fp_ctx(target);
 
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
