Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 15:56:04 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:29164 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038755AbWI0O4B (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 27 Sep 2006 15:56:01 +0100
Received: from localhost (p2166-ipad26funabasi.chiba.ocn.ne.jp [220.104.88.166])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 1D2039CD2; Wed, 27 Sep 2006 23:55:55 +0900 (JST)
Date:	Wed, 27 Sep 2006 23:58:04 +0900 (JST)
Message-Id: <20060927.235804.95064004.anemo@mba.ocn.ne.jp>
To:	manoje@broadcom.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	mark.e.mason@broadcom.com
Subject: Re: [MIPS] SB1: Build fix: delete initialization of
 flush_icache_page pointer.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <710F16C36810444CA2F5821E5EAB7F230A0E45@NT-SJCA-0752.brcm.ad.broadcom.com>
References: <20060926.183946.49857108.nemoto@toshiba-tops.co.jp>
	<710F16C36810444CA2F5821E5EAB7F230A0E45@NT-SJCA-0752.brcm.ad.broadcom.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12692
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 26 Sep 2006 18:54:40 -0700, "Manoj Ekbote" <manoje@broadcom.com> wrote:
> I tried the patch that you pointed to and UP kernel boots fine. Looks
> like that was a icache and dcache coherency problem now that there is no
> flush_icache_page implementation.

Hmm ... so it might be a SMP kernel problem?

> Oh, inserting flush_icache_page caused the kernel to panic. I also see
> that __flush_icache_page is not used anywhere. Any future use?

I think __flush_icache_page should go away.  Here is a patch.
http://www.linux-mips.org/archives/linux-mips/2006-09/msg00003.html

BTW, what you tried is something like this ?

include/asm-mips/cacheflush.h:
static inline void flush_icache_page(struct vm_area_struct *vma,
	struct page *page)
{
	__flush_icache_page(vma, page);
}

If this caused panic, what is the message?

---
Atsushi Nemoto
