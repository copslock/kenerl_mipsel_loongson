Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Oct 2006 04:19:56 +0100 (BST)
Received: from mms1.broadcom.com ([216.31.210.17]:50951 "EHLO
	mms1.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20040639AbWJBDTy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 2 Oct 2006 04:19:54 +0100
Received: from 10.10.64.154 by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.2)); Sun, 01 Oct 2006 20:19:38 -0700
X-Server-Uuid: 8BFFF8BB-6D19-4612-8F54-AA4CE9D0539E
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 44F092AF; Sun, 1 Oct 2006 20:19:38 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 197BA2AE; Sun, 1 Oct
 2006 20:19:38 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EGI25095; Sun, 1 Oct 2006 20:19:37 -0700 (PDT)
Received: from NT-SJCA-0751.brcm.ad.broadcom.com (nt-sjca-0751
 [10.16.192.221]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 A09DF20501; Sun, 1 Oct 2006 20:19:37 -0700 (PDT)
Received: from NT-SJCA-0752.brcm.ad.broadcom.com ([10.16.192.222]) by
 NT-SJCA-0751.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Sun, 1 Oct 2006 20:19:37 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
Date:	Sun, 1 Oct 2006 20:17:35 -0700
Message-ID: <710F16C36810444CA2F5821E5EAB7F23BB0E@NT-SJCA-0752.brcm.ad.broadcom.com>
Thread-Topic: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
Thread-Index: AcbitmP3HSNOWKknTka25vlIjnmtMgDGupR2
References: <20060927.235804.95064004.anemo@mba.ocn.ne.jp>
 <710F16C36810444CA2F5821E5EAB7F230A0E91@NT-SJCA-0752.brcm.ad.broadcom.com>
 <20060928.132712.47915433.nemoto@toshiba-tops.co.jp>
From:	"Manoj Ekbote" <manoje@broadcom.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	"Mark E Mason" <mark.e.mason@broadcom.com>
X-OriginalArrivalTime: 02 Oct 2006 03:19:37.0576 (UTC)
 FILETIME=[9749CE80:01C6E5D1]
X-TMWD-Spam-Summary: TS=20061002031940; SEV=2.0.2; DFV=A2006100110;
 IFV=2.0.4,4.0-8; RPD=4.00.0004; ENG=IBF;
 RPDID=303030312E30413031303230352E34353230383532362E303032392D412D;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: A2006100110_4.00.0004_4.0-8
X-WSS-ID: 693E5AC009W533065-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manoje@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manoje@broadcom.com
Precedence: bulk
X-list: linux-mips




-----Original Message-----
From: Atsushi Nemoto [mailto:anemo@mba.ocn.ne.jp]
Sent: Wed 9/27/2006 9:27 PM
To: Manoj Ekbote
Cc: linux-mips@linux-mips.org; ralf@linux-mips.org; Mark E Mason
Subject: Re: [MIPS] SB1: Build fix: delete initialization of flush_icache_page pointer.
 
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

It looks like the page with instructions has to be invalidated.I did a flush_cache_page in __update_cache.That seems to help too.

> I am wondering if people have booted the latest tree on non-Broadcom
> boards...curious to know if the removal of flush_icache_page has
> affected them.

Yes, Ralf and Thiemo said even some SB1 boards can work fine without
flush_icache_page.

---
Atsushi Nemoto
