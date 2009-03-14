Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Mar 2009 16:17:53 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:1530 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21367734AbZCNQRr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 14 Mar 2009 16:17:47 +0000
Received: from localhost (p7238-ipad212funabasi.chiba.ocn.ne.jp [58.91.171.238])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 9DB77B5A7; Sun, 15 Mar 2009 01:17:40 +0900 (JST)
Date:	Sun, 15 Mar 2009 01:17:48 +0900 (JST)
Message-Id: <20090315.011748.128619265.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	jan.nikitenko@gmail.com, linux-mips@linux-mips.org
Subject: Re: fix oops in dma_unmap_page on not coherent mips platforms
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090313230049.GA30319@linux-mips.org>
References: <20081128075258.GA10200@nikitenko.systek.local>
	<20090313230049.GA30319@linux-mips.org>
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
X-archive-position: 22079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 14 Mar 2009 00:00:49 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > dma_cache_wback_inv() expects virtual address, but physical was provided
> > due to translation via plat_dma_addr_to_phys().
> > If replaced with dma_addr_to_virt(), page fault oops from dma_unmap_page()
> > is gone on au1550 platform.
> > 
> > Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>
> 
> Applied, finally ...

Good news!

And please take a look at this too:
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1232638931-6203-1-git-send-email-anemo%40mba.ocn.ne.jp

---
Atsushi Nemoto
