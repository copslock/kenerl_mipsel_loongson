Received:  by oss.sgi.com id <S305156AbQCHLnJ>;
	Wed, 8 Mar 2000 03:43:09 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:24838 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305154AbQCHLmv>; Wed, 8 Mar 2000 03:42:51 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id DAA07140; Wed, 8 Mar 2000 03:46:04 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA36382
	for linux-list;
	Wed, 8 Mar 2000 00:21:59 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from deliverator.sgi.com (deliverator.sgi.com [150.166.91.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA16146
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 8 Mar 2000 00:21:48 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id AAA12098
	for <linux@cthulhu.engr.sgi.com>; Wed, 8 Mar 2000 00:17:07 -0800 (PST)
	mail_from (Geert.Uytterhoeven@sonycom.com)
Received: from dandelion.sonytel.be (dandelion.sonytel.be [193.74.243.153])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id JAA02091;
	Wed, 8 Mar 2000 09:14:27 +0100 (MET)
Date:   Wed, 8 Mar 2000 09:14:27 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     "Andrew R. Baker" <andrewb@uab.edu>
cc:     Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: problem with most recent 2.3 CVS kernel
In-Reply-To: <Pine.LNX.3.96.1000307160335.13309I-100000@lithium>
Message-ID: <Pine.GSO.4.10.10003080913030.1992-100000@dandelion.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Tue, 7 Mar 2000, Andrew R. Baker wrote:
> Everything goes well until just after the SCSI disk detection.  Then I
> get:
>
>
> scsi : detected 2 SCSI disks total.
> scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=160, scaling
> scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=128, scaling
> scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=96, scaling
> scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=80, scaling
> scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=64, scaling
> scsi::resize_dma_pool: WARNING, dma_sectors=0, wanted=48, scaling
>       WARNING, not enough memory, pool not expanded
> Unable to handle kernel paging request at virtual address 00000000, epc ==
> 880a4
> Oops in fault.c:do_page_fault, line 153:
> $0 : 00000000 881100e0 00000000 00000021
> $4 : 00000019 00000008 00000008 00000001
> $8 : 1004fc00 1000001f 00000003 88631e54
> $12: 00000000 0000000a 00000000 88115840
> $16: 00000000 bfbc0003 00000008 00000001
> $20: 00000080 00000049 0000003a 1004fc00
> $24: 00000020 bfbd9833
> $28: 88008000 88009e08 88635800 880a7714
> epc   : 880a77a4
>
>
> Any hints on this one?

I see the `Unable to handle kernel paging request at virtual address 00000000',
caused by `Oops in fault.c:do_page_fault, line 153' also. It seems to happen at
random places.

I once tried the additional NOPs in the R5000 exception handler, but that
didn't make a difference.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248638 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
