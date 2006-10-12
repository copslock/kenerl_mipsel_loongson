Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2006 11:06:05 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:20681 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037767AbWJLKGD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Oct 2006 11:06:03 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 12 Oct 2006 19:06:02 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 64C9A40447;
	Thu, 12 Oct 2006 19:06:00 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 5192B20440;
	Thu, 12 Oct 2006 19:06:00 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9CA5xW0035077;
	Thu, 12 Oct 2006 19:05:59 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 12 Oct 2006 19:05:59 +0900 (JST)
Message-Id: <20061012.190559.96685979.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: [PATCH 1/5] Make __pa() uses CPHYSADDR() if really needed
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <452D1567.1050706@innova-card.com>
References: <452CFC95.1080806@innova-card.com>
	<20061012.003007.08076055.anemo@mba.ocn.ne.jp>
	<452D1567.1050706@innova-card.com>
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
X-archive-position: 12914
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 11 Oct 2006 18:01:43 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > __pa() is used in many place indirectly via virt_to_page().
> 
> what about make virt_to_page() use virt_to_phys() instead ?

No objection for virt_to_phys(), but I found other __pa() usages in
kernel.

drivers/char/mem.c:       && addr >= __pa(high_memory);
drivers/char/mem.c:     return addr >= __pa(high_memory);
drivers/char/mem.c:     if (addr + count > __pa(high_memory))
drivers/char/mem.c:     pfn = __pa((u64)vma->vm_pgoff << PAGE_SHIFT) >> PAGE_SHIFT;

So __pa() should handle >512MB address unless we change all __pa() usages.

How about something like this ?

#if defined(CONFIG_64BITS) && !defined(CONFIG_BUILD_ELF64)
#define __pa(x)			((unsigned long)(x) - ((unsigned long)(x) >= CKSEG0 ? CKSEG0 : PAGE_OFFSET))
#else
#define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
#endif

In any case, I think virt_to_page() should use simpler virt_to_phys()
for better performance.

---
Atsushi Nemoto
