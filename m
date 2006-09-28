Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 11:13:58 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:58077 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038571AbWI1KN4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 11:13:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8SAEnCG003420;
	Thu, 28 Sep 2006 11:14:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8SAEmgb003419;
	Thu, 28 Sep 2006 11:14:48 +0100
Date:	Thu, 28 Sep 2006 11:14:48 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	manoje@broadcom.com, linux-mips@linux-mips.org,
	mark.e.mason@broadcom.com
Subject: Re: [MIPS] SB1: Build fix: delete initialization of flush_icache_page pointer.
Message-ID: <20060928101448.GB747@linux-mips.org>
References: <20060927.235804.95064004.anemo@mba.ocn.ne.jp> <710F16C36810444CA2F5821E5EAB7F230A0E91@NT-SJCA-0752.brcm.ad.broadcom.com> <20060928.132712.47915433.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928.132712.47915433.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 28, 2006 at 01:27:12PM +0900, Atsushi Nemoto wrote:
> Date:	Thu, 28 Sep 2006 13:27:12 +0900 (JST)
> To:	manoje@broadcom.com
> Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
> 	mark.e.mason@broadcom.com
> Subject: Re: [MIPS] SB1: Build fix: delete initialization of
>  flush_icache_page pointer.
> From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> Content-Type: Text/Plain; charset=us-ascii
> 
> On Wed, 27 Sep 2006 19:17:16 -0700, "Manoj Ekbote" <manoje@broadcom.com> wrote:
> > I added a line that initializes the flush_icache_page pointer in
> > sb1_cache_init.
> > The below method worked. The SMP kernel boots fine now. Removing parts
> > of local_sb1_flush_icache_page doesn't help. It looks like
> > flush_icache_page in mm/memory.c:do_no_page is needed. Removing it will
> > fail the boot process.
> 
> Thank you for testing.
> 
> Now I'm wondering why do_no_page() works on SMP.
> 
> 	if (pte_none(*page_table)) {
> 		flush_icache_page(vma, new_page);
> 		entry = mk_pte(new_page, vma->vm_page_prot);
> 		if (write_access)
> 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> 		set_pte_at(mm, address, page_table, entry);
> ...
> 	} else {
> 		/* One of our sibling threads was faster, back out. */
> 		page_cache_release(new_page);
> 		goto unlock;
> 	}
> 
> 	/* no need to invalidate: a not-present page shouldn't be cached */
> 	update_mmu_cache(vma, address, entry);
> 
> Other CPU might be able to load new pte value just after set_ste_at(),
> but dcache is not flushed until update_mmu_cache().  Maybe I missed
> something...
> 
> > I am wondering if people have booted the latest tree on non-Broadcom
> > boards...curious to know if the removal of flush_icache_page has
> > affected them.
> 
> Yes, Ralf and Thiemo said even some SB1 boards can work fine without
> flush_icache_page.

The have to by definition - flush_icache_page is going to go away.

Note the SB1 cache code is a bizarre beast.  It totally avoids Hit-type
cacheops because those used to have problems on early silicon.  So my
favorite solution would be to dump c-sb1.c and deal with any SB1 issues
that may pop up in c-r4k.c.

  Ralf
