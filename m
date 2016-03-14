Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Mar 2016 18:52:24 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:50958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008987AbcCNRwE4VIIi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Mar 2016 18:52:04 +0100
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D855CD0B;
        Mon, 14 Mar 2016 17:51:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 47/50] MIPS: smp.c: Fix uninitialised temp_foreign_map
Date:   Mon, 14 Mar 2016 10:51:05 -0700
Message-Id: <20160314175020.053660127@linuxfoundation.org>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <20160314175013.403628835@linuxfoundation.org>
References: <20160314175013.403628835@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52585
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/smp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -121,6 +121,7 @@ static inline void calculate_cpu_foreign
 	cpumask_t temp_foreign_map;
 
 	/* Re-calculate the mask */
+	cpumask_clear(&temp_foreign_map);
 	for_each_online_cpu(i) {
 		core_present = 0;
 		for_each_cpu(k, &temp_foreign_map)
