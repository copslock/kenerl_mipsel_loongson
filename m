Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2018 15:59:59 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:36031 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990723AbeDQN7vPonEo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Apr 2018 15:59:51 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 17 Apr 2018 13:59:40 +0000
Received: from mredfearn-linux.mipstec.com (192.168.155.41) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 17 Apr 2018 06:59:57 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
Date:   Tue, 17 Apr 2018 14:59:50 +0100
Message-ID: <1523973590-23356-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20180416221340.GB23881@saruman>
References: <20180416221340.GB23881@saruman>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523973580-321457-20211-1075-1
X-BESS-VER: 2018.4-r1804121647
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192082
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
X-archive-position: 63581
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
page fault is triggered within the memset_partial block, the value
loaded into a2 on return is meaningless.

The label .Lpartial_fixup\@ is jumped to on page fault. In order to work
out how many bytes failed to copy, the exception handler should find how
many bytes left in the partial block (andi a2, STORMASK), add that to
the partial block end address (a2), and subtract the faulting address to
get the remainder. Currently it incorrectly subtracts the partial block
start address (t1), which has additionally has been clobbered to
generate a jump target in memset_partial. Fix this by adding the block
end address instead.

Since this code is non-trivial to read, add comments to describe the
fault handling.

This issue was found with the following test code:
      int j, k;
      for (j = 0; j < 512; j++) {
        if ((k = clear_user(NULL, j)) != j) {
           pr_err("clear_user (NULL %d) returned %d\n", j, k);
        }
      }
Which now passes on Creator Ci40 (MIPS32) and Cavium Octeon II (MIPS64).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

Changes in v2:
- Use James Hogan's suggestion of replacing t1 with a0 to get the
  correct remainder count.
- Add comments to .Lpartial_fixup to aid those who next try to deciper
  this code.

 arch/mips/lib/memset.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 90bcdf1224ee..fa3bec269331 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -250,11 +250,11 @@
 
 .Lpartial_fixup\@:
 	PTR_L		t0, TI_TASK($28)
-	andi		a2, STORMASK
-	LONG_L		t0, THREAD_BUADDR(t0)
-	LONG_ADDU	a2, t1
+	andi		a2, STORMASK	/* #Bytes beyond partial block */
+	LONG_L		t0, THREAD_BUADDR(t0)	/* Get faulting address */
+	LONG_ADDU	a2, a0		/* Add end address of partial block */
 	jr		ra
-	LONG_SUBU	a2, t0
+	 LONG_SUBU	a2, t0		/* a2 = partial_end + #bytes - fault */
 
 .Llast_fixup\@:
 	jr		ra
-- 
2.7.4
