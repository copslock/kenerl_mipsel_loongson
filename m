Received:  by oss.sgi.com id <S553853AbRAVPZm>;
	Mon, 22 Jan 2001 07:25:42 -0800
Received: from mx.mips.com ([206.31.31.226]:10647 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553848AbRAVPZR>;
	Mon, 22 Jan 2001 07:25:17 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA17328;
	Mon, 22 Jan 2001 07:24:36 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA07008;
	Mon, 22 Jan 2001 07:24:35 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id QAA27308;
	Mon, 22 Jan 2001 16:23:52 +0100 (MET)
Message-ID: <3A6C5087.70B33B2B@mips.com>
Date:   Mon, 22 Jan 2001 16:23:51 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: [Fwd: Can't activate swap partitions]
References: <Pine.GSO.4.10.10101221556400.7996-100000@escobaria.sonytel.be>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Geert Uytterhoeven wrote:

> On Mon, 22 Jan 2001, Carsten Langgaard wrote:
> > No one seemed to answer, so I try again, because I think we have a
> > general problem with the "bit"-functions in include/asm-mips64/bitops.h.
> > I don't think we can make the address 64-bit aligned in these functions,
> > without hurting a lot of drivers which use these functions to operate on
> > 32-bit aligned data.
> > One of the issues is that "integer" and "long integer" used to be 32-bit
> > (in the 32-bit kernel), but now "long" is 64 bit.
>
> The consensus about bitops is to always use `unsigned long', although IMHO a
> predefined type (bitops_t) would be better. On e.g. m68k a byte would be
> sufficient, assumed you don't need more than 8 bits. Or bitsops_t8 for minimum
> 8 bits, bitsops_t16 for minimum 16 bits, etc....
>
> > I can see on the ia64 part, they already has taken care of this by
> > saying that bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
> > This is the beauty about little endian, the lower 32 bit are located on
> > the same address no matter if you access the data as a 32-bit or 64-bit
> > access. This of course doesn't count for big endian, so the ia64
> > approach can't be used on a big endian system.
> >
> > Has anyone any ideas how to handle this without making a lot of changes
> > in the general code and thereby hurting the other architectures.
>
> Your problem is special because you have a machine that can run in either
> 32-bit or 64-bit mode.
>
> > I'm having some problems with activating swap partitions when using a 64
> > bit kernel on a 32 bit userland.
> > I think I know what the problem is.
> > The structure of the swap devices is that the first 4096 bytes contains
> > a bitmap. Bits that have been set indicate that the page of memory for
> > which the number in the swap space matches the offset of the bit at the
> > start of the space is available for paging.
> > The problem is then these bits are being checked, through the test_bit
> > function call, where we read 64 bit at a time, and they where written 32
> > bit at a time (from the 32 bit kernel).
> > Note: we are talking about a bigendian system.
>
> I suggest to put an explicit `mkswap' command in the startup scripts. It's not
> needed to preserver the swap space contents between successive reboots (you
> can't switch from 32-bit to 64-bit or vice versa without rebooting, right?).

That will probably solve my swap partition problem, but I think there are other
potential problems as mention above.
I don't think we can guarantee that data always are 32-bit aligned.

>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
> Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
> Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
