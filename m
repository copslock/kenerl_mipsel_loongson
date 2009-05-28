Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 01:52:57 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:13989 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20024406AbZE1Awv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 01:52:51 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a1de03d0000>; Wed, 27 May 2009 20:52:13 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 17:52:23 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 17:52:23 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n4S0pkFV027989;
	Wed, 27 May 2009 17:51:46 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n4S0pDqo027987;
	Wed, 27 May 2009 17:51:13 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	wli@holomorphy.com, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 4/5] Enable hugetlbfs for more systems.
Date:	Wed, 27 May 2009 17:47:45 -0700
Message-Id: <1243471666-27915-4-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
In-Reply-To: <4A1DDED7.3020306@caviumnetworks.com>
References: <4A1DDED7.3020306@caviumnetworks.com>
X-OriginalArrivalTime: 28 May 2009 00:52:23.0047 (UTC) FILETIME=[8FC76970:01C9DF2E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

As part of adding hugetlbfs support for MIPS, I am adding a new
kconfig variable 'SYS_SUPPORTS_HUGETLBFS'.  Since some mips cpu
varients don't yet support it, we can enable selection of HUGETLBFS on
a system by system basis from the arch/mips/Kconfig.

CC: William Irwin <wli@holomorphy.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 fs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 9f7270f..c36d63b 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -124,7 +124,7 @@ config TMPFS_POSIX_ACL
 config HUGETLBFS
 	bool "HugeTLB file system support"
 	depends on X86 || IA64 || PPC64 || SPARC64 || (SUPERH && MMU) || \
-		   (S390 && 64BIT) || BROKEN
+		   (S390 && 64BIT) || SYS_SUPPORTS_HUGETLBFS || BROKEN
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
 	  ramfs. For architectures that support it, say Y here and read
-- 
1.6.0.6
