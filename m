Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 13:46:53 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:59682 "EHLO
	roarinelk.homelinux.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025439AbZD1Mqq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2009 13:46:46 +0100
Received: (qmail 14397 invoked by uid 1000); 28 Apr 2009 14:46:45 +0200
Date:	Tue, 28 Apr 2009 14:46:45 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Subject: oops in futex_init()
Message-ID: <20090428124645.GA14347@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello!

From time to time, my test systems don't boot correctly and spew the
following oops in futex_init():

calling  init_timer_list_procfs+0x0/0x40 @ 1
initcall init_timer_list_procfs+0x0/0x40 returned 0 after 29 usecs
calling  futex_init+0x0/0xac @ 1
Reserved instruction in kernel code[#1]:
Cpu 0
$ 0   : 00000000 10003c00 00000000 00000001
$ 4   : fffffff2 00000000 32e02014 00000000
$ 8   : 00000000 00000000 c4653600 000000cd
$12   : 3b9aca00 000186a0 870ce3f0 0000000d
$16   : 32e02014 00000000 00000000 8042f0dc
$20   : 00000000 00000000 00000000 00000000
$24   : 00000005 80243a3c
$28   : 87020000 87021f30 00000000 80100460
Hi    : 00000000
Lo    : 00000000
epc   : 8042f0f8 futex_init+0x1c/0xac
    Not tainted
ra    : 80100460 _stext+0x60/0x1c8
Status: 10003c03    KERNEL EXL IE
Cause : 00808028
PrId  : 04030202 (Au1250)
Modules linked in:
Process swapper (pid: 1, threadinfo=87020000, task=87018000, tls=00000000)
Stack : 00000000 8042f0dc 00000001 00002543 0000001d 00000000 87021f00 8014f014
        0000000e 00000000 8702a900 87002000 00003137 00000000 00000000 801ba18c
        8041e7a0 000000e0 80410000 00000000 00000000 8014f09c 32e02014 00000000
        80448360 804484f4 00000000 00000000 00000000 80428304 00000000 00000000
        00000000 00000000 87020000 00000000 00000000 80106ea4 10003c03 00000000
        ...
Call Trace:
[<8042f0f8>] futex_init+0x1c/0xac
[<80100460>] _stext+0x60/0x1c8
[<80428304>] kernel_init+0x98/0x104
[<80106ea4>] kernel_thread_helper+0x10/0x18


Code: 30420004  14400008  2404fff2 <c0440000> 14800005  00000000  00000821  e0410000  1020fffa
Disabling lock debugging due to kernel taint
note: swapper[1] exited with preempt_count 1
Kernel panic - not syncing: Attempted to kill init!


Disassembly of futex_init():

(gdb) disass 0x8042f0f8
Dump of assembler code for function futex_init:
0x8042f0dc <futex_init+0>:      lw      v1,20(gp)
0x8042f0e0 <futex_init+4>:      addiu   v1,v1,1
0x8042f0e4 <futex_init+8>:      sw      v1,20(gp)
0x8042f0e8 <futex_init+12>:     lw      v0,24(gp)
0x8042f0ec <futex_init+16>:     andi    v0,v0,0x4
0x8042f0f0 <futex_init+20>:     bnez    v0,0x8042f114 <futex_init+56>
0x8042f0f4 <futex_init+24>:     li      a0,-14
0x8042f0f8 <futex_init+28>:     ll      a0,0(v0)
0x8042f0fc <futex_init+32>:     bnez    a0,0x8042f114 <futex_init+56>
0x8042f100 <futex_init+36>:     nop
0x8042f104 <futex_init+40>:     move    at,zero
0x8042f108 <futex_init+44>:     sc      at,0(v0)
0x8042f10c <futex_init+48>:     beqz    at,0x8042f0f8 <futex_init+28>
0x8042f110 <futex_init+52>:     nop
0x8042f114 <futex_init+56>:     lw      v1,20(gp)
0x8042f118 <futex_init+60>:     addiu   v1,v1,-1
0x8042f11c <futex_init+64>:     sw      v1,20(gp)
0x8042f120 <futex_init+68>:     li      v0,-14
0x8042f124 <futex_init+72>:     beq     a0,v0,0x8042f144 <futex_init+104>
0x8042f128 <futex_init+76>:     li      v1,1
0x8042f12c <futex_init+80>:     lui     v0,0x8049
0x8042f130 <futex_init+84>:     addiu   a0,v0,26536
0x8042f134 <futex_init+88>:     move    a1,zero
0x8042f138 <futex_init+92>:     move    a2,a0
0x8042f13c <futex_init+96>:     j       0x8042f150 <futex_init+116>
0x8042f140 <futex_init+100>:    li      a3,256
0x8042f144 <futex_init+104>:    lui     v0,0x8049
0x8042f148 <futex_init+108>:    j       0x8042f12c <futex_init+80>
0x8042f14c <futex_init+112>:    sw      v1,26528(v0)
0x8042f150 <futex_init+116>:    sll     v1,a1,0x4
0x8042f154 <futex_init+120>:    sll     v0,a1,0x4
0x8042f158 <futex_init+124>:    addiu   v1,v1,8
0x8042f15c <futex_init+128>:    addu    v0,a2,v0
0x8042f160 <futex_init+132>:    addu    v1,a2,v1
0x8042f164 <futex_init+136>:    addiu   a1,a1,1
0x8042f168 <futex_init+140>:    sw      v0,4(a0)
0x8042f16c <futex_init+144>:    sw      v1,12(a0)
0x8042f170 <futex_init+148>:    sw      v0,0(a0)
0x8042f174 <futex_init+152>:    sw      v1,8(a0)
0x8042f178 <futex_init+156>:    bne     a1,a3,0x8042f150 <futex_init+116>
0x8042f17c <futex_init+160>:    addiu   a0,a0,16
0x8042f180 <futex_init+164>:    jr      ra
0x8042f184 <futex_init+168>:    move    v0,zero
End of assembler dump.



Could this be a compiler/toolchain issue?
(gcc-4.3.3, binutils-2.19.1)

Thanks!
	Manuel Lauss
