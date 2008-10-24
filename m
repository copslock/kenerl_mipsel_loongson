Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:13:07 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:36711 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251773AbYJXA7H (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:59:07 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d690004>; Thu, 23 Oct 2008 20:57:13 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:13 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:12 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v74D005706;
	Thu, 23 Oct 2008 17:57:07 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v73b005705;
	Thu, 23 Oct 2008 17:57:07 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: [PATCH 36/37] Cavium OCTEON: pmd_none - use pmd_val() in pmd_val().
Date:	Thu, 23 Oct 2008 17:57:00 -0700
Message-Id: <1224809821-5532-37-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:12.0610 (UTC) FILETIME=[73253820:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

Before marking pmd_val as invalid_pte_table, factor in existing value
for pmd_val.

Signed-off-by: Paul Gortmaker <Paul.Gortmaker@windriver.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/pgtable-64.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 943515f..bb93bd5 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -129,7 +129,12 @@ extern pmd_t empty_bad_pmd_table[PTRS_PER_PMD];
  */
 static inline int pmd_none(pmd_t pmd)
 {
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+	return (pmd_val(pmd) == (unsigned long) invalid_pte_table) ||
+				(!pmd_val(pmd));
+#else
 	return pmd_val(pmd) == (unsigned long) invalid_pte_table;
+#endif
 }
 
 #define pmd_bad(pmd)		(pmd_val(pmd) & ~PAGE_MASK)
-- 
1.5.5.1
