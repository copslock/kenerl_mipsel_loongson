Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2003 17:50:06 +0000 (GMT)
Received: from [IPv6:::ffff:207.215.131.7] ([IPv6:::ffff:207.215.131.7]:18906
	"EHLO mail.pioneer-pdt.com") by linux-mips.org with ESMTP
	id <S8225412AbTKMRty> convert rfc822-to-8bit; Thu, 13 Nov 2003 17:49:54 +0000
Received: from 127.0.0.1 (localhost.pioneer-pdt.com [127.0.0.1])
	by dummy.domain.name (Postfix) with SMTP
	id 4B03C9D813; Thu, 13 Nov 2003 09:49:40 -0800 (PST)
Received: from LEDA (leda.V4000.pioneer-pdt.com [172.30.2.15])
	by mail.pioneer-pdt.com (Postfix) with SMTP
	id 733589D816; Thu, 13 Nov 2003 09:49:34 -0800 (PST)
From: "Jack Miller" <jack.miller@pioneer-pdt.com>
To: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>,
	"Linux-MIPS" <linux-mips@linux-mips.org>
Subject: RE: Patch for ALI15x3 - Linux-MIPS kernel 2.4.22-rc3
Date: Thu, 13 Nov 2003 09:49:34 -0800
Message-ID: <JCELLCFDJLFKPOBFKGFNKENHCHAA.jack.miller@pioneer-pdt.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <20031113085908.GV17497@lug-owl.de>
Content-Transfer-Encoding: 8BIT
Return-Path: <jack.miller@pioneer-pdt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jack.miller@pioneer-pdt.com
Precedence: bulk
X-list: linux-mips

  Sorry for the typo in the transcription, the source code is correct
regarding the test and assignment.

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org
> [mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Jan-Benedict Glaw
> Sent: Thursday, November 13, 2003 12:59 AM
> To: Linux-MIPS
> Subject: Re: Patch for ALI15x3 - Linux-MIPS kernel 2.4.22-rc3
>
>
> On Wed, 2003-11-12 17:13:53 -0800, Jack Miller
> <jack.miller@pioneer-pdt.com>
> wrote in message
> <JCELLCFDJLFKPOBFKGFNEENFCHAA.jack.miller@pioneer-pdt.com>:
> >   Alan,
> >     I am not so sure of that.  If you look at
> ide-disk.c:__ide_do_rw_disk(),
> > there is a local variable assignment statement:
> >
> >   u8 lba48 = (drive->addressing = 1) ? 1 : 0;
>                                  ^^^
>
> Explode. Now, lba48 would _always_ be 1.
>
> MfG, JBG
>
> --
>    Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
>    "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur |
> Gegen Krieg
>     fuer einen Freien Staat voll Freier Bürger" | im Internet! |
>  im Irak!
>    ret = do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW |
> DRM | TCPA));
>
