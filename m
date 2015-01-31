Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 31 Jan 2015 06:23:48 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:39494 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006150AbbAaFXrYfvRQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 31 Jan 2015 06:23:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Message-Id:Date:Subject:Cc:To:From; bh=Z9aEyZ/H5cvE76Uv10fwgc+FgHdfviLbwKbP0QAWotM=;
        b=fCjKa0IjCXRBA6w69o+ZNHH4VN5rI7YnBE41Ol+kjRNJTq6S/qeemM3nsXQ18zDv4lQPlCBjif5r56bHy8iiNf1akY+OXywX3z+1440wGeqPaAnCaWKDmFDJZa84/A46GhwbldutZ4IzHU9ckb+RAdOKJI2D4Nm7qXozTNZ2tcQ=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YHQWx-001IPJ-Pk
        for linux-mips@linux-mips.org; Sat, 31 Jan 2015 05:23:40 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54879 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YHQWp-001ILe-00; Sat, 31 Jan 2015 05:23:31 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Matthew Wilcox <matthew.r.wilcox@intel.com>
Subject: [PATCH] mips: Re-introduce copy_user_page
Date:   Fri, 30 Jan 2015 21:23:27 -0800
Message-Id: <1422681807-28395-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.1.0
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020201.54CC66DC.003C,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 2
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Commit bcd022801ee5 ("MIPS: Fix COW D-cache aliasing on fork") replaced
the inline function copy_user_page for mips with an external reference,
but neglected to introduce the actual non-inline function. Restore it.

Fixes: bcd022801ee5 ("MIPS: Fix COW D-cache aliasing on fork")
Fixes: 4927b7d77c00 ("dax,ext2: replace the XIP page fault handler with the DAX page fault handler")
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Matthew Wilcox <matthew.r.wilcox@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
4927b7d77c00 is in -next.

 arch/mips/include/asm/page.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index 154b70a..69c2f19 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -105,8 +105,17 @@ static inline void clear_user_page(void *addr, unsigned long vaddr,
 		flush_data_cache_page((unsigned long)addr);
 }
 
-extern void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
-	struct page *to);
+static inline void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
+				  struct page *to)
+{
+	extern void (*flush_data_cache_page)(unsigned long addr);
+
+	copy_page(vto, vfrom);
+	if (!cpu_has_ic_fills_f_dc || pages_do_alias((unsigned long)vto,
+						     vaddr & PAGE_MASK))
+		flush_data_cache_page((unsigned long)vto);
+}
+
 struct vm_area_struct;
 extern void copy_user_highpage(struct page *to, struct page *from,
 	unsigned long vaddr, struct vm_area_struct *vma);
-- 
2.1.0
