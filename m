Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2006 10:39:52 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:43032 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037630AbWIZJju (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Sep 2006 10:39:50 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 26 Sep 2006 18:39:48 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 4C31D3330C;
	Tue, 26 Sep 2006 18:39:47 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 3318932DB5;
	Tue, 26 Sep 2006 18:39:47 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k8Q9dkW0065591;
	Tue, 26 Sep 2006 18:39:46 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 26 Sep 2006 18:39:46 +0900 (JST)
Message-Id: <20060926.183946.49857108.nemoto@toshiba-tops.co.jp>
To:	manoje@broadcom.com
Cc:	mark.e.mason@broadcom.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, ths@networkno.de
Subject: Re: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <710F16C36810444CA2F5821E5EAB7F230A0DFA@NT-SJCA-0752.brcm.ad.broadcom.com>
References: <20060823.131627.75185523.nemoto@toshiba-tops.co.jp>
	<710F16C36810444CA2F5821E5EAB7F230A0DFA@NT-SJCA-0752.brcm.ad.broadcom.com>
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
X-archive-position: 12670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 25 Sep 2006 20:05:59 -0700, "Manoj Ekbote" <manoje@broadcom.com> wrote:
> The latest tip still has problems with booting on Broadcom boards.
> I turned on a couple of printk's in the page fault handler and I see the
> following messages:
...
> It looks like a cache corruption issue.  Did the removal of
> flush_icache_page
> cause this? 

Yes perhaps.  But flush_icache_page() itself is obsolete API and
should be gone (see Documentation/cachetlb.txt).  So there should be
fault in somewhere else.

I think 

http://www.linux-mips.org/archives/linux-mips/2006-08/msg00184.html

is still needed, but it seems not enough.

If reverting flush_icache_page() worked, then you can debug more.

1. kill part of local_sb1_flush_icache_page().

If killing __sb1_writeback_inv_dcache_phys_range() part was OK, then
it would be dcache issue, if killing drop_mmu_context() part was OK,
then it would be icache issue.

2. kill calls of flush_icache_page().

If is used in only 3 places.

mm/fremap.c:    flush_icache_page(vma, page);
mm/memory.c:    flush_icache_page(vma, page);
mm/memory.c:            flush_icache_page(vma, new_page);

Finding which lines are required might help further investigation.


Another possible approach might be trying c-r4k.c instead of c-sb1.c.

If you wanted to debug with latest git tree, note that
include/asm-mips/hazard.h in current lmo git tree seems broken.  The
fix was already posted to this ML so hopefully we can see in git tree
soon...

---
Atsushi Nemoto
