Received:  by oss.sgi.com id <S554149AbRARPb2>;
	Thu, 18 Jan 2001 07:31:28 -0800
Received: from mx.mips.com ([206.31.31.226]:64481 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S554146AbRARPbD>;
	Thu, 18 Jan 2001 07:31:03 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA19785
	for <linux-mips@oss.sgi.com>; Thu, 18 Jan 2001 07:30:58 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA08088
	for <linux-mips@oss.sgi.com>; Thu, 18 Jan 2001 07:30:57 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id QAA06058
	for <linux-mips@oss.sgi.com>; Thu, 18 Jan 2001 16:30:16 +0100 (MET)
Message-ID: <3A670C07.31426EC6@mips.com>
Date:   Thu, 18 Jan 2001 16:30:15 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: Can't activate swap partitions
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

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
