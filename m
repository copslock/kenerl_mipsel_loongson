Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2009 20:44:11 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:10290 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026075AbZELTnV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2009 20:43:21 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a09d1400003>; Tue, 12 May 2009 15:42:56 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 12:42:00 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 May 2009 12:42:00 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4CJfuCQ020749;
	Tue, 12 May 2009 12:41:56 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4CJfuWb020748;
	Tue, 12 May 2009 12:41:56 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/3] MIPS: Remove execution hazard barriers for Octeon.
Date:	Tue, 12 May 2009 12:41:54 -0700
Message-Id: <1242157315-20719-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A09D0B1.2030305@caviumnetworks.com>
References: <4A09D0B1.2030305@caviumnetworks.com>
X-OriginalArrivalTime: 12 May 2009 19:42:00.0114 (UTC) FILETIME=[B7731920:01C9D339]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22690
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The Octeon has no execution hazards, so we can remove them and save an
instruction per TLB handler invocation.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 .../asm/mach-cavium-octeon/cpu-feature-overrides.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
index 04ce6e6..bb291f4 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/cpu-feature-overrides.h
@@ -47,6 +47,7 @@
 #define cpu_has_mips32r2	0
 #define cpu_has_mips64r1	0
 #define cpu_has_mips64r2	1
+#define cpu_has_mips_r2_exec_hazard 0
 #define cpu_has_dsp		0
 #define cpu_has_mipsmt		0
 #define cpu_has_userlocal	0
-- 
1.6.0.6
