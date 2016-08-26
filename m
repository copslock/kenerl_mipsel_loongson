Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 16:27:12 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3251 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992547AbcHZOXdJx0fG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 16:23:33 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 127309B9A027F;
        Fri, 26 Aug 2016 15:23:12 +0100 (IST)
Received: from localhost (10.100.200.141) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 26 Aug
 2016 15:23:15 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 19/19] MIPS: SEAD3: Remove custom read_persistent_clock
Date:   Fri, 26 Aug 2016 15:17:51 +0100
Message-ID: <20160826141751.13121-20-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160826141751.13121-1-paul.burton@imgtec.com>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.141]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54783
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

The SEAD3 board defines a custom implementation of read_persistent_clock
which does exactly the same dummy operation as the generic weak version.
Remove the not really implemented custom version.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2: None

 arch/mips/mti-sead3/sead3-time.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/mti-sead3/sead3-time.c b/arch/mips/mti-sead3/sead3-time.c
index 10b0bf3..71feb51 100644
--- a/arch/mips/mti-sead3/sead3-time.c
+++ b/arch/mips/mti-sead3/sead3-time.c
@@ -63,12 +63,6 @@ static unsigned int __init estimate_cpu_frequency(void)
 	return freq ;
 }
 
-void read_persistent_clock(struct timespec *ts)
-{
-	ts->tv_sec = 0;
-	ts->tv_nsec = 0;
-}
-
 int get_c0_perfcount_int(void)
 {
 	if (gic_present)
-- 
2.9.3
