Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jan 2003 16:13:24 +0000 (GMT)
Received: from mail2.sonytel.be ([IPv6:::ffff:195.0.45.172]:8423 "EHLO
	mail.sonytel.be") by linux-mips.org with ESMTP id <S8226347AbTAMQNX>;
	Mon, 13 Jan 2003 16:13:23 +0000
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id RAA19806
	for <linux-mips@linux-mips.org>; Mon, 13 Jan 2003 17:13:17 +0100 (MET)
Date: Mon, 13 Jan 2003 17:13:17 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: unaligned load in branch delay slot
Message-ID: <Pine.GSO.4.21.0301131704080.21279-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <Geert.Uytterhoeven@sonycom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips


I'm seeing a crash in 2.4.20 in emulate_load_store_insn(), when accepting a TCP
connection (exact line number influenced by debug code):

Unhandled kernel unaligned access or invalid instruction in unaligned.c::emulate_load_store_insn, line 492:
$0 : 00000000 10008400 30000000 00000000 83c2a380 83d9f80e 838941c0 00000001
$8 : 00000016 c0a80002 c0a80001 00000016 83f326a4 83f326a8 83f326a0 00000000
$16: 83c2a43c 811af440 00000000 83c2a380 803da18c 00000000 00000000 00000000
$24: 00000000 2ac41330                   8039a000 8039baf8 a38415b4 8033eea4
Hi : 00000000
Lo : 00000140
epc  : 80346448    Not tainted
Status: 10008403
Cause : 00000010
Process swapper (pid: 0, stackpage=8039a000)
Stack:    00000000 00000000 00000000 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
 00000000 00000000 00000000 00000000 00000000 00000000 00000000 8039a000
 00000001 810d0060 802dd370 00000000 00000000 8039bb70 00000000 8041a690
 803d2000 810c5de0 8041a620 810d0060 802dd370 80213fa4 810c41a0 8039bbc8
 8020ad50 ...
Call Trace:   [<802dd370>] [<802dd370>] [<80213fa4>] [<8020ad50>] [<802ea344>]
 [<802ea2fc>] [<80307e08>] [<802378f8>] [<8020a0d4>] [<8020a0d4>] [<802061d8>]
 [<802061d8>] [<8020a0d4>] [<8033eea4>] [<80346fbc>] [<80347060>] [<8034716c>]
 [<803476f4>] [<80329a50>] [<80326648>] [<8032952c>] [<80329ddc>] [<80329d98>]
 [<80329ddc>] [<8031700c>] [<80329790>] [<8031700c>] [<80316bb4>] [<803172b8>]
 [<802df95c>] [<8021bf30>] [<80317500>] [<80316ecc>] [<8021b810>] [<80379278>]
 [<8020ad50>] [<8020aeb0>] [<8020ae84>] [<80379228>] [<80204250>] ...

Code: 8cc30064  3c023000  00621824 <14600012> 8cb50010  8c840238  8c820004  90830000  00621007 
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

803463f8 <tcp_v4_conn_request>:
803463f8:	27bdfe20 	addiu	sp,sp,-480
803463fc:	afb601d8 	sw	s6,472(sp)
80346400:	afb301cc 	sw	s3,460(sp)
80346404:	afb101c4 	sw	s1,452(sp)
80346408:	afbf01dc 	sw	ra,476(sp)
8034640c:	afb501d4 	sw	s5,468(sp)
80346410:	afb401d0 	sw	s4,464(sp)
80346414:	afb201c8 	sw	s2,456(sp)
80346418:	afb001c0 	sw	s0,448(sp)
8034641c:	00a08821 	move	s1,a1
80346420:	8ca50020 	lw	a1,32(a1)
80346424:	8e260028 	lw	a2,40(s1)
80346428:	8e320044 	lw	s2,68(s1)
8034642c:	8ca2000c 	lw	v0,12(a1)
80346430:	00809821 	move	s3,a0
80346434:	0000b021 	move	s6,zero
80346438:	afa201b8 	sw	v0,440(sp)
8034643c:	8cc30064 	lw	v1,100(a2)
80346440:	3c023000 	lui	v0,0x3000
80346444:	00621824 	and	v1,v1,v0
80346448:	14600012 	bnez	v1,80346494 <tcp_v4_conn_request+0x9c>
8034644c:	8cb50010 	lw	s5,16(a1)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
80346450:	8c840238 	lw	a0,568(a0)
80346454:	8c820004 	lw	v0,4(a0)
80346458:	90830000 	lbu	v1,0(a0)
8034645c:	00621007 	srav	v0,v0,v1

If I print the parameters at label `sigill' in emulate_load_store_insn(), I
get:

    pc 0x80346448 addr 0x83d9f81e ins 0x14600012

And emulate_load_store_insn() gets confused because 0x14600012 is not a
load/store. 0x14600012 is the branch instruction before the load, not the load
after the branch instruction! Note that bit 31 of cause (CAUSEF_BD) is not set.
Some more investigations showed that the branch is indeed not taken.

Apparently if an unaligned access happens right after a branch which is not
taking, epc points to the branch instruction, and CAUSEF_BD is not set
(technically speaking, this is not a branch delay, since the branch is not
taken :-). Is this expected behavior? The CPU is a VR4120A core.

As a workaround, I assume I can just test whether pc points to a branch
instruction, and increment pc if that's the case?

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
