Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6B7eoRw016001
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 11 Jul 2002 00:40:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6B7eogf016000
	for linux-mips-outgoing; Thu, 11 Jul 2002 00:40:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6B7eXRw015988
	for <linux-mips@oss.sgi.com>; Thu, 11 Jul 2002 00:40:33 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6B7ioXb011031;
	Thu, 11 Jul 2002 00:44:50 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA02274;
	Thu, 11 Jul 2002 00:44:52 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g6B7iqb16776;
	Thu, 11 Jul 2002 09:44:53 +0200 (MEST)
Message-ID: <3D2D3774.2DECC6FE@mips.com>
Date: Thu, 11 Jul 2002 09:44:52 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Malta crashes on the latest 2.4 kernel
References: <3D2CBF73.50001@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Sounds like a problem I so a couple of months ago, I thought the fix was already in
the CVS.

Here is my previous mail:

There seems to be a hazard problem in the local_flush_tlb_range function
in tlb-r4k.c, which the patch below will fix.
It could hit anyone, but it probably only a problem on CPUs, which
doesn't allow matching entries in the TLB.

/Carsten

Index: arch/mips/mm/tlb-r4k.c
===================================================================
RCS file: /cvs/linux/arch/mips/mm/tlb-r4k.c,v
retrieving revision 1.6.2.3
diff -u -r1.6.2.3 tlb-r4k.c
--- arch/mips/mm/tlb-r4k.c      2002/01/18 03:16:24     1.6.2.3
+++ arch/mips/mm/tlb-r4k.c      2002/05/17 11:36:58
@@ -119,12 +119,11 @@
                                idx = get_index();
                                set_entrylo0(0);
                                set_entrylo1(0);
-                               set_entryhi(KSEG0);
                                if (idx < 0)
                                        continue;
-                               BARRIER;
                                /* Make sure all entries differ. */
                                set_entryhi(KSEG0+idx*0x2000);
+                               BARRIER;
                                tlb_write_indexed();
                                BARRIER;
                        }


Jun Sun wrote:

> See the crash scene.  Anybody knows the cause?  It is strange to see the
> reserved exception.
>
> Jun
>
> FDC 0 is a post-1991 82077
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
> pcnet32: PCnet/FAST III 79C973 at 0x1200, 00 d0 a0 00 01 e7 assigned IRQ 10.
> eth0: registered as PCnet/FAST III 79C973
> pcnet32: 1 cards_found.
> SCSI subsystem driver Revision: 1.00
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 4096 bind 4096)
> Sending BOOTP requests . OK
> IP-Config: Got BOOTP answer from 10.0.0.75, my address is 10.0.18.6
> IP-Config: Complete:
>        device=eth0, addr=10.0.18.6, mask=255.255.0.0, gw=255.255.255.255,
>       host=10.0.18.6, domain=, nis-domain=(none),
>       bootserver=10.0.0.75, rootserver=10.0.0.75, rootpath=/opt/mvl-installs/mvl2
> .1/hardhat/devkit/mips/fp_le/target
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 10.0.0.75
> Looking up port of RPC 100005/1 on 10.0.0.75
> VFS: Mounted root (nfs filesystem).
> Freeing prom memory: 956kb freed
> Freeing unused kernel memory: 84k freed
> Algorithmics/MIPS FPU Emulator v1.5
> INIT: version 2.78 booting
> $0 : 00000000 80000000 80002000 00000006 00000006 0040c000 0040c000 00000001
> $8 : 80000000 00000034 8004bde8 8004bbf0 8004bde8 00000080 8004baf8 00000001
> $16: 00800000 800071c0 1000fc01 8004c008 0000b000 8004c008 00800000 0040b000
> $24: 00000000 00000080                   8004a000 8004ba78 0000000b 8011db6c
> Hi : ffffe4f4
> Lo : 00000904
> epc  : 8010d528    Not tainted
> Status: 1020fc02
> Cause : 00800060
> Kernel panic: Caught reserved exception - should not happen.
>
> ==========================================================ffffffff8010d490:
>      92240080        lbu     $a0,128($s1)
> ffffffff8010d494:       3c088000        lui     $t0,0x8000
> ffffffff8010d498:       00a41025        or      $v0,$a1,$a0
> ffffffff8010d49c:       40825000        mtc0    $v0,$10
> ffffffff8010d4a0:       24a52000        addiu   $a1,$a1,8192
>          ...
> ffffffff8010d4bc:       42000008        tlbp
>          ...
> ffffffff8010d4d8:       40070000        mfc0    $a3,$0
> ffffffff8010d4dc:       00000000        nop
> ffffffff8010d4e0:       00e01021        move    $v0,$a3
> ffffffff8010d4e4:       40801000        mtc0    $zero,$2
> ffffffff8010d4e8:       00000000        nop
> ffffffff8010d4ec:       40801800        mtc0    $zero,$3
> ffffffff8010d4f0:       00000000        nop
> ffffffff8010d4f4:       40885000        mtc0    $t0,$10
> ffffffff8010d4f8:       04400013        bltz    $v0,ffffffff8010d548 <local_flus
> h_tlb_range+0x150>
> ffffffff8010d4fc:       00a6102b        sltu    $v0,$a1,$a2
>          ...
> ffffffff8010d518:       00071340        sll     $v0,$a3,0xd
> ffffffff8010d51c:       3c018000        lui     $at,0x8000
> ffffffff8010d520:       00221021        addu    $v0,$at,$v0
> ffffffff8010d524:       40825000        mtc0    $v0,$10
> ffffffff8010d528:       42000002        tlbwi
>          ...
> ffffffff8010d544:       00a6102b        sltu    $v0,$a1,$a2
> ffffffff8010d548:       1440ffd4        bnez    $v0,ffffffff8010d49c <local_flus
> h_tlb_range+0xa4>
> ffffffff8010d54c:       00a41025        or      $v0,$a1,$a0
> ffffffff8010d550:       40835000        mtc0    $v1,$10
> ffffffff8010d554:       08043569        j       ffffffff8010d5a4 <local_flush_tl
> b_range+0x1ac>
> ffffffff8010d558:       00000000        nop
> ffffffff8010d55c:       3c108025        lui     $s0,0x8025
> ffffffff8010d560:       8e105910        lw      $s0,22800($s0)
> ffffffff8010d564:       26100001        addiu   $s0,$s0,1
> ffffffff8010d568:       320200ff        andi    $v0,$s0,0xff
> ffffffff8010d56c:       14400005        bnez    $v0,ffffffff8010d584 <local_flus
> h_tlb_range+0x18c>
> ffffffff8010d570:       00000000        nop

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
