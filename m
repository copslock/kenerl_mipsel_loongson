Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 10:57:18 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:42723 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011126AbbHLI5Q0-yAA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 10:57:16 +0200
Received: from av-217-129-142-138.netvisao.pt ([217.129.142.138] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <luis.henriques@canonical.com>)
        id 1ZPRqV-0004by-TV; Wed, 12 Aug 2015 08:57:16 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 015/118] MIPS: kernel: traps: Fix broken indentation
Date:   Wed, 12 Aug 2015 09:55:17 +0100
Message-Id: <1439369820-27005-16-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1439369820-27005-1-git-send-email-luis.henriques@canonical.com>
References: <1439369820-27005-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luis.henriques@canonical.com
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

3.16.7-ckt16 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit 761b4493bbb7b614387794f39e3969716e9e0215 upstream.

Fix broken indentation caused by the SMTC removal
commit b633648c5ad3cfbda0b3daea50d2135d44899259
("MIPS: MT: Remove SMTC support")

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: b633648c5ad3c ("MIPS: MT: Remove SMTC support")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10581/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/kernel/traps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 51706d6dd5b0..c65062a6ff23 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1931,10 +1931,10 @@ void per_cpu_trap_init(bool is_boot_cpu)
 	BUG_ON(current->mm);
 	enter_lazy_tlb(&init_mm, current);
 
-		/* Boot CPU's cache setup in setup_arch(). */
-		if (!is_boot_cpu)
-			cpu_cache_init();
-		tlb_init();
+	/* Boot CPU's cache setup in setup_arch(). */
+	if (!is_boot_cpu)
+		cpu_cache_init();
+	tlb_init();
 	TLBMISS_HANDLER_SETUP();
 }
 
