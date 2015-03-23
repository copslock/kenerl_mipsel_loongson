Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Mar 2015 13:33:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:4950 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014513AbbCWMc3Me2Iy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Mar 2015 13:32:29 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 94F165CE1C3C4;
        Mon, 23 Mar 2015 12:32:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 23 Mar 2015 12:32:24 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.138) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 23 Mar 2015 12:32:23 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] MIPS: Malta: malta-time: Ensure GIC counter is running
Date:   Mon, 23 Mar 2015 12:32:03 +0000
Message-ID: <1427113923-9840-4-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.3
In-Reply-To: <1427113923-9840-1-git-send-email-markos.chandras@imgtec.com>
References: <1427113923-9840-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.138]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

Start the GIC counter before we try to determine its frequency.

Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mti-malta/malta-time.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index ce02dbdedc62..128a74bd7cea 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -87,8 +87,10 @@ static void __init estimate_frequencies(void)
 
 	/* Initialize counters. */
 	start = read_c0_count();
-	if (gic_present)
+	if (gic_present) {
+		gic_start_count();
 		gicstart = gic_read_count();
+	}
 
 	/* Read counter exactly on falling edge of update flag. */
 	while (CMOS_READ(RTC_REG_A) & RTC_UIP);
-- 
2.3.3
