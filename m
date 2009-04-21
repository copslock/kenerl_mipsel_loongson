Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2009 01:34:46 +0100 (BST)
Received: from fwgate.192.149.94.202.in-addr.arpa ([202.94.149.254]:39654 "EHLO
	topsms.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20023498AbZDUAec (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Apr 2009 01:34:32 +0100
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 5D3774A1C9;
	Tue, 21 Apr 2009 09:26:33 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 4FBB14A1C6;
	Tue, 21 Apr 2009 09:26:33 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id n3L0YLnf076550;
	Tue, 21 Apr 2009 09:34:21 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 21 Apr 2009 09:34:21 +0900 (JST)
Message-Id: <20090421.093421.139385711.nemoto@toshiba-tops.co.jp>
To:	dan.j.williams@intel.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DMA: TXx9 Soc DMA Controller driver (v2)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <49ECF040.2000508@intel.com>
References: <e9c3a7c20904181305l5a7ea5dcy881b7faec8e447bf@mail.gmail.com>
	<20090420.033446.65190767.anemo@mba.ocn.ne.jp>
	<49ECF040.2000508@intel.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Mailer: Mew version 6.1 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 20 Apr 2009 14:59:28 -0700, Dan Williams <dan.j.williams@intel.com> wrote:
> >> There seems to be a lot of ifdef magic in the code based on these
> >> defines.  Can we move this magic and some of the pure definitions to
> >> drivers/dma/txx9dmac.h?  (See the "#ifdefs are ugly" section of
> >> Documentation/SubmittingPatches)
> > OK, I will try to clean them up.  But since I don't want to export
> > internal implementation details, some of the magics will be left in
> > txx9dmac.c, perhaps.
> 
> You only need to hide txx9dmac magic if the header was in
> include/linux/, but since it will be in drivers/dma/ you can assume
> it is private.

Oh I missed that you said driver/dma/txx9dmac.h, not include/asm/txx9/dmac.h.
OK, I will do.

> > The completion callback handler of the first descriptor should be
> > called _after_ the completion of the _last_ child of the descriptor.
> > Also I use desc_node for both dc->queue, dc->active_list and
> > txd.tx_list.  So if I putted all children to dc->queue or
> > dc->active_list, txx9dmac_descriptor_complete() (or its caller) will
> > be more complex.
> > Or do you mean adding another list_head to maintain txd.tx_list?  Or
> > something another at all?
> 
> The piece I was missing was that it would make
> txx9dmac_descriptor_complete() more complex.  So, I am fine with the
> leaving the current implementation.

Thanks.  I will add some comments about that.

---
Atsushi Nemoto
