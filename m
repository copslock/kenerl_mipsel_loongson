Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2008 02:20:31 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:53314 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24207351AbYLRCU3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Dec 2008 02:20:29 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4949b35c0000>; Wed, 17 Dec 2008 21:20:12 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Dec 2008 18:19:22 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 17 Dec 2008 18:19:22 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mBI2JJ4G019096;
	Wed, 17 Dec 2008 18:19:19 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mBI2JICq019094;
	Wed, 17 Dec 2008 18:19:18 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Fix preprocessor warnings flaged by GCC 4.4
Date:	Wed, 17 Dec 2008 18:19:18 -0800
Message-Id: <1229566758-19069-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
X-OriginalArrivalTime: 18 Dec 2008 02:19:22.0412 (UTC) FILETIME=[0A418EC0:01C960B7]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/elf.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index a8eac16..d58f128 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -232,7 +232,7 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
  */
 #ifdef __MIPSEB__
 #define ELF_DATA	ELFDATA2MSB
-#elif __MIPSEL__
+#elif defined(__MIPSEL__)
 #define ELF_DATA	ELFDATA2LSB
 #endif
 #define ELF_ARCH	EM_MIPS
-- 
1.5.6.5
