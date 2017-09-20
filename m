Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Sep 2017 07:07:57 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20238 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990825AbdITFHtIc-09 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Sep 2017 07:07:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id BC6D79F0F4663;
        Wed, 20 Sep 2017 06:07:40 +0100 (IST)
Received: from localhost (10.20.78.67) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 20 Sep
 2017 06:07:42 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Fix perf event init
Date:   Tue, 19 Sep 2017 22:07:18 -0700
Message-ID: <20170920050718.22756-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.78.67]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Commit c311c797998c ("cpumask: make "nr_cpumask_bits" unsigned")
modified mipspmu_event_init() to cast the struct perf_event cpu field to
an unsigned integer before it is compared with nr_cpumask_bits (and
*ahem* did so without copying the linux-mips mailing list or any MIPS
developers...). This is broken because the cpu field may be -1 for
events which follow a process rather than being affine to a particular
CPU. When this is the case the cast to an unsigned int results in a
value equal to ULONG_MAX, which is always greater than nr_cpumask_bits
so we always fail mipspmu_event_init() and return -ENODEV.

The check against nr_cpumask_bits seems nonsensical anyway, so this
patch simply removes it. The cpu field is going to either be -1 or a
valid CPU number. Comparing it with nr_cpumask_bits is effectively
checking that it's a valid cpu number, but it seems safe to rely on the
core perf events code to ensure that's the case.

The end result is that this fixes use of perf on MIPS when not
constraining events to a particular CPU, and fixes the "perf list hw"
command which fails to list any events without this.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: c311c797998c ("cpumask: make "nr_cpumask_bits" unsigned")
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable <stable@vger.kernel.org> # v4.12+
---

 arch/mips/kernel/perf_event_mipsxx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index ea994cd80009..15ce0004a2f4 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -618,8 +618,7 @@ static int mipspmu_event_init(struct perf_event *event)
 		return -ENOENT;
 	}
 
-	if ((unsigned int)event->cpu >= nr_cpumask_bits ||
-	    (event->cpu >= 0 && !cpu_online(event->cpu)))
+	if (event->cpu >= 0 && !cpu_online(event->cpu))
 		return -ENODEV;
 
 	if (!atomic_inc_not_zero(&active_events)) {
-- 
2.14.1
