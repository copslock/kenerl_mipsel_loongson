Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g79NjIRw027429
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 9 Aug 2002 16:45:18 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g79NjIgn027428
	for linux-mips-outgoing; Fri, 9 Aug 2002 16:45:18 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from deliverator.sgi.com (deliverator.SGI.COM [204.94.214.10] (may be forged))
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g79Nj7Rw027418
	for <linux-mips@oss.sgi.com>; Fri, 9 Aug 2002 16:45:07 -0700
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by deliverator.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03212
	for <linux-mips@oss.sgi.com>; Fri, 9 Aug 2002 16:47:18 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id QAA14579;
	Fri, 9 Aug 2002 16:31:27 -0700
Message-ID: <3D544E9B.6040205@mvista.com>
Date: Fri, 09 Aug 2002 16:22:03 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: a really really weird crash on swarm
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=1.3 required=5.0 tests=MAY_BE_FORGED version=2.20
X-Spam-Level: *
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Call me crazy - I have seen crash like this.  As you can see, the register is 
loaded with one value and on next instruction it shows another value.  What 
the hell is it possibly going on?

This is with today's OSS tree 2.4 branch.

Jun

Unable to handle kernel paging request at virtual address ffffcbf4, epc == 80120
9d4, ra == 8011bc30
Oops in fault.c::do_page_fault, line 206:
$0 : 00000000 10001f00 80120998 00000000 00000001 00000000 00000000 802c71e0
$8 : 10001f00 00001000 8029bca4 8028e060 00000000 00000000 00000012 00000000
$16: ffffcbf4 00000000 00000000 00000001 00000002 8028e880 802c71e0 8feabe48
$24: 00000000 2ad78fd0                   8027c000 8027ddd8 ffff6e08 8011bc30
Hi : fffd4abb
Lo : 0000e717
epc  : 801209d4    Not tainted
Status: 10001f02
Cause : 00800008
Process swapper (pid: 0, stackpage=8027c000)
Stack:    813da000 ffffffff 8fb40e60 0000008a 813da26c 813da160 00000000
  8fb40e60 802c75e0 00000000 00000000 8011bc30 00000000 00000024 813da160
  00000000 8011ba58 00000000 00012cf7 0000012b 00000000 8028ec90 00000000
  8028ec80 fffffffe 00000000 10001f00 8fe8f1a0 8ffb8cc0 8011b300 00000000
  00000000 8010c5d0 8010c7e0 00000000 00000000 8ff9229c 43464531 8ff90bd8
  8010c7e0 ...
Call Trace:   [<8011bc30>] [<8011ba58>] [<8011b300>] [<8010c5d0>] [<8010c7e0>]
  [<8010c7e0>] [<80255870>] [<80255508>] [<80103240>] [<8010324c>] [<80100450>]
  [<80258b20>] [<80258b60>]

Code: 00000040  0010802a  2610cbf4 <c2030000> 1460fffe  3c038000  e2030000  1060
fffb  0000000f
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
  <0>Rebooting in 5 seconds..swarm_linux_exit called...passing control back to CF
E


ffffffff80120998 <timer_bh>:
ffffffff80120998:       27bdffd0        addiu   $sp,$sp,-48
ffffffff8012099c:       afbf002c        sw      $ra,44($sp)
ffffffff801209a0:       afb20028        sw      $s2,40($sp)
ffffffff801209a4:       afb10024        sw      $s1,36($sp)
ffffffff801209a8:       afb00020        sw      $s0,32($sp)
ffffffff801209ac:       40016000        mfc0    $at,$12
ffffffff801209b0:       00000000        nop
ffffffff801209b4:       34210001        ori     $at,$at,0x1
ffffffff801209b8:       38210001        xori    $at,$at,0x1
ffffffff801209bc:       40816000        mtc0    $at,$12
ffffffff801209c0:       00000040        ssnop
ffffffff801209c4:       00000040        ssnop
ffffffff801209c8:       00000040        ssnop
ffffffff801209cc:       3c10802a        lui     $s0,0x802a
ffffffff801209d0:       2610cbf4        addiu   $s0,$s0,-13324
ffffffff801209d4:       c2030000        ll      $v1,0($s0)
ffffffff801209d8:       1460fffe        bnez    $v1,ffffffff801209d4 <timer_bh+0
x3c>
ffffffff801209dc:       3c038000        lui     $v1,0x8000
ffffffff801209e0:       e2030000        sc      $v1,0($s0)
ffffffff801209e4:       1060fffb        beqz    $v1,ffffffff801209d4 <timer_bh+0
x3c>
ffffffff801209e8:       0000000f        sync
ffffffff801209ec:       3c02802c        lui     $v0,0x802c
ffffffff801209f0:       8c427984        lw      $v0,31108($v0)
ffffffff801209f4:       3c03802d        lui     $v1,0x802d
ffffffff801209f8:       8c6389c8        lw      $v1,-30264($v1)
ffffffff801209fc:       00438823        subu    $s1,$v0,$v1
ffffffff80120a00:       12200005        beqz    $s1,ffffffff80120a18 <timer_bh+0
x80>
ffffffff80120a04:       00711021        addu    $v0,$v1,$s1
ffffffff80120a08:       3c01802d        lui     $at,0x802d
ffffffff80120a0c:       ac2289c8        sw      $v0,-30264($at)
ffffffff80120a10:       0c048180        jal     ffffffff80120600 <update_wall_ti
me>
ffffffff80120a14:       02202021        move    $a0,$s1
ffffffff80120a18:       0000000f        sync
