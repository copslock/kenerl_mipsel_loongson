Received:  by oss.sgi.com id <S553845AbRAVPBm>;
	Mon, 22 Jan 2001 07:01:42 -0800
Received: from mail.sonytel.be ([193.74.243.200]:38819 "EHLO mail.sonytel.be")
	by oss.sgi.com with ESMTP id <S553778AbRAVPBO>;
	Mon, 22 Jan 2001 07:01:14 -0800
Received: from escobaria.sonytel.be (escobaria.sonytel.be [10.34.80.3])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id QAA26454;
	Mon, 22 Jan 2001 16:00:24 +0100 (MET)
Date:   Mon, 22 Jan 2001 16:00:24 +0100 (MET)
From:   Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To:     Carsten Langgaard <carstenl@mips.com>
cc:     linux-mips@oss.sgi.com
Subject: Re: [Fwd: Can't activate swap partitions]
In-Reply-To: <3A6C47B1.731AE4FD@mips.com>
Message-ID: <Pine.GSO.4.10.10101221556400.7996-100000@escobaria.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, 22 Jan 2001, Carsten Langgaard wrote:
> No one seemed to answer, so I try again, because I think we have a
> general problem with the "bit"-functions in include/asm-mips64/bitops.h.
> I don't think we can make the address 64-bit aligned in these functions,
> without hurting a lot of drivers which use these functions to operate on
> 32-bit aligned data.
> One of the issues is that "integer" and "long integer" used to be 32-bit
> (in the 32-bit kernel), but now "long" is 64 bit. 

The consensus about bitops is to always use `unsigned long', although IMHO a
predefined type (bitops_t) would be better. On e.g. m68k a byte would be
sufficient, assumed you don't need more than 8 bits. Or bitsops_t8 for minimum
8 bits, bitsops_t16 for minimum 16 bits, etc....

> I can see on the ia64 part, they already has taken care of this by
> saying that bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
> This is the beauty about little endian, the lower 32 bit are located on
> the same address no matter if you access the data as a 32-bit or 64-bit
> access. This of course doesn't count for big endian, so the ia64
> approach can't be used on a big endian system.
> 
> Has anyone any ideas how to handle this without making a lot of changes
> in the general code and thereby hurting the other architectures.

Your problem is special because you have a machine that can run in either
32-bit or 64-bit mode.

> I'm having some problems with activating swap partitions when using a 64
> bit kernel on a 32 bit userland.
> I think I know what the problem is.
> The structure of the swap devices is that the first 4096 bytes contains
> a bitmap. Bits that have been set indicate that the page of memory for
> which the number in the swap space matches the offset of the bit at the
> start of the space is available for paging.
> The problem is then these bits are being checked, through the test_bit
> function call, where we read 64 bit at a time, and they where written 32
> bit at a time (from the 32 bit kernel).
> Note: we are talking about a bigendian system.

I suggest to put an explicit `mkswap' command in the startup scripts. It's not
needed to preserver the swap space contents between successive reboots (you
can't switch from 32-bit to 64-bit or vice versa without rebooting, right?).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe (SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium
