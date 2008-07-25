Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 17:25:43 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:29638 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28580122AbYGYQZl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2008 17:25:41 +0100
Received: from localhost (p3225-ipad203funabasi.chiba.ocn.ne.jp [222.146.82.225])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CF971AAA6; Sat, 26 Jul 2008 01:25:35 +0900 (JST)
Date:	Sat, 26 Jul 2008 01:27:31 +0900 (JST)
Message-Id: <20080726.012731.122621958.anemo@mba.ocn.ne.jp>
To:	geert@linux-m68k.org
Cc:	ralf@linux-mips.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux-m68k@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-arch@vger.kernel.org
Subject: Re: [patch 29/29] initrd: Fix virtual/physical mix-up in overwrite
 test
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64.0807242032430.701@anakin>
References: <20080717191758.556975996@mail.of.borg>
	<20080725.003526.39154055.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64.0807242032430.701@anakin>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 24 Jul 2008 20:49:27 +0200 (CEST), Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Because an argument of mips virt_to_phys() is an pointer and
> > initrd_start is unsigned long.  It seems most (all?) arch's
> > virt_to_phys() casts its argument to unsigned long internally.  Should
> > mips follow?
> 
> Alternatively, as initrd_start is really a virtual kernel address,
> perhaps it should be changed from unsigned long to void * instead?
> 
> It's cast to `void *' in several place. arch/xtensa/kernel/setup.c even
> has `extern void *initrd_start' to fool around this?

I agree it would make code cleaner, but the conversion might be
somewhat hard.

If we converted initrd_start (and initrd_end) to void *, we should
also convert INITRD_START, free_initrd_mem(), some other arch specific
local/global variables and printk format strings.  Also code like
"initrd_start & PAGE_MASK" should be changed too...

Is it worth to do?

---
Atsushi Nemoto
