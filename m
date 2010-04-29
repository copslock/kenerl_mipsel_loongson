Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 11:58:14 +0200 (CEST)
Received: from mx1.moondrake.net ([212.85.150.166]:41344 "EHLO
        mx1.mandriva.com" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S1492433Ab0D2J44 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 29 Apr 2010 11:56:56 +0200
Received: by mx1.mandriva.com (Postfix, from userid 501)
        id CC77827C006; Thu, 29 Apr 2010 11:56:55 +0200 (CEST)
Received: from office-abk.mandriva.com (unknown [195.7.104.248])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.mandriva.com (Postfix) with ESMTP id E522827C005
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 11:56:54 +0200 (CEST)
Received: from anduin.mandriva.com (fw2.mandriva.com [192.168.2.3])
        by office-abk.mandriva.com (Postfix) with ESMTP id 2429F84250
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 12:14:36 +0200 (CEST)
Received: from anduin.mandriva.com (localhost [127.0.0.1])
        by anduin.mandriva.com (Postfix) with ESMTP id 5B1BFFF855
        for <linux-mips@linux-mips.org>; Thu, 29 Apr 2010 11:58:49 +0200 (CEST)
From:   Arnaud Patard <apatard@mandriva.com>
To:     linux-mips@linux-mips.org
Subject: [PATCH] arch/mips/loongson/common/mem.c: fix phys_mem_access_prot() check
Organization: Mandriva
Date:   Thu, 29 Apr 2010 11:58:49 +0200
Message-ID: <m3vdbawpeu.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <arnaud.patard@mandriva.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: apatard@mandriva.com
Precedence: bulk
X-list: linux-mips

--=-=-=


The check used to determine if uncached accelerated should be used or
not is wrong. The parenthesis are misplaced and making the test fail.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=fix_phys_mem_access_prot_check.patch

Index: linux-2.6/arch/mips/loongson/common/mem.c
===================================================================
--- linux-2.6.orig/arch/mips/loongson/common/mem.c
+++ linux-2.6/arch/mips/loongson/common/mem.c
@@ -75,7 +75,7 @@ pgprot_t phys_mem_access_prot(struct fil
 	unsigned long end = offset + size;
 
 	if (__uncached_access(file, offset)) {
-		if (((uca_start && offset) >= uca_start) &&
+		if (uca_start && (offset >= uca_start) &&
 		    (end <= uca_end))
 			return __pgprot((pgprot_val(vma_prot) &
 					 ~_CACHE_MASK) |

--=-=-=--
