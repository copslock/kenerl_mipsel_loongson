Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2MNi3e14366
	for linux-mips-outgoing; Thu, 22 Mar 2001 15:44:03 -0800
Received: from gatekeep.ti.com (gatekeep.ti.com [192.94.94.61])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2MNi1M14358
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 15:44:02 -0800
Received: from dlep8.itg.ti.com ([157.170.134.88])
	by gatekeep.ti.com (8.11.1/8.11.1) with ESMTP id f2MNhtr17992
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 17:43:56 -0600 (CST)
Received: from dlep8.itg.ti.com (localhost [127.0.0.1])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id RAA25822
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 17:43:55 -0600 (CST)
Received: from dlep3.itg.ti.com (dlep3-maint.itg.ti.com [157.170.133.16])
	by dlep8.itg.ti.com (8.9.3/8.9.3) with ESMTP id RAA25816
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 17:43:55 -0600 (CST)
Received: from ti.com (IDENT:bbrown@bbrowndt.sc.ti.com [158.218.100.126])
	by dlep3.itg.ti.com (8.9.3/8.9.3) with ESMTP id RAA12164
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 17:43:54 -0600 (CST)
Message-ID: <3ABA8F3D.E24DF122@ti.com>
Date: Thu, 22 Mar 2001 16:48:13 -0700
From: Brady Brown <bbrown@ti.com>
Organization: Texas Instruments
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: SGI news group <linux-mips@oss.sgi.com>
Subject: Tools miss-compile old kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I recently upgraded to a newer Cross-compiler tool chain to try to get up to
glibc2.2. I'm now at gcc-2.95.3-14 and binutils-2.10.91-2 (both from Maciej's
site). I have built 2.4.0-test9 with this tool-chain, but is will not boot. It
spews illegal instruction errors when init is launched.

Is this supposed to work, or are the new tools incompatible with older kernels?

I dumped out the disassembly of a newly compiled kernel and found some bad
instructions in many of the routines. First one is from head.S

SNIP>> of bad disassembly
0000000080100280 <except_vec0_r4000>:
except_vec0_r4000():
    80100280:     401a4000      mfc0         $k0,$8
    80100284:     001ad582      srl             $k0,$k0,0x16
    80100288:     3c1b0000      lui             $k1,0x0
    8010028c:     677b0001      0x677b0001
    80100290:     001bdc38      0x1bdc38
    80100294:     677b8023      0x677b8023
    80100298:     001bdc38      0x1bdc38
    8010029c:     8f7bb250      lw                 $k1,-19888($k1)
    801002a0:     001ad080      sll                $k0,$k0,0x2
    801002a4:     037ad821      addu            $k1,$k1,$k0
    801002a8:     401a2000      mfc0           $k0,$4
    801002ac:     8f7b0000      lw                 $k1,0($k1)
    801002b0:     001ad042      srl                $k0,$k0,0x1
    801002b4:     335a0ff8      andi              $k0,$k0,0xff8
    801002b8:     037ad821      addu            $k1,$k1,$k0
    801002bc:     8f7a0000      lw                  $k0,0($k1)
    801002c0:     8f7b0004      lw                  $k1,4($k1)
    801002c4:     001ad182      srl                 $k0,$k0,0x6
    801002c8:     409a1000      mtc0            $k0,$2
    801002cc:     001bd982      srl                 $k1,$k1,0x6
    801002d0:     409b1800      mtc0            $k1,$3
    801002d4:     10000001      b                    ffffffff801002dc
<except_vec0_r4000+0x5c>
    801002d8:     42000006      tlbwr
    801002dc:     00000000      nop
    801002e0:     42000018      c0 0x18
<<SNIP

>>SNIP of good assembly from old tools
0000000080100280 <except_vec0_r4000>:
except_vec0_r4000():
    80100280:     401a4000     mfc0         $k0,$8
    80100284:     001ad582     srl              $k0,$k0,0x16
    80100288:     3c1b8023     lui              $k1,0x8023
    8010028c:     8f7bd210      lw               $k1,-11760($k1)
    80100290:     001ad080     sll               $k0,$k0,0x2
    80100294:     037ad821     addu          $k1,$k1,$k0
    80100298:     401a2000     mfc0         $k0,$4
    8010029c:     8f7b0000      lw                $k1,0($k1)
    801002a0:     001ad042     srl             $k0,$k0,0x1
    801002a4:     335a0ff8      andi           $k0,$k0,0xff8
    801002a8:     037ad821     addu         $k1,$k1,$k0
    801002ac:     8f7a0000      lw             $k0,0($k1)
    801002b0:     8f7b0004      lw             $k1,4($k1)
    801002b4:     001ad182      srl             $k0,$k0,0x6
    801002b8:     409a1000      mtc0         $k0,$2
    801002bc:     001bd982      srl             $k1,$k1,0x6
    801002c0:     409b1800      mtc0         $k1,$3
    801002c4:     10000001      b 801002cc <except_vec0_r4000+4c>
    801002c8:     42000006      tlbwr
    801002cc:     00000000      nop
    801002d0:     42000018      eret
<<SNIP


Looks like here the tools blow the lui/lw combination and also the eret. Any
suggestions?
