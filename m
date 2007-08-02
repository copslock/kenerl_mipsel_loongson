Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 15:55:08 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:63727 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021983AbXHBOzF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2007 15:55:05 +0100
Received: from localhost (p2209-ipad28funabasi.chiba.ocn.ne.jp [220.107.201.209])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EC47BA309; Thu,  2 Aug 2007 23:54:58 +0900 (JST)
Date:	Thu, 02 Aug 2007 23:56:06 +0900 (JST)
Message-Id: <20070802.235606.122255120.anemo@mba.ocn.ne.jp>
To:	tiansm@lemote.com
Cc:	alsa-devel@alsa-project.org, linux-mips@linux-mips.org
Subject: Re: ALSA on MIPS platform
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46B03CC0.3090000@lemote.com>
References: <46B03CC0.3090000@lemote.com>
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
X-archive-position: 16043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 01 Aug 2007 15:56:48 +0800, Songmao Tian <tiansm@lemote.com> wrote:
>     The problem is clear:
> 1. dma_alloc_noncoherent() return a non-cached address, and 
> virt_to_page() need a cached logical addr (Have I named it right?)
> 2. mmaped dam buffer should be non-cached.
> 
> We have a ugly patch, but we want to solve the problem cleanly, so can 
> anyone show me the way?

virt_to_page() is used in many place in mm so making it robust might
affect performance.  IMHO virt_to_page() seems too low-level as DMA
API.

If something like dma_virt_to_page(dev, cpu_addr) which can take a cpu
address returned by dma_xxx APIs was defined, MIPS can implement it
appropriately.

And then pgprot_noncached issues still exist...

---
Atsushi Nemoto
