Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2018 15:40:20 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:35724 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992521AbeEWNkNw4DTL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 May 2018 15:40:13 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx26.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Wed, 23 May 2018 13:40:07 +0000
Received: from mredfearn-linux.mipstec.com (192.168.155.41) by
 mipsdag02.mipstec.com (10.20.40.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Wed, 23 May 2018 06:40:07 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] MIPS: memset.S: Fix byte_fixup for MIPSr6
Date:   Wed, 23 May 2018 14:39:58 +0100
Message-ID: <1527082799-14704-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag03.mipstec.com (10.20.40.48) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1527082806-853316-30554-232848-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193286
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64002
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

The __clear_user function is defined to return the number of bytes that
could not be cleared. From the underlying memset / bzero implementation
this means setting register a2 to that number on return. Currently if a
page fault is triggered within the MIPSr6 version of setting of initial
unaligned bytes, the value loaded into a2 on return is meaningless.

During the MIPSr6 version of the initial unaligned bytes block, register
a2 contains the number of bytes to be set beyond the initial unaligned
bytes. The t0 register is initally set to the number of unaligned bytes
- STORSIZE, effectively a negative version of the number of unaligned
bytes. This is then incremented before each byte is saved.

The label .Lbyte_fixup\@ is jumped to on page fault. Currently the value
in a2 is incorrectly replaced by 0 - t0 + 1, effectively the number of
unaligned bytes remaining. This leads to the failures being reported by
the following test code:

static int __init test_clear_user(void)
{
	int j, k;

	pr_info("\n\n\nTesting clear_user\n");
	for (j = 0; j < 512; j++) {
		if ((k = clear_user(NULL+3, j)) != j) {
			pr_err("clear_user (NULL %d) returned %d\n", j, k);
		}
	}
	return 0;
}
late_initcall(test_clear_user);

Which reports:
[    3.965439] Testing clear_user
[    3.973169] clear_user (NULL 8) returned 6
[    3.976782] clear_user (NULL 9) returned 6
[    3.980390] clear_user (NULL 10) returned 6
[    3.984052] clear_user (NULL 11) returned 6
[    3.987524] clear_user (NULL 12) returned 6

Fix this by subtracting t0 from a2 (rather than $0), effectivey giving:
unset_bytes = (#bytes - (#unaligned bytes)) - (-#unaligned bytes remaining + 1) + 1
     a2     =             a2                -              t0                   + 1

This fixes the value returned from __clear user when the number of bytes
to set is > LONGSIZE and the address is invalid and unaligned.

Unfortunately, this breaks the fixup handling for unaligned bytes after
the final long, where register a2 still contains the number of bytes
remaining to be set and the t0 register is to 0 - the number of
unaligned bytes remaining.

Because t0 is now is now subtracted from a2 rather than 0, the number of
bytes unset is reported incorrectly:

static int __init test_clear_user(void)
{
	char *test;
	int j, k;

	pr_info("\n\n\nTesting clear_user\n");
	test = vmalloc(PAGE_SIZE);

	for (j = 256; j < 512; j++) {
		if ((k = clear_user(test + PAGE_SIZE - 254, j)) != j - 254) {
			pr_err("clear_user (%px %d) returned %d\n",
				test + PAGE_SIZE - 254, j, k);
		}
	}
	return 0;
}
late_initcall(test_clear_user);

[    3.976775] clear_user (c00000000000df02 256) returned 4
[    3.981957] clear_user (c00000000000df02 257) returned 6
[    3.986425] clear_user (c00000000000df02 258) returned 8
[    3.990850] clear_user (c00000000000df02 259) returned 10
[    3.995332] clear_user (c00000000000df02 260) returned 12
[    3.999815] clear_user (c00000000000df02 261) returned 14

Fix this by ensuring that a2 is set to 0 during the set of final
unaligned bytes.

Fixes: 8c56208aff77 ("MIPS: lib: memset: Add MIPS R6 support")
Cc: stable@vger.kernel.org
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

Changes in v3:
New patch to fix fault handling during MIPSr6 version of setting
unaligned bytes.

Changes in v2: None

 arch/mips/lib/memset.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 1cc306520a5..fac26ce64b2 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -195,6 +195,7 @@
 #endif
 #else
 	 PTR_SUBU	t0, $0, a2
+	move		a2, zero		/* No remaining longs */
 	PTR_ADDIU	t0, 1
 	STORE_BYTE(0)
 	STORE_BYTE(1)
@@ -231,7 +232,7 @@
 
 #ifdef CONFIG_CPU_MIPSR6
 .Lbyte_fixup\@:
-	PTR_SUBU	a2, $0, t0
+	PTR_SUBU	a2, t0
 	jr		ra
 	 PTR_ADDIU	a2, 1
 #endif /* CONFIG_CPU_MIPSR6 */
-- 
2.7.4
