Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 23:51:16 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:48993 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012612AbbHEVuGwTfpu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 23:50:06 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZN6Za-0000uO-7s; Wed, 05 Aug 2015 21:50:06 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1ZN6ZY-0000BP-07; Wed, 05 Aug 2015 14:50:04 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 032/107] MIPS: kernel: cps-vec: Replace KSEG0 with CKSEG0
Date:   Wed,  5 Aug 2015 14:48:24 -0700
Message-Id: <1438811379-384-33-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438811379-384-1-git-send-email-kamal@canonical.com>
References: <1438811379-384-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48617
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

3.19.8-ckt5 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit 717f14255a52ad445d6f0eca7d0f22f59d6ba1f8 upstream.

In preparation for 64-bit CPS support, we replace KSEG0 with CKSEG0
so 64-bit kernels can be supported.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10590/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 21f714a..2f95568 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -107,7 +107,7 @@ not_nmi:
 	mul	t1, t1, t0
 	mul	t1, t1, t2
 
-	li	a0, KSEG0
+	li	a0, CKSEG0
 	add	a1, a0, t1
 1:	cache	Index_Store_Tag_I, 0(a0)
 	add	a0, a0, t0
@@ -134,7 +134,7 @@ icache_done:
 	mul	t1, t1, t0
 	mul	t1, t1, t2
 
-	li	a0, KSEG0
+	li	a0, CKSEG0
 	addu	a1, a0, t1
 	subu	a1, a1, t0
 1:	cache	Index_Store_Tag_D, 0(a0)
-- 
1.9.1
