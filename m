Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2010 23:53:03 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16625 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491085Ab0JKVxA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Oct 2010 23:53:00 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cb3875c0000>; Mon, 11 Oct 2010 14:53:32 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 11 Oct 2010 14:53:09 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 11 Oct 2010 14:53:09 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o9BLqoc7027517;
        Mon, 11 Oct 2010 14:52:50 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o9BLqlJU027516;
        Mon, 11 Oct 2010 14:52:47 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Add a CONFIG_FORCE_MAX_ZONEORDER Kconfig option.
Date:   Mon, 11 Oct 2010 14:52:45 -0700
Message-Id: <1286833965-27484-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.2.3
X-OriginalArrivalTime: 11 Oct 2010 21:53:09.0778 (UTC) FILETIME=[B1B34720:01CB698E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

For huge page support with base page size of 16K or 32K, we have to
increase the MAX_ORDER so that huge pages can be allocated.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fbaf08e..05f90d6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1596,6 +1596,28 @@ config PAGE_SIZE_64KB
 
 endchoice
 
+config FORCE_MAX_ZONEORDER
+	int "Maximum zone order"
+	range 13 64 if SYS_SUPPORTS_HUGETLBFS && PAGE_SIZE_32KB
+	default "13" if SYS_SUPPORTS_HUGETLBFS && PAGE_SIZE_32KB
+	range 12 64 if SYS_SUPPORTS_HUGETLBFS && PAGE_SIZE_16KB
+	default "12" if SYS_SUPPORTS_HUGETLBFS && PAGE_SIZE_16KB
+	range 11 64
+	default "11"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value.
+
+	  This config option is actually maximum order plus one. For example,
+	  a value of 11 means that the largest free memory block is 2^10 pages.
+
+	  The page size is not necessarily 4KB.  Keep this in mind
+	  when choosing a value for this option.
+
 config BOARD_SCACHE
 	bool
 
-- 
1.7.2.3
