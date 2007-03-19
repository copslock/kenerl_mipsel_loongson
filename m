Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 15:50:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:45954 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021775AbXCSPuU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 15:50:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2JFmM5j001981;
	Mon, 19 Mar 2007 15:48:22 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2JFmLfK001980;
	Mon, 19 Mar 2007 15:48:21 GMT
Date:	Mon, 19 Mar 2007 15:48:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: ZONE_DMA on MIPS
Message-ID: <20070319154821.GA31766@linux-mips.org>
References: <20070320.000947.88474417.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070320.000947.88474417.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Mar 20, 2007 at 12:09:47AM +0900, Atsushi Nemoto wrote:

> Some ZONE_DMA patches were merged in 2.6.21.  On most MIPS, ZONE_DMA
> is not needed, isn't it?
> 
> Currently JAZZ, MALTA, QEMU, IP22, SNI_RM, RBTX4938 defines
> GENERIC_ISA_DMA so they may need ZONE_DMA (though I wonder QEMU or
> RBTX4938 really need it...)
> 
> Are there any other platforms requires special DMA zone?

Qemu supports more or less the full PC braind^Wheritage, including the
good old too-old floppy controller.  IP22 supports Indigo 2 systems
which have EISA support, so we only want ZONE_DMA if EISA is enabled.
For a bunch of other systems ZONE_DMA may be required to support b0rked
PCI cards that only support like 31-bit DMA addresses or even less.

  Ralf
