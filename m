Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 09:43:03 +0000 (GMT)
Received: from hu-out-0506.google.com ([72.14.214.239]:4335 "EHLO
	hu-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021419AbXCSJm5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 09:42:57 +0000
Received: by hu-out-0506.google.com with SMTP id 22so5686013hug
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 02:41:57 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=sSyNLopgDOhdC0d3OhpVVpfogDiIO+ilG14mqfiJJ9PlRlxtMS08s80Ob7/ska9DUYOWLYSNod8TrbddYELxYvDWmSYIDRs/DiqNcrBaQBf5yIHFU3+ZyB2XSKwNY2VQfq3vW26T5zE7C6pbl4err7aX0FA3BaF0bu4WXRN9DY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding:from;
        b=FnSueOZOt5A2hmHLskTRws4MFkU9edbMcM/Uz4J4WZhl1rjfb3MontarNW6gIaUtVDmNuc1GmdvIc84es49v95SHlBnDN/G/kxG+S73WHM44pzBL4v3TJTeucZrgUTByEzYj9v4kp9m6ulmIcWAhVPP61NugZgGubd5+bPIrp7o=
Received: by 10.67.89.5 with SMTP id r5mr9562301ugl.1174297316879;
        Mon, 19 Mar 2007 02:41:56 -0700 (PDT)
Received: from ?192.168.0.24? ( [81.252.61.1])
        by mx.google.com with ESMTP id c25sm11823774ika.2007.03.19.02.41.55;
        Mon, 19 Mar 2007 02:41:56 -0700 (PDT)
Message-ID: <45FE5ADA.3030309@innova-card.com>
Date:	Mon, 19 Mar 2007 10:41:46 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	mbizon@freebox.fr, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Always use virt_to_phys() when translating kernel addresses
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

From: Franck Bui-Huu <fbuihuu@gmail.com>

This patch fixes two places where we used plain 'x - PAGE_OFFSET' to
achieve virtual to physical address convertion. This type of convertion
is no more allowed since commit 6f284a2ce7b8bc49cb8455b1763357897a899abb.

Reported-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 Ralf,

 Could you apply this patch. Unfortunately I failed to report back these
 changes when submitting the original patch, and without it, platforms
 which are using (or trying to use) PHYS_OFFSET will break.

 Thanks,
		Franck

 include/asm-mips/pgtable-64.h |    2 +-
 include/asm-mips/pgtable.h    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-mips/pgtable-64.h b/include/asm-mips/pgtable-64.h
index a5b1871..49f5a1a 100644
--- a/include/asm-mips/pgtable-64.h
+++ b/include/asm-mips/pgtable-64.h
@@ -199,7 +199,7 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
 {
 	return pud_val(pud);
 }
-#define pud_phys(pud)		(pud_val(pud) - PAGE_OFFSET)
+#define pud_phys(pud)		virt_to_phys((void *)pud_val(pud))
 #define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
 
 /* Find an entry in the second-level page table.. */
diff --git a/include/asm-mips/pgtable.h b/include/asm-mips/pgtable.h
index 3fcfd79..0d3295f 100644
--- a/include/asm-mips/pgtable.h
+++ b/include/asm-mips/pgtable.h
@@ -75,7 +75,7 @@ extern void paging_init(void);
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  */
-#define pmd_phys(pmd)		(pmd_val(pmd) - PAGE_OFFSET)
+#define pmd_phys(pmd)		virt_to_phys((void *)pmd_val(pmd))
 #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #define pmd_page_vaddr(pmd)	pmd_val(pmd)
 
-- 
1.4.4.3.ge6d4
