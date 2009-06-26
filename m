Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jun 2009 18:08:12 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:15787 "EHLO
	smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493349AbZFZQIG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Jun 2009 18:08:06 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a44f1710000>; Fri, 26 Jun 2009 12:04:01 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 26 Jun 2009 09:02:53 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 26 Jun 2009 09:02:53 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n5QG2ndp031437;
	Fri, 26 Jun 2009 09:02:49 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n5QG2mvM031435;
	Fri, 26 Jun 2009 09:02:48 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus.
Date:	Fri, 26 Jun 2009 09:02:48 -0700
Message-Id: <1246032168-31411-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 26 Jun 2009 16:02:53.0204 (UTC) FILETIME=[8FDE9540:01C9F677]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Some CPUs implement mipsr2, but because they are a super-set of
mips64r2 do not define CONFIG_CPU_MIPS64_R2.  Cavium OCTEON falls into
this category.  We would still like to use the optimized
implementation, so since we have already checked for
CONFIG_CPU_MIPSR2, checking for CONFIG_64BIT instead of
CONFIG_CPU_MIPS64_R2 is sufficient.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/swab.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/swab.h b/arch/mips/include/asm/swab.h
index 99993c0..e5b9161 100644
--- a/arch/mips/include/asm/swab.h
+++ b/arch/mips/include/asm/swab.h
@@ -38,7 +38,7 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 }
 #define __arch_swab32 __arch_swab32
 
-#ifdef CONFIG_CPU_MIPS64_R2
+#ifdef CONFIG_64BIT
 static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 {
 	__asm__(
-- 
1.6.0.6
