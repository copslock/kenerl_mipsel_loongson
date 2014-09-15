Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 21:29:17 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37586 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009004AbaIOT1MNa2eD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 21:27:12 +0200
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 97BCDB1D;
        Mon, 15 Sep 2014 19:27:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Smith <alex@alex-smith.me.uk>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.16 064/158] MIPS: ptrace: Avoid smp_processor_id() when retrieving FPU IR
Date:   Mon, 15 Sep 2014 12:25:03 -0700
Message-Id: <20140915192544.816172080@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <20140915192542.872134685@linuxfoundation.org>
References: <20140915192542.872134685@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42583
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

3.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Smith <alex@alex-smith.me.uk>

commit 656ff9bef08c19a6471b49528dacb4cbbeb1e537 upstream.

Whenever ptrace attempts to retrieve the FPU implementation register it
accesses it through current_cpu_data, which calls smp_processor_id().
Since the code may execute with preemption enabled, this can trigger
a warning. Fix this by using boot_cpu_data to get the IR instead.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7449/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/ptrace.c   |    4 ++--
 arch/mips/kernel/ptrace32.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -129,7 +129,7 @@ int ptrace_getfpregs(struct task_struct
 	}
 
 	__put_user(child->thread.fpu.fcr31, data + 64);
-	__put_user(current_cpu_data.fpu_id, data + 65);
+	__put_user(boot_cpu_data.fpu_id, data + 65);
 
 	return 0;
 }
@@ -611,7 +611,7 @@ long arch_ptrace(struct task_struct *chi
 			break;
 		case FPC_EIR:
 			/* implementation / version register */
-			tmp = current_cpu_data.fpu_id;
+			tmp = boot_cpu_data.fpu_id;
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -129,7 +129,7 @@ long compat_arch_ptrace(struct task_stru
 			break;
 		case FPC_EIR:
 			/* implementation / version register */
-			tmp = current_cpu_data.fpu_id;
+			tmp = boot_cpu_data.fpu_id;
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
