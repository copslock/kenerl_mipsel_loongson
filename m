Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jan 2016 01:07:23 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:47511 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014776AbcAPAHEKTtPn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jan 2016 01:07:04 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1aKEOV-0008Eo-89; Sat, 16 Jan 2016 00:07:03 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1aKEOS-0002Az-Eg; Fri, 15 Jan 2016 16:07:00 -0800
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 256/305] MIPS: CPS: drop .set mips64r2 directives
Date:   Fri, 15 Jan 2016 16:01:10 -0800
Message-Id: <1452902519-2754-257-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1452902519-2754-1-git-send-email-kamal@canonical.com>
References: <1452902519-2754-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt2 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Paul Burton <paul.burton@imgtec.com>

commit f3575e230cf8537951ebe3cc19974c5db2ff4f1c upstream.

Commit 977e043d5ea1 ("MIPS: kernel: cps-vec: Replace mips32r2 ISA level
with mips64r2") leads to .set mips64r2 directives being present in 32
bit (ie. CONFIG_32BIT=y) kernels. This is incorrect & leads to MIPS64
instructions being emitted by the assembler when expanding
pseudo-instructions. For example the "move" instruction can legitimately
be expanded to a "daddu". This causes problems when the kernel is run on
a MIPS32 CPU, as CONFIG_32BIT kernels of course often are...

Fix this by dropping the .set <ISA> directives entirely now that Kconfig
should be ensuring that kernels including this code are built with a
suitable -march= compiler flag.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/10869/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 209ded1..763d8b7 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -229,7 +229,6 @@ LEAF(mips_cps_core_init)
 	has_mt	t0, 3f
 
 	.set	push
-	.set	mips64r2
 	.set	mt
 
 	/* Only allow 1 TC per VPE to execute... */
@@ -348,7 +347,6 @@ LEAF(mips_cps_boot_vpes)
 	 nop
 
 	.set	push
-	.set	mips64r2
 	.set	mt
 
 1:	/* Enter VPE configuration state */
-- 
1.9.1
