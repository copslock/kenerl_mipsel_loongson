Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 16:28:10 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:53700 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037617AbWJKP2E (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2006 16:28:04 +0100
Received: from localhost (p6080-ipad213funabasi.chiba.ocn.ne.jp [124.85.71.80])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 78182B85D; Thu, 12 Oct 2006 00:27:50 +0900 (JST)
Date:	Thu, 12 Oct 2006 00:30:07 +0900 (JST)
Message-Id: <20061012.003007.08076055.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	fbuihuu@gmail.com
Subject: Re: [PATCH 1/5] Make __pa() uses CPHYSADDR() if really needed
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <452CFC95.1080806@innova-card.com>
References: <11605685251014-git-send-email-fbuihuu@gmail.com>
	<20061011.223352.126573442.anemo@mba.ocn.ne.jp>
	<452CFC95.1080806@innova-card.com>
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
X-archive-position: 12907
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 11 Oct 2006 16:15:49 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> If we look at how to convert a virtual address into a physical one,
> we have:
> 
> 	CPHYSADDR()
> 	__pa()
> 	virt_to_phys()
> 
> What definition would you give to each of them ?

Here's my understanding.

CPHYSADDR --- used to convert a CKSEG0 or CKSEG1 to a physical
address.  Be carefull when use it in 64-bit kernel.

__pa() --- inverse of __va(), of course :-) used to convert a kernel
linear logical address to a physycal address.

virt_to_phys() --- synonym of __pa() ?

Now I think passing kernel symbol address to __pa() is wrong.  This is
implied by DMA-mapping.txt:

  This rule also means that you may use neither kernel image addresses
  (items in data/text/bss segments), nor module image addresses, nor
  stack addresses for DMA.  These could all be mapped somewhere entirely
  different than the rest of physical memory.  Even if those classes of
  ...

Maybe introducing __pa_symbol() is better as your patch tried.

> BTW, if you grep for __pa() you'll notice that it's almost not used
> by the kernel. I suspect that's because of CPHYSADDR() existence which
> is really confusing.

__pa() is used in many place indirectly via virt_to_page().

---
Atsushi Nemoto
