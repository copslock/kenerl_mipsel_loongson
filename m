Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2004 17:38:23 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:42907 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225597AbUBYRiV>;
	Wed, 25 Feb 2004 17:38:21 +0000
Received: from waterleaf.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id i1PHcHD2018351;
	Wed, 25 Feb 2004 18:38:17 +0100 (MET)
Date: Wed, 25 Feb 2004 18:38:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: "Liu Hongming (Alan)" <alanliu@trident.com.cn>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: IDE driver problem
In-Reply-To: <20040225171315.GB17217@linux-mips.org>
Message-ID: <Pine.GSO.4.58.0402251836510.2843@waterleaf.sonytel.be>
References: <15F9E1AE3207D6119CEA00D0B7DD5F680219C882@TMTMS>
 <20040225171315.GB17217@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, 25 Feb 2004, Ralf Baechle wrote:
> On Wed, Feb 25, 2004 at 08:11:54PM +0800, Liu Hongming (Alan) wrote:
> > I have found out where the problem is. Since my hardware has
> > endian issue, fs/partition/msdos.c could not handle partition table
> > correctly. I have changed a little(still having much to change),and it
> > really works now.
>
> I'm not sure what you call endian issue here.  The PC style partition
> table code we've used for years on big endian systems without problems.

I guess his hardware has a byteswapped IDE bus, like on Atari, Q40/Q60 and
Tivo.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
