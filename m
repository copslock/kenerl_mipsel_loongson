Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 05:27:21 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:64114 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037701AbWI1E1T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 05:27:19 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 28 Sep 2006 13:27:17 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id BA428417CD;
	Thu, 28 Sep 2006 13:27:14 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id AEA6F417CB;
	Thu, 28 Sep 2006 13:27:14 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k8S4RCW0073983;
	Thu, 28 Sep 2006 13:27:13 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 28 Sep 2006 13:27:12 +0900 (JST)
Message-Id: <20060928.132712.47915433.nemoto@toshiba-tops.co.jp>
To:	manoje@broadcom.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	mark.e.mason@broadcom.com
Subject: Re: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <710F16C36810444CA2F5821E5EAB7F230A0E91@NT-SJCA-0752.brcm.ad.broadcom.com>
References: <20060927.235804.95064004.anemo@mba.ocn.ne.jp>
	<710F16C36810444CA2F5821E5EAB7F230A0E91@NT-SJCA-0752.brcm.ad.broadcom.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12705
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 27 Sep 2006 19:17:16 -0700, "Manoj Ekbote" <manoje@broadcom.com> wrote:
> I added a line that initializes the flush_icache_page pointer in
> sb1_cache_init.
> The below method worked. The SMP kernel boots fine now. Removing parts
> of local_sb1_flush_icache_page doesn't help. It looks like
> flush_icache_page in mm/memory.c:do_no_page is needed. Removing it will
> fail the boot process.

Thank you for testing.

Now I'm wondering why do_no_page() works on SMP.

	if (pte_none(*page_table)) {
		flush_icache_page(vma, new_page);
		entry = mk_pte(new_page, vma->vm_page_prot);
		if (write_access)
			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
		set_pte_at(mm, address, page_table, entry);
...
	} else {
		/* One of our sibling threads was faster, back out. */
		page_cache_release(new_page);
		goto unlock;
	}

	/* no need to invalidate: a not-present page shouldn't be cached */
	update_mmu_cache(vma, address, entry);

Other CPU might be able to load new pte value just after set_ste_at(),
but dcache is not flushed until update_mmu_cache().  Maybe I missed
something...

> I am wondering if people have booted the latest tree on non-Broadcom
> boards...curious to know if the removal of flush_icache_page has
> affected them.

Yes, Ralf and Thiemo said even some SB1 boards can work fine without
flush_icache_page.

---
Atsushi Nemoto
