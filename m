Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Jul 2010 03:44:21 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16619 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492605Ab0GXBmT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Jul 2010 03:42:19 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c4a45140002>; Fri, 23 Jul 2010 18:42:44 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 18:42:17 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Fri, 23 Jul 2010 18:42:17 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o6O1gCHZ004066;
        Fri, 23 Jul 2010 18:42:12 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o6O1gCPi004065;
        Fri, 23 Jul 2010 18:42:12 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, wim@iguana.be
Cc:     linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 5/7] MIPS: Export __cpu_number_map and __cpu_logical_map.
Date:   Fri, 23 Jul 2010 18:41:45 -0700
Message-Id: <1279935707-3997-6-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com>
References: <1279935707-3997-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Jul 2010 01:42:17.0187 (UTC) FILETIME=[72BF6B30:01CB2AD1]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The forthcoming Octeon watchdog driver will use them.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/smp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 6cdca19..383aeb9 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -47,8 +47,12 @@
 #endif /* CONFIG_MIPS_MT_SMTC */
 
 volatile cpumask_t cpu_callin_map;	/* Bitmask of started secondaries */
+
 int __cpu_number_map[NR_CPUS];		/* Map physical to logical */
+EXPORT_SYMBOL(__cpu_number_map);
+
 int __cpu_logical_map[NR_CPUS];		/* Map logical to physical */
+EXPORT_SYMBOL(__cpu_logical_map);
 
 /* Number of TCs (or siblings in Intel speak) per CPU core */
 int smp_num_siblings = 1;
-- 
1.7.1.1
