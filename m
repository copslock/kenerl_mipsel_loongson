Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2009 01:37:45 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16970 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021374AbZEFAge (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2009 01:36:34 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a00db800001>; Tue, 05 May 2009 20:36:16 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:35:29 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 17:35:28 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n460ZOGn022759;
	Tue, 5 May 2009 17:35:24 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n460ZOnr022758;
	Tue, 5 May 2009 17:35:24 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org, gregkh@suse.de
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/7] MIPS: Export cvmx_sysinfo_get needed by octeon-ethernet driver.
Date:	Tue,  5 May 2009 17:35:17 -0700
Message-Id: <1241570122-22728-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A00DA84.5040101@caviumnetworks.com>
References: <4A00DA84.5040101@caviumnetworks.com>
X-OriginalArrivalTime: 06 May 2009 00:35:28.0893 (UTC) FILETIME=[8E354AD0:01C9CDE2]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/cavium-octeon/executive/cvmx-sysinfo.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c b/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
index 4812370..e583889 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-sysinfo.c
@@ -29,6 +29,7 @@
  * This module provides system/board/application information obtained
  * by the bootloader.
  */
+#include <linux/module.h>
 
 #include <asm/octeon/cvmx.h>
 #include <asm/octeon/cvmx-spinlock.h>
@@ -69,6 +70,7 @@ struct cvmx_sysinfo *cvmx_sysinfo_get(void)
 {
 	return &(state.sysinfo);
 }
+EXPORT_SYMBOL(cvmx_sysinfo_get);
 
 /**
  * This function is used in non-simple executive environments (such as
-- 
1.6.0.6
