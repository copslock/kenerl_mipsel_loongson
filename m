Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Dec 2008 20:45:34 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:28571 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24188631AbYLQUpc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Dec 2008 20:45:32 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B494964dc0004>; Wed, 17 Dec 2008 15:45:16 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Dec 2008 12:44:07 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Dec 2008 12:44:07 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBHKi5E7003061;
	Wed, 17 Dec 2008 12:44:05 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBHKi4T2003058;
	Wed, 17 Dec 2008 12:44:04 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus.
Date:	Wed, 17 Dec 2008 12:44:04 -0800
Message-Id: <1229546644-3030-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
X-OriginalArrivalTime: 17 Dec 2008 20:44:07.0447 (UTC) FILETIME=[34CD7A70:01C96088]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21611
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
 arch/mips/include/asm/byteorder.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/byteorder.h b/arch/mips/include/asm/byteorder.h
index 2988d29..92ec1e1 100644
--- a/arch/mips/include/asm/byteorder.h
+++ b/arch/mips/include/asm/byteorder.h
@@ -46,7 +46,7 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 }
 #define __arch_swab32 __arch_swab32
 
-#ifdef CONFIG_CPU_MIPS64_R2
+#ifdef CONFIG_64BIT
 static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 {
 	__asm__(
-- 
1.5.6.5
