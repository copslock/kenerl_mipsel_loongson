Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2016 00:33:52 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:41800 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013954AbcCOXdipFLaw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2016 00:33:38 +0100
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1afyT3-0001cK-Vf; Tue, 15 Mar 2016 23:33:38 +0000
Received: from kamal by fourier with local (Exim 4.86)
        (envelope-from <kamal@whence.com>)
        id 1afyT1-0006AK-9C; Tue, 15 Mar 2016 16:33:35 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 86/98] MIPS: smp.c: Fix uninitialised temp_foreign_map
Date:   Tue, 15 Mar 2016 16:31:20 -0700
Message-Id: <1458084692-23100-87-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1458084692-23100-1-git-send-email-kamal@canonical.com>
References: <1458084692-23100-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52602
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

4.2.8-ckt6 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: James Hogan <james.hogan@imgtec.com>

commit d825c06bfe8b885b797f917ad47365d0e9c21fbb upstream.

When calculate_cpu_foreign_map() recalculates the cpu_foreign_map
cpumask it uses the local variable temp_foreign_map without initialising
it to zero. Since the calculation only ever sets bits in this cpumask
any existing bits at that memory location will remain set and find their
way into cpu_foreign_map too. This could potentially lead to cache
operations suboptimally doing smp calls to multiple VPEs in the same
core, even though the VPEs share primary caches.

Therefore initialise temp_foreign_map using cpumask_clear() before use.

Fixes: cccf34e9411c ("MIPS: c-r4k: Fix cache flushing for MT cores")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/12759/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/smp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index a31896c..df62553 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -120,6 +120,7 @@ static inline void calculate_cpu_foreign_map(void)
 	cpumask_t temp_foreign_map;
 
 	/* Re-calculate the mask */
+	cpumask_clear(&temp_foreign_map);
 	for_each_online_cpu(i) {
 		core_present = 0;
 		for_each_cpu(k, &temp_foreign_map)
-- 
2.7.0
