Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2017 16:04:58 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.154.233]:53767 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992197AbdJKOEvzWeVr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2017 16:04:51 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1403.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 11 Oct 2017 14:04:28 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 11 Oct 2017 07:02:19 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] clocksource/mips-gic-timer: Ensure IRQs disabled for read-update-write
Date:   Wed, 11 Oct 2017 15:01:13 +0100
Message-ID: <1507730474-8577-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1507730474-8577-1-git-send-email-matt.redfearn@mips.com>
References: <1507730474-8577-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1507730617-321459-28167-997-6
X-BESS-VER: 2017.12-r1709122024
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.185890
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
X-archive-position: 60364
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

The sequence of reading the current count, adding an offset and writing
back to the compare register is timing critical.
Commit e07127a077c7 ("clocksource: mips-gic-timer: Use new GIC accessor
functions") added a local_irq_save / local_irq_restore to protect the
mapping of another VPs registers through the VP redirect region, but
given the timing critical nature of this code it just feels right to
protect the whole read-update-write section, so move the local_irq_save
before the current count is read.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

 drivers/clocksource/mips-gic-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 6c94a74682a2..dadac9f3e9c4 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -43,9 +43,9 @@ static int gic_next_event(unsigned long delta, struct clock_event_device *evt)
 	u64 cnt;
 	int res;
 
+	local_irq_save(flags);
 	cnt = gic_read_count();
 	cnt += (u64)delta;
-	local_irq_save(flags);
 	write_gic_vl_other(mips_cm_vp_id(cpumask_first(evt->cpumask)));
 	write_gic_vo_compare(cnt);
 	local_irq_restore(flags);
-- 
2.7.4
