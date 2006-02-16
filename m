Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2006 12:40:42 +0000 (GMT)
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:25512 "EHLO
	wip-ec-wd.wipro.com") by ftp.linux-mips.org with ESMTP
	id S8133398AbWBPMkd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 16 Feb 2006 12:40:33 +0000
Received: from wip-ec-wd.wipro.com (localhost.wipro.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id B000D20618
	for <linux-mips@linux-mips.org>; Thu, 16 Feb 2006 18:01:52 +0530 (IST)
Received: from blr-ec-bh01.wipro.com (blr-ec-bh01.wipro.com [10.201.50.91])
	by wip-ec-wd.wipro.com (Postfix) with ESMTP id 92DA4205DA
	for <linux-mips@linux-mips.org>; Thu, 16 Feb 2006 18:01:52 +0530 (IST)
Received: from PNE-HJN-MBX01.wipro.com ([10.111.50.182]) by blr-ec-bh01.wipro.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 16 Feb 2006 18:16:58 +0530
Received: from [10.111.17.97] ([10.111.17.97]) by PNE-HJN-MBX01.wipro.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 16 Feb 2006 18:16:57 +0530
Message-ID: <43F47420.9080708@wipro.com>
Date:	Thu, 16 Feb 2006 18:16:24 +0530
From:	Hemant Mohan <hemant.mohan@wipro.com>
Reply-To:  hemant.mohan@wipro.com
Organization: Wipro Technologies
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH] - PMC Titan network controller - compilation problem with
 gcc4.0.2
Content-Type: multipart/mixed;
 boundary="------------000605000809020206090109"
X-OriginalArrivalTime: 16 Feb 2006 12:46:57.0895 (UTC) FILETIME=[12B74770:01C632F7]
Return-Path: <hemant.mohan@wipro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hemant.mohan@wipro.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------000605000809020206090109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes the compilation error in PMC Titan network Controller, with 
gcc 4.0.2.

Thanks,
Hemant


--------------000605000809020206090109
Content-Type: text/plain;
 name="linux-2.6.15-net-titan.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.15-net-titan.patch"

Submitted By: Hemant Mohan (hemant dot mohan at wipro dot com)
Date: 2006-02-16
Initial Package Version: 2.6.15
Origin: Linux-MIPS
Description:  Fixes compilation error with PMC Titan network controller with gcc4.0.2

diff -Naur linux-2.6.15-mips-orig/drivers/net/titan_ge.h linux-mips-hemant-2.6.15/drivers/net/titan_ge.h
--- linux-2.6.15-mips-orig/drivers/net/titan_ge.h	2006-01-09 21:57:29.000000000 +0530
+++ linux-mips-hemant-2.6.15/drivers/net/titan_ge.h	2006-02-14 17:33:50.000000000 +0530
@@ -44,7 +44,6 @@
 #define	TITAN_SRAM_BASE		((OCD_READ(RM9000x2_OCD_LKB13) & ~1) << 4)
 #define	TITAN_SRAM_SIZE		0x2000UL
 
-extern unsigned long titan_ge_sram;
 
 /*
  * We may need these constants

--------------000605000809020206090109--
