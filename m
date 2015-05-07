Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 May 2015 11:49:08 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:59540 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012259AbbEGJsiZ8d9w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 May 2015 11:48:38 +0200
Received: from av-217-129-142-138.netvisao.pt ([217.129.142.138] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <luis.henriques@canonical.com>)
        id 1YqIQ4-0002LL-40; Thu, 07 May 2015 09:48:40 +0000
From:   Luis Henriques <luis.henriques@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 115/180] MIPS: Malta: Detect and fix bad memsize values
Date:   Thu,  7 May 2015 10:45:24 +0100
Message-Id: <1430991989-23170-116-git-send-email-luis.henriques@canonical.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430991989-23170-1-git-send-email-luis.henriques@canonical.com>
References: <1430991989-23170-1-git-send-email-luis.henriques@canonical.com>
X-Extended-Stable: 3.16
Return-Path: <luis.henriques@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47268
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

3.16.7-ckt11 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit f7f8aea4b97c4d48e42f02cb37026bee445f239f upstream.

memsize denotes the amount of RAM we can access from kseg{0,1} and
that should be up to 256M. In case the bootloader reports a value
higher than that (perhaps reporting all the available RAM) it's best
if we fix it ourselves and just warn the user about that. This is
usually a problem with the bootloader and/or its environment.

[ralf@linux-mips.org: Remove useless parens as suggested bei Sergei.
Reformat long pr_warn statement to fit into 80 column limit.]

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9362/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/mips/mti-malta/malta-memory.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
index fdffc806664f..9b3a07d962ce 100644
--- a/arch/mips/mti-malta/malta-memory.c
+++ b/arch/mips/mti-malta/malta-memory.c
@@ -52,6 +52,12 @@ fw_memblock_t * __init fw_getmdesc(int eva)
 		pr_warn("memsize not set in YAMON, set to default (32Mb)\n");
 		physical_memsize = 0x02000000;
 	} else {
+		if (memsize > (256 << 20)) { /* memsize should be capped to 256M */
+			pr_warn("Unsupported memsize value (0x%lx) detected! "
+				"Using 0x10000000 (256M) instead\n",
+				memsize);
+			memsize = 256 << 20;
+		}
 		/* If ememsize is set, then set physical_memsize to that */
 		physical_memsize = ememsize ? : memsize;
 	}
