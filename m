Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 18:12:52 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:49556 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8226019AbVEFRMh>;
	Fri, 6 May 2005 18:12:37 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j46HCXUu014693;
	Fri, 6 May 2005 19:12:34 +0200 (MEST)
Date:	Fri, 6 May 2005 19:12:30 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
cc:	"'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: RE: ATA devices attached to arbitary busses
In-Reply-To: <200505061709.j46H9L3a021796@nerdnet.nl>
Message-ID: <Pine.LNX.4.62.0505061911220.5272@numbat.sonytel.be>
References: <200505061709.j46H9L3a021796@nerdnet.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7891
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 6 May 2005, Bryan Althouse wrote:
> > This is not the direct `memory map' of the IDE drive's registers! It's an
> > indirect map, cfr. e.g.
> >
> >   #define IDE_DATA_REG            (HWIF(drive)->io_ports[IDE_DATA_OFFSET])
> >
> > So the actual register is found by looking up offset IDE_DATA_OFFSET in
> > the array HWIF(drive)->io_ports[].
> 
> Yes, I understand.  This is starting to make more sense.  Here is what I
> have figured out:  The first 8 offsets are normally 0-7, just like their
> array indexes.  Index 8 and 9, IDE_CONTROLL_OFFSET and IDE_IRQ_OFFSET, were
> confusing me because I was expecting them to be the actual offset 8 and 9 --
> and I could not find any IDE adapter data sheets that showed them located as
> such.  Now that I take a second look at ide_std_init_ports(), I see that the
> CONTROL register is treated as a special case, i.e. it is not expected to
> follow the STATUS register in address space.  This jives with what I have
> seen in data sheets.  
> 
> It looks like the example that Alan contributed does not update
> HWIF(drive)->io_ports[IDE_IRQ_OFFSET].  Or at least I cant figure out where.

Indeed, macide passes 0 for ctrlport and irqport to ide_setup_ports(). If you
need another example, you can look at drivers/ide/legacy/gayle.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
