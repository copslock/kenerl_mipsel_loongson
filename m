Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 16:37:34 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.175.29]:5622 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021895AbXCSQh2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Mar 2007 16:37:28 +0000
Received: from localhost (p3228-ipad01funabasi.chiba.ocn.ne.jp [61.207.77.228])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id DCBF88D62; Tue, 20 Mar 2007 01:36:08 +0900 (JST)
Date:	Tue, 20 Mar 2007 01:36:08 +0900 (JST)
Message-Id: <20070320.013608.103777227.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: ZONE_DMA on MIPS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070319154821.GA31766@linux-mips.org>
References: <20070320.000947.88474417.anemo@mba.ocn.ne.jp>
	<20070319154821.GA31766@linux-mips.org>
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
X-archive-position: 14568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 19 Mar 2007 15:48:21 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Are there any other platforms requires special DMA zone?
> 
> Qemu supports more or less the full PC braind^Wheritage, including the
> good old too-old floppy controller.  IP22 supports Indigo 2 systems
> which have EISA support, so we only want ZONE_DMA if EISA is enabled.
> For a bunch of other systems ZONE_DMA may be required to support b0rked
> PCI cards that only support like 31-bit DMA addresses or even less.

Hmm... So do you think making ZONE_DMA customizable for each platform
(or user configurable) would have some sense?

For these legacy(?) PCI cards, we can check if it works or not by
pci_set_dma_mask(), at least.

---
Atsushi Nemoto
