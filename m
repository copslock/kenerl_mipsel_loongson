Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2017 04:33:05 +0100 (CET)
Received: from resqmta-ch2-02v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:34]:46980
        "EHLO resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990428AbdKSDczQISKF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Nov 2017 04:32:55 +0100
Received: from resomta-ch2-07v.sys.comcast.net ([69.252.207.103])
        by resqmta-ch2-02v.sys.comcast.net with ESMTP
        id GGJJewTxakmbEGGJJeFYif; Sun, 19 Nov 2017 03:30:21 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-ch2-07v.sys.comcast.net with SMTP
        id GGJHeciw8LTOcGGJIeHQqz; Sun, 19 Nov 2017 03:30:20 +0000
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH] MIPS: Fix delay slot bug in `atomic*_sub_if_positive' for
 R10000_LLSC_WAR
To:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Maciej W. Rozycki" <macro@mips.com>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Message-ID: <db476905-551e-63af-c208-20224c9bd675@gentoo.org>
Date:   Sat, 18 Nov 2017 22:29:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMCNHqVQT9olArZj+xLteDV5oq2koDk4XeDsalz3rn98LN2MFTOH8GM1/7cVsDyLF6AtOgv99F7cR6iEFs3l4NsTR5VBQumi6w5AfigYIaTRcMhPotHz
 sPxuEYR6EDb/wTdkVoEJ8z/nYLOwtaRtRBe4ixUlkcfwq3Ft9sBSIkzb+69o7yps76PQ9HSCXd5Z/lrS2S427gLA5ZdFhsPWkSyay7zpGCI7cdcCeWEoY+77
 Hg+0mI3H4aXy06NonqltUcGjBblkDqUlPHIGC3LgexY=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

This patch fixes an old bug in MIPS ll/sc atomics, in the
`atomic_sub_if_positive' and `atomic64_sub_if_positive' functions, for
the R10000_LLSC_WAR case where the result of the subu/dsubu instruction
would potentially not be made available to the sc/scd instruction due
to being in the delay-slot of the branch-likely (beqzl) instruction.

This also removes the need for the `noreorder' directive, allowing GAS
to use delay slot scheduling as needed.

The same fix is also applied to the standard branch (beqz) case in
preparation for a follow-up patch that will cleanup/merge the
R10000_LLSC_WAR and non-R10K sections together.

Cc: linux-mips@linux-mips.org
Signed-off-by: Joshua Kinard <kumba@gentoo.org>
Tested-by: Joshua Kinard <kumba@gentoo.org>

---
 arch/mips/include/asm/atomic.h |   32 +++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 0ab176bdb8e8..0babf2775d8e 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -225,12 +225,10 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		"	.set	arch=r4000				\n"
 		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
 		"	subu	%0, %1, %3				\n"
+		"	move	%1, %0					\n"
 		"	bltz	%0, 1f					\n"
-		"	sc	%0, %2					\n"
-		"	.set	noreorder				\n"
-		"	beqzl	%0, 1b					\n"
-		"	 subu	%0, %1, %3				\n"
-		"	.set	reorder					\n"
+		"	sc	%1, %2					\n"
+		"	beqzl	%1, 1b					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp),
@@ -244,12 +242,10 @@ static __inline__ int atomic_sub_if_positive(int i, atomic_t * v)
 		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"1:	ll	%1, %2		# atomic_sub_if_positive\n"
 		"	subu	%0, %1, %3				\n"
+		"	move	%1, %0					\n"
 		"	bltz	%0, 1f					\n"
-		"	sc	%0, %2					\n"
-		"	.set	noreorder				\n"
-		"	beqz	%0, 1b					\n"
-		"	 subu	%0, %1, %3				\n"
-		"	.set	reorder					\n"
+		"	sc	%1, %2					\n"
+		"	beqz	%1, 1b					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp),
@@ -570,12 +566,10 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		"	.set	arch=r4000				\n"
 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
 		"	dsubu	%0, %1, %3				\n"
+		"	move	%1, %0					\n"
 		"	bltz	%0, 1f					\n"
-		"	scd	%0, %2					\n"
-		"	.set	noreorder				\n"
-		"	beqzl	%0, 1b					\n"
-		"	 dsubu	%0, %1, %3				\n"
-		"	.set	reorder					\n"
+		"	scd	%1, %2					\n"
+		"	beqzl	%1, 1b					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp),
@@ -589,12 +583,10 @@ static __inline__ long atomic64_sub_if_positive(long i, atomic64_t * v)
 		"	.set	"MIPS_ISA_LEVEL"			\n"
 		"1:	lld	%1, %2		# atomic64_sub_if_positive\n"
 		"	dsubu	%0, %1, %3				\n"
+		"	move	%1, %0					\n"
 		"	bltz	%0, 1f					\n"
-		"	scd	%0, %2					\n"
-		"	.set	noreorder				\n"
-		"	beqz	%0, 1b					\n"
-		"	 dsubu	%0, %1, %3				\n"
-		"	.set	reorder					\n"
+		"	scd	%1, %2					\n"
+		"	beqz	%1, 1b					\n"
 		"1:							\n"
 		"	.set	mips0					\n"
 		: "=&r" (result), "=&r" (temp),
