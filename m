Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Aug 2009 21:38:23 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:46584 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492793AbZHTTiR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 20 Aug 2009 21:38:17 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a8da5b80000>; Thu, 20 Aug 2009 15:36:29 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 Aug 2009 12:35:59 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 Aug 2009 12:35:58 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n7KJZseJ006082;
	Thu, 20 Aug 2009 12:35:54 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n7KJZrpJ006080;
	Thu, 20 Aug 2009 12:35:53 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Octeon: Check all CCAs in cvmx_write_csr.
Date:	Thu, 20 Aug 2009 12:35:53 -0700
Message-Id: <1250796953-6056-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 20 Aug 2009 19:35:59.0017 (UTC) FILETIME=[71871190:01CA21CD]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The current code only checks CCA of 0 when deciding if a dummy read is
needed.  Since the kernel can (and does) use other CCAs we need to
mask out the CCA bits from the address.  Since the address constant
now fits in 16 bits, there is an added benefit that smaller code is
generated.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/octeon/cvmx.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx.h b/arch/mips/include/asm/octeon/cvmx.h
index e31e3fe..9d9381e 100644
--- a/arch/mips/include/asm/octeon/cvmx.h
+++ b/arch/mips/include/asm/octeon/cvmx.h
@@ -271,7 +271,7 @@ static inline void cvmx_write_csr(uint64_t csr_addr, uint64_t val)
 	 * what RSL read we do, so we choose CVMX_MIO_BOOT_BIST_STAT
 	 * because it is fast and harmless.
 	 */
-	if ((csr_addr >> 40) == (0x800118))
+	if (((csr_addr >> 40) & 0x7ffff) == (0x118))
 		cvmx_read64(CVMX_MIO_BOOT_BIST_STAT);
 }
 
-- 
1.6.0.6
