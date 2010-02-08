Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2010 21:27:31 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9467 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492281Ab0BHU1J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Feb 2010 21:27:09 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b7073a20000>; Mon, 08 Feb 2010 12:27:14 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 8 Feb 2010 12:27:05 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 8 Feb 2010 12:27:05 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id o18KR2w2005444;
        Mon, 8 Feb 2010 12:27:02 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id o18KR0Mq005442;
        Mon, 8 Feb 2010 12:27:00 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Guenter Roeck <guenter.roeck@ericsson.com>
Subject: [PATCH] MIPS: Don't probe reserved EntryHi bits.
Date:   Mon,  8 Feb 2010 12:27:00 -0800
Message-Id: <1265660820-5418-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 08 Feb 2010 20:27:05.0166 (UTC) FILETIME=[142546E0:01CAA8FD]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The patch that adds cpu_probe_vmbits is erroneously writing to
reserved bit 12.  Since we are really only probing high bits, don't
write this bit with a one.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
CC: Guenter Roeck <guenter.roeck@ericsson.com>
---
 arch/mips/kernel/cpu-probe.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 2ff5f64..9ea5ca8 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -287,9 +287,9 @@ static inline int __cpu_has_fpu(void)
 static inline void cpu_probe_vmbits(struct cpuinfo_mips *c)
 {
 #ifdef __NEED_VMBITS_PROBE
-	write_c0_entryhi(0x3ffffffffffff000ULL);
+	write_c0_entryhi(0x3fffffffffffe000ULL);
 	back_to_back_c0_hazard();
-	c->vmbits = fls64(read_c0_entryhi() & 0x3ffffffffffff000ULL);
+	c->vmbits = fls64(read_c0_entryhi() & 0x3fffffffffffe000ULL);
 #endif
 }
 
-- 
1.6.0.6
