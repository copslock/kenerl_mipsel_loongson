Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4LAqjG05568
	for linux-mips-outgoing; Mon, 21 May 2001 03:52:45 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4LAqiF05565
	for <linux-mips@oss.sgi.com>; Mon, 21 May 2001 03:52:44 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA13389
	for <linux-mips@oss.sgi.com>; Mon, 21 May 2001 03:52:38 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id DAA28882
	for <linux-mips@oss.sgi.com>; Mon, 21 May 2001 03:52:36 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id MAA18278
	for <linux-mips@oss.sgi.com>; Mon, 21 May 2001 12:51:49 +0200 (MEST)
Message-ID: <3B08F344.333B746C@mips.com>
Date: Mon, 21 May 2001 12:51:48 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Memory segments
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

In the macros PHYSADDR, KSEG0ADDR, KSEG1ADDR, KSEG2ADDR and KSEG3ADDR in
include/asm-mips64/addrspace.h the addresses are and'ed with
0x000000ffffffffffUL, instead of and'ed with 0x000000001fffffffUL why is
that ?
I do understand the address space is extended in 64 bit mode, but the
macros is used to manipulate KSEG0 and KSEG1 addresses, which is located
between 0xffffffff80000000-0xffffffffbfffffff. So the macros are broken
if you change an address from KSEG1 to KSEG0.

/Carsten


--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
