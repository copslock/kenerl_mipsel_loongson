Received:  by oss.sgi.com id <S553790AbRAVOrW>;
	Mon, 22 Jan 2001 06:47:22 -0800
Received: from mx.mips.com ([206.31.31.226]:43414 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553769AbRAVOq6>;
	Mon, 22 Jan 2001 06:46:58 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA16981
	for <linux-mips@oss.sgi.com>; Mon, 22 Jan 2001 06:46:53 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA06130
	for <linux-mips@oss.sgi.com>; Mon, 22 Jan 2001 06:46:52 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id PAA24636
	for <linux-mips@oss.sgi.com>; Mon, 22 Jan 2001 15:46:09 +0100 (MET)
Message-ID: <3A6C47B1.731AE4FD@mips.com>
Date:   Mon, 22 Jan 2001 15:46:09 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: [Fwd: Can't activate swap partitions]
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

No one seemed to answer, so I try again, because I think we have a
general problem with the "bit"-functions in include/asm-mips64/bitops.h.
I don't think we can make the address 64-bit aligned in these functions,
without hurting a lot of drivers which use these functions to operate on
32-bit aligned data.
One of the issues is that "integer" and "long integer" used to be 32-bit
(in the 32-bit kernel), but now "long" is 64 bit. 
I can see on the ia64 part, they already has taken care of this by
saying that bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
This is the beauty about little endian, the lower 32 bit are located on
the same address no matter if you access the data as a 32-bit or 64-bit
access. This of course doesn't count for big endian, so the ia64
approach can't be used on a big endian system.

Has anyone any ideas how to handle this without making a lot of changes
in the general code and thereby hurting the other architectures.

/Carsten



-------- Original Message --------
Subject: Can't activate swap partitions
Date: Thu, 18 Jan 2001 16:30:15 +0100
From: Carsten Langgaard <carstenl@mips.com>
To: linux-mips@oss.sgi.com

I'm having some problems with activating swap partitions when using a 64
bit kernel on a 32 bit userland.
I think I know what the problem is.
The structure of the swap devices is that the first 4096 bytes contains
a bitmap. Bits that have been set indicate that the page of memory for
which the number in the swap space matches the offset of the bit at the
start of the space is available for paging.
The problem is then these bits are being checked, through the test_bit
function call, where we read 64 bit at a time, and they where written 32
bit at a time (from the 32 bit kernel).
Note: we are talking about a bigendian system.

A little example to illustrate that I mean:

Set bit 0-53 to 1 and clear bit 54-63 (stored with 32 bit access)
ADDR = 0xffffffff;
ADDR+4 = 0x003fffff;

If I read it as two 32 bit words I get the same result (bit 0-53 is
set), but if I read it as one 64 bit double-word I get.

ADDR = 0xffffffff0003ffff;

Now bit 0-17 and bit 32-63 is set.

The bottom line is that I don't think we can make the address 64 bit
aligned in the "set/clear-and-test" functions in
include/asm-mips64/bitops.h, without hurting a lot of drivers which use
these functions to operate on hw-defined data-structures.

/Carsten



--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
