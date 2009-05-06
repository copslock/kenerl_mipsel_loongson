Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 01:36:57 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16891 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021310AbZEFAg1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 01:36:27 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a00db800003>; Tue, 05 May 2009 20:36:16 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:35:29 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:35:28 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n460ZPrQ022767;
	Tue, 5 May 2009 17:35:25 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n460ZPEr022766;
	Tue, 5 May 2009 17:35:25 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org, gregkh@suse.de
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/7] MIPS: Cavium-Octeon: Add more chip specific feature tests.
Date:	Tue,  5 May 2009 17:35:19 -0700
Message-Id: <1241570122-22728-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A00DA84.5040101@caviumnetworks.com>
References: <4A00DA84.5040101@caviumnetworks.com>
X-OriginalArrivalTime: 06 May 2009 00:35:28.0909 (UTC) FILETIME=[8E37BBD0:01C9CDE2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The octeon-ethernet driver needs to check for additional chip specific
features, we add them to the octeon_has_feature() framework.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/octeon/octeon-feature.h |   27 +++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/octeon/octeon-feature.h b/arch/mips/include/asm/octeon/octeon-feature.h
index 04fac68..ef24a7b 100644
--- a/arch/mips/include/asm/octeon/octeon-feature.h
+++ b/arch/mips/include/asm/octeon/octeon-feature.h
@@ -57,6 +57,13 @@ enum octeon_feature {
 	OCTEON_FEATURE_RAID,
 	/* Octeon has a builtin USB */
 	OCTEON_FEATURE_USB,
+	/* Octeon IPD can run without using work queue entries */
+	OCTEON_FEATURE_NO_WPTR,
+	/* Octeon has DFA state machines */
+	OCTEON_FEATURE_DFA,
+	/* Octeon MDIO block supports clause 45 transactions for 10
+	 * Gig support */
+	OCTEON_FEATURE_MDIO_CLAUSE_45,
 };
 
 static inline int cvmx_fuse_read(int fuse);
@@ -112,6 +119,26 @@ static inline int octeon_has_feature(enum octeon_feature feature)
 	case OCTEON_FEATURE_USB:
 		return !(OCTEON_IS_MODEL(OCTEON_CN38XX)
 			 || OCTEON_IS_MODEL(OCTEON_CN58XX));
+	case OCTEON_FEATURE_NO_WPTR:
+		return (OCTEON_IS_MODEL(OCTEON_CN56XX)
+			 || OCTEON_IS_MODEL(OCTEON_CN52XX))
+			&& !OCTEON_IS_MODEL(OCTEON_CN56XX_PASS1_X)
+			&& !OCTEON_IS_MODEL(OCTEON_CN52XX_PASS1_X);
+	case OCTEON_FEATURE_DFA:
+		if (!OCTEON_IS_MODEL(OCTEON_CN38XX)
+		    && !OCTEON_IS_MODEL(OCTEON_CN31XX)
+		    && !OCTEON_IS_MODEL(OCTEON_CN58XX))
+			return 0;
+		else if (OCTEON_IS_MODEL(OCTEON_CN3020))
+			return 0;
+		else if (OCTEON_IS_MODEL(OCTEON_CN38XX_PASS1))
+			return 1;
+		else
+			return !cvmx_fuse_read(120);
+	case OCTEON_FEATURE_MDIO_CLAUSE_45:
+		return !(OCTEON_IS_MODEL(OCTEON_CN3XXX)
+			 || OCTEON_IS_MODEL(OCTEON_CN58XX)
+			 || OCTEON_IS_MODEL(OCTEON_CN50XX));
 	}
 	return 0;
 }
-- 
1.6.0.6
