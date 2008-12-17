Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Dec 2008 21:29:18 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:50633 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207982AbYLQV2v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 17 Dec 2008 21:28:51 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49496f0d0003>; Wed, 17 Dec 2008 16:28:45 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Dec 2008 13:28:42 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Dec 2008 13:28:42 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBHLSeWY024909;
	Wed, 17 Dec 2008 13:28:40 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBHLSdKk024907;
	Wed, 17 Dec 2008 13:28:39 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Fix buggy __arch_swab64
Date:	Wed, 17 Dec 2008 13:28:39 -0800
Message-Id: <1229549319-24884-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
X-OriginalArrivalTime: 17 Dec 2008 21:28:42.0508 (UTC) FILETIME=[6F4364C0:01C9608E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The implementation of __arch_swab64 is incorrect.  The drotr should
not be there, so I removed it.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/byteorder.h |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/byteorder.h b/arch/mips/include/asm/byteorder.h
index 2988d29..33790b9 100644
--- a/arch/mips/include/asm/byteorder.h
+++ b/arch/mips/include/asm/byteorder.h
@@ -50,9 +50,8 @@ static inline __attribute_const__ __u32 __arch_swab32(__u32 x)
 static inline __attribute_const__ __u64 __arch_swab64(__u64 x)
 {
 	__asm__(
-	"	dsbh	%0, %1			\n"
-	"	dshd	%0, %0			\n"
-	"	drotr	%0, %0, 32		\n"
+	"	dsbh	%0, %1\n"
+	"	dshd	%0, %0"
 	: "=r" (x)
 	: "r" (x));
 
-- 
1.5.6.5
