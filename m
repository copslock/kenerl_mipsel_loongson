Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 22:52:46 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:15379 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122963AbSIRUwp>; Wed, 18 Sep 2002 22:52:45 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g8IKqD610627;
	Wed, 18 Sep 2002 13:52:13 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Brian Murphy" <brian@murphy.dk>,
	"Linux-MIPS" <linux-mips@linux-mips.org>
Subject: RE: fs problem between 2.4.19-rc1 and tip?
Date: Wed, 18 Sep 2002 13:52:13 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIOEBBCJAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <3D88B068.6080303@murphy.dk>
Importance: Normal
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

Well, that makes things significantly better.... I can mount my
filesystem now, tho I still get errors like:

EXT2-fs error (device sd(8,2)): ext2_check_page: bad entry in
directory #894638: unaligned directory entry - offset=4068,
inode=544829025, rec_len=28261, name_len=116

But, it does boot.  My serial console stopped (standard NS16550)
working, tho.... as did a custom NVRAM driver.  Oddly enough, it's
only /dev/console that stopped working (actually, it no longer appears
on my filesystem?!?) -- the getty running on /dev/ttyS0 works just
fine.

Regardless, the DMA patch should definately go in.  I'm still looking
into the other problems... we'll see what I come up with.

Matt


--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Brian Murphy
> Sent: Wednesday, September 18, 2002 9:57 AM
> To: Linux-MIPS
> Cc: Matthew Dharm
> Subject: Re: fs problem between 2.4.19-rc1 and tip?
>
>
> Matthew Dharm wrote:
>
> >Is anyone else seeing a problem using SCSI disks (ext2 format) that
> >was introduced between 2.4.19-rc1 and the tip revision?
> >
> >Upon booting the 2.4.20-pre6 (tip of CVS), the root
> filesystem throws
> >an error about an "unaligned directory entry" and then cannot find
> >init.
> >
> >
> This sounds like a problem I had with cache flushing in
> pci.h which got
> triggered
> by a change in the ide dma driver. Is it a pci driver? If
> so you could
> try the fix
> I submitted a few days ago with ide-dma in the subject line.
>
> /Brian
>
>
