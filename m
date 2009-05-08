Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2009 07:31:14 +0100 (BST)
Received: from tenor.i-cable.com ([203.83.115.107]:60257 "HELO
	tenor.i-cable.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with SMTP id S20023605AbZEHGap (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2009 07:30:45 +0100
Received: (qmail 25012 invoked by uid 508); 8 May 2009 06:30:37 -0000
Received: from 203.83.114.121 by tenor (envelope-from <r0bertz@gentoo.org>, uid 505) with qmail-scanner-1.25 
 (clamdscan: 0.93.3/7824.  
 Clear:RC:1(203.83.114.121):. 
 Processed in 0.139213 secs); 08 May 2009 06:30:37 -0000
Received: from ip114121.hkicable.com (HELO silicon.i-cable.com) (203.83.114.121)
  by 0 with SMTP; 8 May 2009 06:30:36 -0000
Received: from localhost.localdomain (cm222-167-208-75.hkcable.com.hk [222.167.208.75])
	by silicon.i-cable.com (8.13.5/8.13.5) with ESMTP id n486UVwl000812;
	Fri, 8 May 2009 14:30:36 +0800 (HKT)
From:	Zhang Le <r0bertz@gentoo.org>
To:	linux-mips@linux-mips.org
Cc:	Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH 3/3] MIPS: handle write_combine in pci_mmap_page_range
Date:	Fri,  8 May 2009 14:30:03 +0800
Message-Id: <a892c7470d85f9563cc74c766fb4dd7f2fa0b801.1241764065.git.r0bertz@gentoo.org>
X-Mailer: git-send-email 1.6.2.3
In-Reply-To: <fb705e2eb405eea04853ae53639457a295a7dd90.1241764065.git.r0bertz@gentoo.org>
References: <cover.1241764064.git.r0bertz@gentoo.org>
 <a1356a5b181a188435ff569b4f7abe57cf8fd7eb.1241764065.git.r0bertz@gentoo.org>
 <fb705e2eb405eea04853ae53639457a295a7dd90.1241764065.git.r0bertz@gentoo.org>
In-Reply-To: <cover.1241764064.git.r0bertz@gentoo.org>
References: <cover.1241764064.git.r0bertz@gentoo.org>
Return-Path: <r0bertz@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22664
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: r0bertz@gentoo.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 arch/mips/pci/pci.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index b0eb9e7..4ca53ef 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -346,10 +346,14 @@ int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 		return -EINVAL;
 
 	/*
-	 * Ignore write-combine; for now only return uncached mappings.
+	 * For write-combine, return uncached accelerated mappings if CPU
+	 * supports; otherwise, return uncached mappings.
 	 */
 	prot = pgprot_val(vma->vm_page_prot);
-	prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED;
+	if (write_combine && cpu_has_uncached_accelerated)
+		prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED_ACCELERATED;
+	else
+		prot = (prot & ~_CACHE_MASK) | _CACHE_UNCACHED;
 	vma->vm_page_prot = __pgprot(prot);
 
 	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-- 
1.6.2.3
