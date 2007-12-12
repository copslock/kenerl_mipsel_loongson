Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 15:33:02 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:44491 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20032611AbXLLPdA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 15:33:00 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBCFWIj5024565;
	Wed, 12 Dec 2007 15:32:19 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBCFWII6024564;
	Wed, 12 Dec 2007 15:32:18 GMT
Date:	Wed, 12 Dec 2007 15:32:18 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Florian Lohoff <flo@rfc822.org>
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@avtrex.com>
Subject: Re: 2.6.24-rc2 crash in kmap_coherent
Message-ID: <20071212153218.GA30291@linux-mips.org>
References: <20071211221327.GB2150@paradigm.rfc822.org> <20071212120610.GB28868@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071212120610.GB28868@linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 12, 2007 at 12:06:10PM +0000, Ralf Baechle wrote:

> > Call Trace:
> > [<ffffffff8801bcf0>] kmap_coherent+0x10/0x130
> > [<ffffffff8801c010>] copy_from_user_page+0x40/0xb0
> > [<ffffffff88079d10>] access_process_vm+0x168/0x1d8
> > [<ffffffff880d9014>] proc_pid_cmdline+0xac/0x140
> > [<ffffffff880db188>] proc_info_read+0x108/0x150
> > [<ffffffff8808fbdc>] vfs_read+0xec/0x178
> > [<ffffffff88090060>] sys_read+0x50/0x98
> > [<ffffffff88019718>] handle_sys+0x118/0x134
> > 
> > 
> > Code: 0002127a  00021000  30420001 <00028036> 8f820024  3c038843  24420001  af820024  dc62f390 
> 
> Hmm...  This suggests that 283abbaef425c1bf817ecbb456c413cab08b1434 is
> not quite right.  It is making the assumption that a mapped page never has
> PG_dcache_dirty set.

Totally untested because I have other stuff to do but something along the
lines of below patch, I think.

  Ralf

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 480dec0..db5d608 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -211,7 +211,8 @@ void copy_user_highpage(struct page *to, struct page *from,
 	void *vfrom, *vto;
 
 	vto = kmap_atomic(to, KM_USER1);
-	if (cpu_has_dc_aliases && page_mapped(from)) {
+	if (cpu_has_dc_aliases &&
+	    page_mapped(from) && !Page_dcache_dirty(from)) {
 		vfrom = kmap_coherent(from, vaddr);
 		copy_page(vto, vfrom);
 		kunmap_coherent();
@@ -234,7 +235,8 @@ void copy_to_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
 	unsigned long len)
 {
-	if (cpu_has_dc_aliases && page_mapped(page)) {
+	if (cpu_has_dc_aliases &&
+	    page_mapped(page) && !Page_dcache_dirty(from)) {
 		void *vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
 		memcpy(vto, src, len);
 		kunmap_coherent();
@@ -253,7 +255,8 @@ void copy_from_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
 	unsigned long len)
 {
-	if (cpu_has_dc_aliases && page_mapped(page)) {
+	if (cpu_has_dc_aliases &&
+	    page_mapped(page) && !Page_dcache_dirty(page)) {
 		void *vfrom = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
 		memcpy(dst, vfrom, len);
 		kunmap_coherent();
