Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2005 10:39:17 +0000 (GMT)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:44988 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8225224AbVAKKjM>;
	Tue, 11 Jan 2005 10:39:12 +0000
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j0BAd0GU004703;
	Tue, 11 Jan 2005 11:39:00 +0100 (MET)
Date: Tue, 11 Jan 2005 11:38:59 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Hdei Nunoe <nunoe@co-nss.co.jp>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: HIGHMEM
In-Reply-To: <20050111103435.GA24198@linux-mips.org>
Message-ID: <Pine.GSO.4.61.0501111138050.14328@waterleaf.sonytel.be>
References: <001101c4dbf9$1da02270$3ca06096@NUNOE> <20041207095837.GA13264@linux-mips.org>
 <001701c4e195$24d48260$3ca06096@NUNOE> <20041215141508.GA29222@linux-mips.org>
 <002801c4f785$fcafd7b0$3ca06096@NUNOE> <20050111103435.GA24198@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, 11 Jan 2005, Ralf Baechle wrote:
> On Tue, Jan 11, 2005 at 11:33:51AM +0900, Hdei Nunoe wrote:
> > I have set up my system as following :
> > - 0x00000000 - 0x10000000 RAM
> > - 0x10000000 - 0x40000000 RESERVED
> > - 0x40000000 - 0x50000000 RAM
> 
> Your setup may work it's pretty wasteful; you're burning 12MB memory for
> unused kernel data structures.

Time to start using virtually contiguous memory, like m68k does? ;-)
(no, it's not in mainline)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
