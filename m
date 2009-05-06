Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 01:38:33 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16977 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021551AbZEFAgf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 01:36:35 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a00db800002>; Tue, 05 May 2009 20:36:16 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:35:29 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:35:28 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n460ZPdH022763;
	Tue, 5 May 2009 17:35:25 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n460ZPLD022762;
	Tue, 5 May 2009 17:35:25 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org, gregkh@suse.de
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 3/7] MIPS: Cavium-Octeon: Add more board type constants.
Date:	Tue,  5 May 2009 17:35:18 -0700
Message-Id: <1241570122-22728-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A00DA84.5040101@caviumnetworks.com>
References: <4A00DA84.5040101@caviumnetworks.com>
X-OriginalArrivalTime: 06 May 2009 00:35:28.0893 (UTC) FILETIME=[8E354AD0:01C9CDE2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

The bootloader now uses additional board type constants.  The
octeon-ethernet driver needs some of the new values.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/octeon/cvmx-bootinfo.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
index 692989a..f3c23a4 100644
--- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
+++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
@@ -157,6 +157,13 @@ enum cvmx_board_types_enum {
 	CVMX_BOARD_TYPE_NIC_XLE_4G = 21,
 	CVMX_BOARD_TYPE_EBT5600 = 22,
 	CVMX_BOARD_TYPE_EBH5201 = 23,
+	CVMX_BOARD_TYPE_EBT5200 = 24,
+	CVMX_BOARD_TYPE_CB5600  = 25,
+	CVMX_BOARD_TYPE_CB5601  = 26,
+	CVMX_BOARD_TYPE_CB5200  = 27,
+	/* Special 'generic' board type, supports many boards */
+	CVMX_BOARD_TYPE_GENERIC = 28,
+	CVMX_BOARD_TYPE_EBH5610 = 29,
 	CVMX_BOARD_TYPE_MAX,
 
 	/*
@@ -228,6 +235,12 @@ static inline const char *cvmx_board_type_to_string(enum
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NIC_XLE_4G)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBT5600)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBH5201)
+		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBT5200)
+		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CB5600)
+		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CB5601)
+		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_CB5200)
+		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_GENERIC)
+		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_EBH5610)
 		ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_MAX)
 
 			/* Customer boards listed here */
-- 
1.6.0.6
