Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 01:54:05 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14651 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024406AbZE1Ax7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 01:53:59 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a1de0810000>; Wed, 27 May 2009 20:53:21 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 17:53:31 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 17:53:31 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4S0qsb3027996;
	Wed, 27 May 2009 17:52:54 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4S0qLVM027994;
	Wed, 27 May 2009 17:52:21 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	wli@holomorphy.com, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 5/5] MIPS: Add SYS_SUPPORTS_HUGETLBFS Kconfig variable and enable it for some systems.
Date:	Wed, 27 May 2009 17:47:46 -0700
Message-Id: <1243471666-27915-5-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A1DDED7.3020306@caviumnetworks.com>
References: <4A1DDED7.3020306@caviumnetworks.com>
X-OriginalArrivalTime: 28 May 2009 00:53:31.0031 (UTC) FILETIME=[B84CF270:01C9DF2E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Add new kconfig variables SYS_SUPPORTS_HUGETLBFS and
CPU_SUPPORTS_HUGEPAGES.  They are enabled for systems that are known
to support huge pages.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/Kconfig |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index c4a84a6..592949a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -852,6 +852,11 @@ config SYS_SUPPORTS_BIG_ENDIAN
 config SYS_SUPPORTS_LITTLE_ENDIAN
 	bool
 
+config SYS_SUPPORTS_HUGETLBFS
+	bool
+	depends on  CPU_SUPPORTS_HUGEPAGES && 64BIT
+	default y
+
 config IRQ_CPU
 	bool
 
@@ -1056,6 +1061,7 @@ config CPU_MIPS64_R1
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_HUGEPAGES
 	help
 	  Choose this option to build a kernel for release 1 or later of the
 	  MIPS64 architecture.  Many modern embedded systems with a 64-bit
@@ -1075,6 +1081,7 @@ config CPU_MIPS64_R2
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
 	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_HUGEPAGES
 	help
 	  Choose this option to build a kernel for release 2 or later of the
 	  MIPS64 architecture.  Many modern embedded systems with a 64-bit
@@ -1161,6 +1168,7 @@ config CPU_R5500
 	select CPU_HAS_LLSC
 	select CPU_SUPPORTS_32BIT_KERNEL
 	select CPU_SUPPORTS_64BIT_KERNEL
+	select CPU_SUPPORTS_HUGEPAGES
 	help
 	  NEC VR5500 and VR5500A series processors implement 64-bit MIPS IV
 	  instruction set.
@@ -1246,6 +1254,7 @@ config CPU_CAVIUM_OCTEON
 	select WEAK_ORDERING
 	select WEAK_REORDERING_BEYOND_LLSC
 	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_HUGEPAGES
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing
 	  many ethernet hardware widgets for networking tasks. The processor
@@ -1365,6 +1374,8 @@ config CPU_SUPPORTS_32BIT_KERNEL
 	bool
 config CPU_SUPPORTS_64BIT_KERNEL
 	bool
+config CPU_SUPPORTS_HUGEPAGES
+	bool
 
 #
 # Set to y for ptrace access to watch registers.
-- 
1.6.0.6
