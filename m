Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Aug 2009 15:28:34 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:43269 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492988AbZHaN21 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 31 Aug 2009 15:28:27 +0200
Received: by ewy25 with SMTP id 25so3869441ewy.33
        for <multiple recipients>; Mon, 31 Aug 2009 06:28:21 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=EcKgrvi2qdAPRbJfFhvfPPZfZKDj2ZLsfCnjqr3BzC4=;
        b=XtY2DldKkRkWSA1YQQ/ha+uDQhe4kNmLLH2DJUoN1WrqgrBhVwFy8aQKf2j6OvYG+8
         lyDjRaqbpRNuuc3Q9JJJVVAny2w6UGnlkZowp94Zfiv8NdbszJ6KlBfvOx0edT9YBhED
         vAEnfXdqcH+W6wPD7kRmdtcyml9I+YEnVUJ/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=PosD+ADVqhPY/rQA4lwT62za6CBL3Y1/R99gZKxv71NkhK85sNrPSPESF+RsCp0h4b
         eyunt3cQKCACf1MuvO+yKfmy6SolwYoJN70kfJX8iKYxhMSPzsP0B+LiKdpMFDXSGJMz
         TpZNyqcp21J+4I2RQGg4VYiqL8Yz5yYhngPOg=
Received: by 10.210.37.20 with SMTP id k20mr4487642ebk.73.1251725300931;
        Mon, 31 Aug 2009 06:28:20 -0700 (PDT)
Received: from desktop ([58.31.9.46])
        by mx.google.com with ESMTPS id 24sm278814eyx.29.2009.08.31.06.28.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 31 Aug 2009 06:28:18 -0700 (PDT)
Date:	Mon, 31 Aug 2009 21:28:12 +0800
From:	Wu Fei <at.wufei@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] cleanup vmalloc_fault for 64bit kernel
Message-ID: <20090831132811.GA6924@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <at.wufei@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: at.wufei@gmail.com
Precedence: bulk
X-list: linux-mips

64bit kernel won't arrive vmalloc_fault, it's not necessary or possible
to copy the page table from init_mm.pgd. swapper_pg_dir, module_pg_dir
and the process's pgd represent the different virtual address area, and
the tlb exception handler accesses the suitable one directly.

Signed-off-by: Wu Fei <at.wufei@gmail.com>
---
 arch/mips/mm/fault.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index f956ecb..e769789 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -58,11 +58,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * only copy the information from the master page table,
 	 * nothing more.
 	 */
+#ifdef CONFIG_32BIT
 	if (unlikely(address >= VMALLOC_START && address <= VMALLOC_END))
 		goto vmalloc_fault;
-#ifdef MODULE_START
-	if (unlikely(address >= MODULE_START && address < MODULE_END))
-		goto vmalloc_fault;
 #endif
 
 	/*
@@ -203,6 +201,7 @@ do_sigbus:
 	force_sig_info(SIGBUS, &info, tsk);
 
 	return;
+#ifdef CONFIG_32BIT
 vmalloc_fault:
 	{
 		/*
@@ -241,4 +240,5 @@ vmalloc_fault:
 			goto no_context;
 		return;
 	}
+#endif
 }
-- 
1.6.4.rc1
