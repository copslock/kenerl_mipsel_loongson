Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Feb 2018 17:09:31 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53527 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993928AbeB1QJNX6oaz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Feb 2018 17:09:13 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Ys-0006Xh-HK; Wed, 28 Feb 2018 15:22:30 +0000
Received: from ben by deadeye with local (Exim 4.90_1)
        (envelope-from <ben@decadent.org.uk>)
        id 1er3Yg-00005h-Jg; Wed, 28 Feb 2018 15:22:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paul Burton" <Paul.Burton@mips.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        "James Hogan" <james.hogan@mips.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        "Alex Smith" <alex@alex-smith.me.uk>, linux-mips@linux-mips.org
Date:   Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.14230707@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 110/254] MIPS: Disallow outsized PTRACE_SETREGSET
 NT_PRFPREG regset accesses
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62746
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

From: "Maciej W. Rozycki" <macro@mips.com>

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/ptrace.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -568,6 +568,9 @@ static int fpr_set(struct task_struct *t
 
 	BUG_ON(count % sizeof(elf_fpreg_t));
 
+	if (pos + count > sizeof(elf_fpregset_t))
+		return -EIO;
+
 	init_fp_ctx(target);
 
 	if (sizeof(target->thread.fpu.fpr[0]) == sizeof(elf_fpreg_t))
