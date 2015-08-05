Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Aug 2015 23:50:40 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:48980 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012588AbbHEVuFm8lku (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Aug 2015 23:50:05 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZN6ZZ-0000u3-3A; Wed, 05 Aug 2015 21:50:05 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1ZN6ZW-0000BF-Sl; Wed, 05 Aug 2015 14:50:02 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 030/107] MIPS: kernel: cps-vec: Replace mips32r2 ISA level with mips64r2
Date:   Wed,  5 Aug 2015 14:48:22 -0700
Message-Id: <1438811379-384-31-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1438811379-384-1-git-send-email-kamal@canonical.com>
References: <1438811379-384-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48615
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

commit 977e043d5ea1270ce985e4c165724ff91dc3c3e2 upstream.

mips32r2 is a subset of mips64r2, so we replace mips32r2 with mips64r2
in preparation for 64-bit CPS support.

Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10588/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/cps-vec.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index a4b2d81..bbbd88e 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -229,7 +229,7 @@ LEAF(mips_cps_core_init)
 	 nop
 
 	.set	push
-	.set	mips32r2
+	.set	mips64r2
 	.set	mt
 
 	/* Only allow 1 TC per VPE to execute... */
@@ -346,7 +346,7 @@ LEAF(mips_cps_boot_vpes)
 	 nop
 
 	.set	push
-	.set	mips32r2
+	.set	mips64r2
 	.set	mt
 
 1:	/* Enter VPE configuration state */
-- 
1.9.1
