Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2003 01:14:16 +0000 (GMT)
Received: from [IPv6:::ffff:207.215.131.7] ([IPv6:::ffff:207.215.131.7]:25801
	"EHLO mail.pioneer-pdt.com") by linux-mips.org with ESMTP
	id <S8225471AbTKMBOE>; Thu, 13 Nov 2003 01:14:04 +0000
Received: from 127.0.0.1 (localhost.pioneer-pdt.com [127.0.0.1])
	by dummy.domain.name (Postfix) with SMTP
	id 2DE189D81E; Wed, 12 Nov 2003 17:13:54 -0800 (PST)
Received: from LEDA (leda.V4000.pioneer-pdt.com [172.30.2.15])
	by mail.pioneer-pdt.com (Postfix) with SMTP
	id 261FB9D816; Wed, 12 Nov 2003 17:13:53 -0800 (PST)
From: "Jack Miller" <jack.miller@pioneer-pdt.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
	"Jack Miller" <jvmiller@earthlink.net>
Cc: "Ralf Baechle" <ralf@linux-mips.org>,
	"Linux-MIPS" <linux-mips@linux-mips.org>
Subject: RE: Patch for ALI15x3 - Linux-MIPS kernel 2.4.22-rc3
Date: Wed, 12 Nov 2003 17:13:53 -0800
Message-ID: <JCELLCFDJLFKPOBFKGFNEENFCHAA.jack.miller@pioneer-pdt.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <1068684992.13276.17.camel@dhcp23.swansea.linux.org.uk>
Return-Path: <jack.miller@pioneer-pdt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jack.miller@pioneer-pdt.com
Precedence: bulk
X-list: linux-mips

  Alan,
    I am not so sure of that.  If you look at ide-disk.c:__ide_do_rw_disk(),
there is a local variable assignment statement:

  u8 lba48 = (drive->addressing = 1) ? 1 : 0;

  So it would seem that the problem is elswhere ?

  -Jack


> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Alan Cox
> Sent: Wednesday, November 12, 2003 4:57 PM
> To: Jack Miller
> Cc: Ralf Baechle; Linux-MIPS
> Subject: Re: Patch for ALI15x3 - Linux-MIPS kernel 2.4.22-rc3
>
>
> On Mer, 2003-11-12 at 18:43, Jack Miller wrote:
> >   Ralf,
> >     Please apply this patch for the file drivers/ide/pci/alim15x3.c.  It
> > fixes the LBA addressing mode for chip revisions <= 0xC4.  Thank-You.
>
> It seems to break it not fix it.
>
> addressing = 1 means no LBA48
> addressing = 0 means LBA48
>
> Alan
>
>
>
