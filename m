Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6ANVqRw023825
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Jul 2002 16:31:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6ANVqQH023824
	for linux-mips-outgoing; Wed, 10 Jul 2002 16:31:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6ANVeRw023814
	for <linux-mips@oss.sgi.com>; Wed, 10 Jul 2002 16:31:40 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA06224
	for <linux-mips@oss.sgi.com>; Wed, 10 Jul 2002 16:36:35 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA23383;
	Wed, 10 Jul 2002 16:20:13 -0700
Message-ID: <3D2CBF73.50001@mvista.com>
Date: Wed, 10 Jul 2002 16:12:51 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Malta crashes on the latest 2.4 kernel
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


See the crash scene.  Anybody knows the cause?  It is strange to see the 
reserved exception.

Jun


FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
pcnet32.c:v1.27a 10.02.2002 tsbogend@alpha.franken.de
pcnet32: PCnet/FAST III 79C973 at 0x1200, 00 d0 a0 00 01 e7 assigned IRQ 10.
eth0: registered as PCnet/FAST III 79C973
pcnet32: 1 cards_found.
SCSI subsystem driver Revision: 1.00
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 10.0.0.75, my address is 10.0.18.6
IP-Config: Complete:
       device=eth0, addr=10.0.18.6, mask=255.255.0.0, gw=255.255.255.255,
      host=10.0.18.6, domain=, nis-domain=(none),
      bootserver=10.0.0.75, rootserver=10.0.0.75, rootpath=/opt/mvl-installs/mvl2
.1/hardhat/devkit/mips/fp_le/target
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.0.0.75
Looking up port of RPC 100005/1 on 10.0.0.75
VFS: Mounted root (nfs filesystem).
Freeing prom memory: 956kb freed
Freeing unused kernel memory: 84k freed
Algorithmics/MIPS FPU Emulator v1.5
INIT: version 2.78 booting
$0 : 00000000 80000000 80002000 00000006 00000006 0040c000 0040c000 00000001
$8 : 80000000 00000034 8004bde8 8004bbf0 8004bde8 00000080 8004baf8 00000001
$16: 00800000 800071c0 1000fc01 8004c008 0000b000 8004c008 00800000 0040b000
$24: 00000000 00000080                   8004a000 8004ba78 0000000b 8011db6c
Hi : ffffe4f4
Lo : 00000904
epc  : 8010d528    Not tainted
Status: 1020fc02
Cause : 00800060
Kernel panic: Caught reserved exception - should not happen.


==========================================================ffffffff8010d490: 
     92240080        lbu     $a0,128($s1)
ffffffff8010d494:       3c088000        lui     $t0,0x8000
ffffffff8010d498:       00a41025        or      $v0,$a1,$a0
ffffffff8010d49c:       40825000        mtc0    $v0,$10
ffffffff8010d4a0:       24a52000        addiu   $a1,$a1,8192
         ...
ffffffff8010d4bc:       42000008        tlbp
         ...
ffffffff8010d4d8:       40070000        mfc0    $a3,$0
ffffffff8010d4dc:       00000000        nop
ffffffff8010d4e0:       00e01021        move    $v0,$a3
ffffffff8010d4e4:       40801000        mtc0    $zero,$2
ffffffff8010d4e8:       00000000        nop
ffffffff8010d4ec:       40801800        mtc0    $zero,$3
ffffffff8010d4f0:       00000000        nop
ffffffff8010d4f4:       40885000        mtc0    $t0,$10
ffffffff8010d4f8:       04400013        bltz    $v0,ffffffff8010d548 <local_flus
h_tlb_range+0x150>
ffffffff8010d4fc:       00a6102b        sltu    $v0,$a1,$a2
         ...
ffffffff8010d518:       00071340        sll     $v0,$a3,0xd
ffffffff8010d51c:       3c018000        lui     $at,0x8000
ffffffff8010d520:       00221021        addu    $v0,$at,$v0
ffffffff8010d524:       40825000        mtc0    $v0,$10
ffffffff8010d528:       42000002        tlbwi
         ...
ffffffff8010d544:       00a6102b        sltu    $v0,$a1,$a2
ffffffff8010d548:       1440ffd4        bnez    $v0,ffffffff8010d49c <local_flus
h_tlb_range+0xa4>
ffffffff8010d54c:       00a41025        or      $v0,$a1,$a0
ffffffff8010d550:       40835000        mtc0    $v1,$10
ffffffff8010d554:       08043569        j       ffffffff8010d5a4 <local_flush_tl
b_range+0x1ac>
ffffffff8010d558:       00000000        nop
ffffffff8010d55c:       3c108025        lui     $s0,0x8025
ffffffff8010d560:       8e105910        lw      $s0,22800($s0)
ffffffff8010d564:       26100001        addiu   $s0,$s0,1
ffffffff8010d568:       320200ff        andi    $v0,$s0,0xff
ffffffff8010d56c:       14400005        bnez    $v0,ffffffff8010d584 <local_flus
h_tlb_range+0x18c>
ffffffff8010d570:       00000000        nop
