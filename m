Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 17:41:27 +0100 (BST)
Received: from smtp1.infineon.com ([IPv6:::ffff:194.175.117.76]:28299 "EHLO
	smtp1.infineon.com") by linux-mips.org with ESMTP
	id <S8225229AbTFBQlZ>; Mon, 2 Jun 2003 17:41:25 +0100
Received: from mucse011.eu.infineon.com (mucse011.ifx-mail1.com [172.29.27.228])
	by smtp1.infineon.com (8.12.9/8.12.9) with ESMTP id h52GexxZ013448
	for <linux-mips@linux-mips.org>; Mon, 2 Jun 2003 18:40:59 +0200 (MEST)
Received: by mucse011.eu.infineon.com with Internet Mail Service (5.5.2653.19)
	id <M1DMQS23>; Mon, 2 Jun 2003 18:41:18 +0200
Message-ID: <AD2F581BD7340A4C908AF1AFB066EA3B0E45F0@ntah901e.savan.com>
From: Amit.Lubovsky@infineon.com
To: linux-mips@linux-mips.org
Subject: gdb-5.3
Date: Mon, 2 Jun 2003 19:39:47 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="windows-1255"
Return-Path: <Amit.Lubovsky@infineon.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Amit.Lubovsky@infineon.com
Precedence: bulk
X-list: linux-mips

Hi,

I have compiled gdb-5.3 for a custom board running mips:

target gdbserver: 
	gdb-5.3/gdb/gdbserver/configure mips-eb-linux-gnu

host gdb: 
	gdb-5.3/gdb/configure --target mipseb-linux-elf


while running gdb on the host I got:
[test@dragun usr]$ ~test/gdb/bin/host/gdb demo
GNU gdb 5.3
Copyright 2002 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "--host=i686-pc-linux-gnu
--target=mipseb-linux-elf"...
(gdb) target remote 192.168.1.90:4444
Remote debugging using 192.168.1.90:4444
0x6000e182 in ?? ()
(gdb) b printf
Breakpoint 1 at 0x8048370
(gdb) n   
Cannot find bounds of current function
(gdb) p
The history is empty.
(gdb) cont
Continuing.

and on the target I got
/usr> ./gdbserver 192.168.1.1:4444 demo

Process demo created; pid = 27

Remote debugging from host 192.168.1.1

hello - #0

hello - #1

hello - #2

hello - #3

hello - #4

hello - #5 

the program demo.c
#include <stdio.h>

int main()
{
        int i=0;
        while(1){
                sleep(1);
                printf("hello - #%d\n", i);
                return 0;
        }
}

The problem is that I can't controll the gdbserver, it looks as if it
doesn't respond to commands (breakpoints,)
from the host gdb.

Thanks,
Amit.
