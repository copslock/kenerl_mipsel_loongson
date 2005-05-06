Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 17:48:10 +0100 (BST)
Received: from witte.sonytel.be ([IPv6:::ffff:80.88.33.193]:31118 "EHLO
	witte.sonytel.be") by linux-mips.org with ESMTP id <S8226017AbVEFQry>;
	Fri, 6 May 2005 17:47:54 +0100
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j46GliUu013723;
	Fri, 6 May 2005 18:47:45 +0200 (MEST)
Date:	Fri, 6 May 2005 18:47:41 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
cc:	"'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: RE: ATA devices attached to arbitary busses
In-Reply-To: <20050506152006Z8225995-1340+6646@linux-mips.org>
Message-ID: <Pine.LNX.4.62.0505061846170.5272@numbat.sonytel.be>
References: <20050506152006Z8225995-1340+6646@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 6 May 2005, Bryan Althouse wrote:
> All IDE drives should have the identical memory map.  But, the kernel does
> not communicate directly with the drive, it communicates though an IDE host
> adaptor (which may have different implementations).  If the host adaptor's
> memory map "matches" that of the IDE drive spec, then you consider it to be
> a "standard port layout"?  Since my host adaptor will be implemented in an
> FPGA, if I give it the IDE memory map defined in ide.h, then your example
> code will be applicable.
> 
> The memory map defined in ide.h makes sense to me (it seems to match the IDE
> drive memory map) until we get down to offset 6 (IDE_SELECT_OFFSET).  From
> here down, I have trouble matching the #define names with the register
> names/descriptions from the IDE spec.  Also, I am puzzled as to why there
> are 10 registers defined in ide.h when my IDE spec only shows 9.  The IDE
> spec that I am referencing looks like this:
> 
> CS0   CS1    DA2   DA1   DA0   READ              WRITE
> A     N      0     0     0     Data              Data
> A     N      0     0     1     Error             Features
> A     N      0     1     0     Sector Count      Sector Count
> A     N      0     1     1     Sector Number     Sector Number
> A     N      1     0     0     Cylinder Low      Cylinder Low
> A     N      1     0     1     Cylinder High     Cylinder High
> A     N      1     1     0     Device/Head       Device/Head
> A     N      1     1     1     Status            Command
> N     A      1     1     0     Alternate Status  Device Control (IRQ en/dis)
> 
> 
> ide.h shows the following offsets:
> 
> #define IDE_DATA_OFFSET		(0)
> #define IDE_ERROR_OFFSET	(1)
> #define IDE_NSECTOR_OFFSET	(2)
> #define IDE_SECTOR_OFFSET	(3)
> #define IDE_LCYL_OFFSET		(4)
> #define IDE_HCYL_OFFSET		(5)
> #define IDE_SELECT_OFFSET	(6)
> #define IDE_STATUS_OFFSET	(7)
> #define IDE_CONTROL_OFFSET	(8)
> #define IDE_IRQ_OFFSET		(9)
> 
> Do you know of an IDE host adapter chipset which is standard?  If someone
> knows of a part number, I could look up its datasheet.  This would probably
> clear up my confusion.  Thanks again!  

This is not the direct `memory map' of the IDE drive's registers! It's an
indirect map, cfr. e.g.

    #define IDE_DATA_REG            (HWIF(drive)->io_ports[IDE_DATA_OFFSET])

So the actual register is found by looking up offset IDE_DATA_OFFSET in the
array HWIF(drive)->io_ports[].

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
