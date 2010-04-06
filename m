Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Apr 2010 22:30:11 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:17029 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492462Ab0DFUaG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Apr 2010 22:30:06 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bbb99d60000>; Tue, 06 Apr 2010 13:30:14 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 6 Apr 2010 13:29:54 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 6 Apr 2010 13:29:54 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.3/8.14.3) with ESMTP id o36KTqjk012765;
        Tue, 6 Apr 2010 13:29:52 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.3/8.14.3/Submit) id o36KTpVv012764;
        Tue, 6 Apr 2010 13:29:51 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
Date:   Tue,  6 Apr 2010 13:29:50 -0700
Message-Id: <1270585790-12730-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.6.1
X-OriginalArrivalTime: 06 Apr 2010 20:29:54.0757 (UTC) FILETIME=[EAC68F50:01CAD5C7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The ebase is relative to CKSEG0 not CAC_BASE.  On a 32-bit kernel they
are the same thing, for a 64-bit kernel they are not.

It happens to kind of work on a 64-bit kernel as they both reference
the same physical memory.  However since the CPU uses the CKSEG0 base,
determining if a J instruction will reach always gives the wrong
result unless we use the same number the CPU uses.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 7ce84bb..b122f76 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1706,7 +1706,7 @@ void __init trap_init(void)
 		ebase = (unsigned long)
 			__alloc_bootmem(size, 1 << fls(size), 0);
 	} else {
-		ebase = CAC_BASE;
+		ebase = CKSEG0;
 		if (cpu_has_mips_r2)
 			ebase += (read_c0_ebase() & 0x3ffff000);
 	}
-- 
1.6.6.1
