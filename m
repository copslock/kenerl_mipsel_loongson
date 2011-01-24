Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jan 2011 23:52:44 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7314 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491111Ab1AXWvy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jan 2011 23:51:54 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d3e02b90002>; Mon, 24 Jan 2011 14:52:41 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 14:51:52 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 24 Jan 2011 14:51:52 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id p0OMpnGU023371;
        Mon, 24 Jan 2011 14:51:49 -0800
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id p0OMpnZQ023370;
        Mon, 24 Jan 2011 14:51:49 -0800
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/4] MIPS: Fix GCC-4.6 'set but not used' warning in arch/mips/mm/init.c
Date:   Mon, 24 Jan 2011 14:51:37 -0800
Message-Id: <1295909497-23317-5-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1295909497-23317-1-git-send-email-ddaney@caviumnetworks.com>
References: <1295909497-23317-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Jan 2011 22:51:52.0175 (UTC) FILETIME=[4A9627F0:01CBBC19]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Under some combinations of CONFIG_*, lastpfn in page_is_ram is 'set
but not used'.  Mark it as __maybe_unused to quiet the warning/error.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/mm/init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index dff6421..0d4046c 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -329,7 +329,7 @@ int page_is_ram(unsigned long pagenr)
 void __init paging_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
-	unsigned long lastpfn;
+	unsigned long lastpfn __maybe_unused;
 
 	pagetable_init();
 
-- 
1.7.2.3
