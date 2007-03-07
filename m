Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2007 17:01:41 +0000 (GMT)
Received: from sakura.staff.proxad.net ([213.228.1.107]:58546 "EHLO
	sakura.staff.proxad.net") by ftp.linux-mips.org with ESMTP
	id S20021603AbXCGRBh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 7 Mar 2007 17:01:37 +0000
Received: from max by sakura.staff.proxad.net with local (Exim 3.36 #1 (Debian))
	id 1HOzT2-0008O3-00; Wed, 07 Mar 2007 17:58:20 +0100
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take
	#2]
From:	Maxime Bizon <mbizon@freebox.fr>
Reply-To: mbizon@freebox.fr
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips <linux-mips@linux-mips.org>, ralf <ralf@linux-mips.org>
In-Reply-To: <cda58cb80703061339l2f8cfc09m5823b090b69a7aa7@mail.gmail.com>
References: <116841864595-git-send-email-fbuihuu@gmail.com>
	 <1172879147.964.65.camel@sakura.staff.proxad.net>
	 <cda58cb80703050615r4e559ca1u78517634ac23a27@mail.gmail.com>
	 <1173112433.7093.36.camel@sakura.staff.proxad.net>
	 <cda58cb80703061339l2f8cfc09m5823b090b69a7aa7@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Freebox
Date:	Wed, 07 Mar 2007 17:58:20 +0100
Message-Id: <1173286700.6970.24.camel@sakura.staff.proxad.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Return-Path: <mbizon@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips


On Tue, 2007-03-06 at 22:39 +0100, Franck Bui-Huu wrote:

>     - set PAGE_OFFSET to 0x90000000.
> 
> You said that you already tried the second solution but it fails. I
> don't see why though...

Ok that makes sense for me now.

Though on the opposite of other arch, on 32bits mips you will always
have PAGE_OFFSET == PHYS_OFFSET + 0x80000000 because of fixed KSEG.
Making it possible to change both confused me.

I found the problem, I think these two liners are missing from your
patch. My board now works correctly, with 2MB more free memory, thanks
for this ! (and for the free tour in mm/ ;)




Commit 6f284a2ce7b8bc49cb8455b1763357897a899abb introduced PHYS_OFFSET,
but missed some virtual to physical address conversion. The following
patch fixes it.


Signed-off-by: Maxime Bizon <mbizon@freebox.fr>

--- linux-2.6.20/include/asm-mips/pgtable.h	2007-02-04 21:22:45.000000000 +0100
+++ linux/include/asm-mips/pgtable.h	2007-03-07 17:28:20.000000000 +0100
@@ -75,7 +75,7 @@
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  */
-#define pmd_phys(pmd)		(pmd_val(pmd) - PAGE_OFFSET)
+#define pmd_phys(pmd)		(pmd_val(pmd) - PAGE_OFFSET + PHYS_OFFSET)
 #define pmd_page(pmd)		(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #define pmd_page_vaddr(pmd)	pmd_val(pmd)
 
--- linux-2.6.20/include/asm-mips/pgtable-64.h	2007-02-04 21:22:45.000000000 +0100
+++ linux/include/asm-mips/pgtable-64.h	2007-03-07 17:28:47.000000000 +0100
@@ -199,7 +199,7 @@
 {
 	return pud_val(pud);
 }
-#define pud_phys(pud)		(pud_val(pud) - PAGE_OFFSET)
+#define pud_phys(pud)		(pud_val(pud) - PAGE_OFFSET + PHYS_OFFSET)
 #define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
 
 /* Find an entry in the second-level page table.. */


-- 
Maxime
