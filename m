Received:  by oss.sgi.com id <S305171AbQDFTvq>;
	Thu, 6 Apr 2000 12:51:46 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60798 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305167AbQDFTvj>; Thu, 6 Apr 2000 12:51:39 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA09689; Thu, 6 Apr 2000 12:55:26 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id MAA97063; Thu, 6 Apr 2000 12:51:38 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA51448
	for linux-list;
	Thu, 6 Apr 2000 01:55:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA40159
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 6 Apr 2000 01:55:14 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id BAA21500
	for <linux@cthulhu.engr.sgi.com>; Thu, 6 Apr 2000 01:50:17 -0700 (PDT)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id KAA04684;
	Thu, 6 Apr 2000 10:51:17 +0200 (MET DST)
Date:   Thu, 6 Apr 2000 10:51:17 +0200 (MET DST)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Florian Lohoff <flo@rfc822.org>
cc:     linux@cthulhu.engr.sgi.com
Subject: Re: cause of early indigo2 crash
In-Reply-To: <20000405223413.B996@paradigm.rfc822.org>
Message-ID: <Pine.GSO.4.10.10004061050160.28032-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, 5 Apr 2000, Florian Lohoff wrote:
> i discovered that the prom of the indigo2 reports 2 MEMTYPE_FREE
> segments - One at 08002000 and the other at 88000000 - The second one
> at least 16 times larger - If i exclude the first segment from beeing
> freed and thus used the kernel boots much further - This is what
> i did in the arch/mips/arc/memory.c
> 
>         for (i = 0; pblocks[i].size; i++)
>                 if (pblocks[i].type == MEMTYPE_FREE &&
>                                 pblocks[i].base != 0x8002000)
>                         free_bootmem(pblocks[i].base, pblocks[i].size);
> 
> Now i get a very different crash - After SCSI Detection i get
> 
> scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=96, scaling
> scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=80, scaling
> scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=64, scaling
> scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=48, scaling
>        WARNING, not enough memory, pool not expanded
> Unable to handle kernel paging request at virtual address 00000000, epc == 880cc668, ra == 880cc5d8
> [...]
  ^^^^^
What's here? Usually it tells the function where it crashes.

> Thats it - Might the first area be DMA bounce buffer only which have to
> be initialized in the memory controller ?

I see these panics sometimes as well. Where does the crash happen? Please
lookup in System.map.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
