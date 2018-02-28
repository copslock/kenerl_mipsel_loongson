Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 17:14:32 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53640 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992917AbeB1QOXQS0az (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 17:14:23 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yt-0006Xj-AW; Wed, 28 Feb 2018 15:22:31 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-000053-C7; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ralf Baechle" <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, "Maciej W. Rozycki" <macro@imgtec.com>
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.721276832@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 102/254] MIPS: ptrace: Fix FP context restoration
 FCSR regression
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@imgtec.com>

commit 4249548454f7ba4581aeee26bd83f42b48a14d15 upstream.

Fix a floating-point context restoration regression introduced with
commit 9b26616c8d9d ("MIPS: Respect the ISA level in FCSR handling")
that causes a Floating Point exception and consequently a kernel oops
with hard float configurations when one or more FCSR Enable and their
corresponding Cause bits are set both at a time via a ptrace(2) call.

To do so reinstate Cause bit masking originally introduced with commit
b1442d39fac2 ("MIPS: Prevent user from setting FCSR cause bits") to
address this exact problem and then inadvertently removed from the
PTRACE_SETFPREGS request with the commit referred above.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13238/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -176,6 +176,7 @@ int ptrace_setfpregs(struct task_struct
 	}
 
 	__get_user(value, data + 64);
+	value &= ~FPU_CSR_ALL_X;
 	fcr31 = child->thread.fpu.fcr31;
 	mask = boot_cpu_data.fpu_msk31;
 	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
