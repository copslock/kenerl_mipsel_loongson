Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2015 19:34:33 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:20489 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008252AbbCGScLY28Kc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 Mar 2015 19:32:11 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C79C99AB9CC22;
        Sat,  7 Mar 2015 18:32:02 +0000 (GMT)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Sat, 7 Mar
 2015 18:32:06 +0000
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Sat, 7 Mar 2015
 10:32:05 -0800
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
CC:     <macro@linux-mips.org>, Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
Subject: [PATCH v2 10/17] MIPS: csrc-ioasic: Implement read_sched_clock
Date:   Sat, 7 Mar 2015 10:30:28 -0800
Message-ID: <1425753035-17087-11-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 2.3.2
In-Reply-To: <1425753035-17087-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1425753035-17087-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

Use DEC I/O ASIC's free-running counter for sched_clock source. This
implementation will give high resolution cputime accounting.

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/kernel/csrc-ioasic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/mips/kernel/csrc-ioasic.c b/arch/mips/kernel/csrc-ioasic.c
index 54e394d..722f558 100644
--- a/arch/mips/kernel/csrc-ioasic.c
+++ b/arch/mips/kernel/csrc-ioasic.c
@@ -14,6 +14,7 @@
  *  GNU General Public License for more details.
  */
 #include <linux/clocksource.h>
+#include <linux/sched_clock.h>
 #include <linux/init.h>
 
 #include <asm/ds1287.h>
@@ -33,6 +34,11 @@ static struct clocksource clocksource_dec = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static u64 notrace dec_ioasic_read_sched_clock(void)
+{
+	return ioasic_read(IO_REG_FCTR);
+}
+
 int __init dec_ioasic_clocksource_init(void)
 {
 	unsigned int freq;
@@ -61,5 +67,8 @@ int __init dec_ioasic_clocksource_init(void)
 
 	clocksource_dec.rating = 200 + freq / 10000000;
 	clocksource_register_hz(&clocksource_dec, freq);
+
+	sched_clock_register(dec_ioasic_read_sched_clock, 32, freq);
+
 	return 0;
 }
-- 
2.3.2
