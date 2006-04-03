Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Apr 2006 05:00:42 +0100 (BST)
Received: from njbrsmtp1.vzwmail.net ([66.174.76.155]:15559 "EHLO
	njbrsmtp1.vzwmail.net") by ftp.linux-mips.org with ESMTP
	id S8126481AbWDCEA2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Apr 2006 05:00:28 +0100
Received: from squidward (smtp.vzwmail.net [66.174.76.25])
	(authenticated bits=0)
	by njbrsmtp1.vzwmail.net (8.12.9/8.12.9) with ESMTP id k334B8Lv010512;
	Mon, 3 Apr 2006 04:11:14 GMT
From:	"Chuck Meade" <chuckmeade@mindspring.com>
To:	<linux-mips@linux-mips.org>
Cc:	"Chuck Meade \(mindspring\)" <chuckmeade@mindspring.com>
Subject: corruption of load instruction offset
Date:	Mon, 3 Apr 2006 00:12:46 -0400
Message-ID: <IIEEICKJLNEPBBDJICNGEECHKIAA.chuckmeade@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
x-mimeole: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Return-Path: <chuckmeade@mindspring.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chuckmeade@mindspring.com
Precedence: bulk
X-list: linux-mips

Hello,

I am seeing a very interesting/worrisome bug on an RM7965 cpu, which has
an E9000 core.  I am running 2.6.14-rc1.  Please take a look at the
behavior I describe and send me your thoughts.  Thanks.

The error message is immediately below.  Notice that the epc is 8021e28c,
and the BadVA is 87e39681, and register 4 (a0) is 87e38660.

Now scan down below the error message, to the disassembly of move_32bytes.
If you look at the instruction at 8021e28c, it appears harmless enough.  
Nothing to cause an unaligned access or invalid instruction.  But look
about 6 lines above that, and we are loading at offsets from a0.  The
offsets from a0 in those 4 load instructions are 16, 20, 24, and 28.  If
you look at the opcodes in the column to the left, those offsets appear in
the least significant 16 bits of the opcode.

Now look again at the value of a0 in the register dump:  87e38660.  And
at the BadVA value:  87e39681.  The BadVA is offset exactly 0x1021 from
a0.  This indicates that we somehow tried to access memory at offset 
0x1021 from a0.  However, we never should have done that according to
the disassembly.  *But* there are many instructions in the vicinity which
have a least significant 16 bits of 0x1021.  None of them are loads from a0,
but I believe that this is the root of the problem.  Something is happening
here, possibly an interrupt, or a cpu bug(?) that is causing the load from
a0 to use an offset of 0x1021 (the least significant 16-bits of many of
the nearby instructions) rather than the correct offset for the load
instruction, which is found in the least significant 16-bits of the actual
load instructions.

This is not "quickly" reproducible.  I run a TCP blaster/blastee test between
this machine and Linux PC, and at some point during the run (sometimes much
later) this error appears.

Thanks for your ideas,
Chuck

Error message:

Unhandled kernel unaligned access or invalid instruction in arch/mips/kernel/unaligned.c::emulate_load_store_insn, line 487[#1]:
Cpu 0
$ 0   : 00000000 10004ce8 00000000 00000000
$ 4   : 87e38660 000005a8 00000000 00000000
$ 8   : 00000000 00000000 00000020 00000000
$12   : 00000000 80402000 00000001 00000000
$16   : 00000000 87e171a0 000005a8 87c1f060
$20   : 87e380e0 004009e0 10004740 00002ad8
$24   : 00000008 803171c0
$28   : 8120a000 8120bd48 00000000 802deb30
Hi    : 0000000c
Lo    : 000d4bf8
epc   : 8021e28c move_32bytes+0x64/0x88     Not tainted
ra    : 802deb30 tcp_sendmsg+0x460/0xd80
Status: 90018403    KERNEL EXL IE
Cause : 00000010
BadVA : 87e39681
PrId  : 00003422
Modules linked in:
Process blaster (pid: 162, threadinfo=8120a000, task=8050b3f8)
Stack : 8120bdd0 00000000 812fd4a0 8120bdf0 8120bd70 87e18520 00000001 00000000
        8120be40 7fffffff 00000000 8120bf18 8120be14 00000000 000005a8 000005a8
        000032e8 00000001 00000000 90018400 8120be40 00005dc0 10001458 8120bf18
        00000005 004009e0 10011044 10010000 10010fd4 8028e7a8 00000020 ffffffff
        00000001 00000000 00005dc0 10001458 87e18520 00005dc0 812fd4a0 004009e0
        ...
Call Trace:
 [<8028e7a8>] sock_aio_write+0x10c/0x12c
 [<8016bef8>] do_sync_write+0xd0/0x128
 [<801037d4>] do_IRQ+0x24/0x34
 [<804203cc>] init+0xd8/0xe4
 [<8013cf78>] autoremove_wake_function+0x0/0x44
 [<8016c020>] vfs_write+0xd0/0x144
 [<8016c020>] vfs_write+0xd0/0x144
 [<8016c074>] vfs_write+0x124/0x144
 [<8016c150>] sys_write+0x24/0x98
 [<8016c180>] sys_write+0x54/0x98
 [<8016c154>] sys_write+0x28/0x98
 [<801037d4>] do_IRQ+0x24/0x34
 [<8010b260>] stack_done+0x20/0x3c



Disassembly of relevant portion of move_32bytes:

8021e228 <move_32bytes>:
8021e228:       8c880000        lw      t0,0(a0)
8021e22c:       8c890004        lw      t1,4(a0)
8021e230:       8c8b0008        lw      t3,8(a0)
8021e234:       8c8c000c        lw      t4,12(a0)
8021e238:       00481021        addu    v0,v0,t0
8021e23c:       0048182b        sltu    v1,v0,t0
8021e240:       00431021        addu    v0,v0,v1
8021e244:       00491021        addu    v0,v0,t1
8021e248:       0049182b        sltu    v1,v0,t1
8021e24c:       00431021        addu    v0,v0,v1
8021e250:       004b1021        addu    v0,v0,t3
8021e254:       004b182b        sltu    v1,v0,t3
8021e258:       00431021        addu    v0,v0,v1
8021e25c:       004c1021        addu    v0,v0,t4
8021e260:       004c182b        sltu    v1,v0,t4
8021e264:       00431021        addu    v0,v0,v1
8021e268:       8c880010        lw      t0,16(a0)
8021e26c:       8c890014        lw      t1,20(a0)
8021e270:       8c8b0018        lw      t3,24(a0)
8021e274:       8c8c001c        lw      t4,28(a0)
8021e278:       00481021        addu    v0,v0,t0
8021e27c:       0048182b        sltu    v1,v0,t0
8021e280:       00431021        addu    v0,v0,v1
8021e284:       00491021        addu    v0,v0,t1
8021e288:       0049182b        sltu    v1,v0,t1
8021e28c:       00431021        addu    v0,v0,v1
8021e290:       004b1021        addu    v0,v0,t3
8021e294:       004b182b        sltu    v1,v0,t3
8021e298:       00431021        addu    v0,v0,v1
8021e29c:       004c1021        addu    v0,v0,t4
8021e2a0:       004c182b        sltu    v1,v0,t4
8021e2a4:       00431021        addu    v0,v0,v1
8021e2a8:       30b8001c        andi    t8,a1,0x1c
8021e2ac:       24840020        addiu   a0,a0,32
