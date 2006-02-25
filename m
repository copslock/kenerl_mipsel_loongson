Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Feb 2006 15:21:49 +0000 (GMT)
Received: from grayson.netsweng.com ([207.235.77.11]:5508 "EHLO
	grayson.netsweng.com") by ftp.linux-mips.org with ESMTP
	id S8133413AbWBYPVh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Feb 2006 15:21:37 +0000
Received: from amavis by grayson.netsweng.com with scanned-ok (Exim 3.36 #1 (Debian))
	id 1FD1Ly-00077o-00; Sat, 25 Feb 2006 10:29:02 -0500
Received: from grayson.netsweng.com ([127.0.0.1])
	by localhost (grayson [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27016-14; Sat, 25 Feb 2006 10:28:53 -0500 (EST)
Received: from h181.242.141.67.ip.alltel.net ([67.141.242.181] helo=trantor.stuart.netsweng.com)
	by grayson.netsweng.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FD1Lp-00077h-00; Sat, 25 Feb 2006 10:28:53 -0500
Date:	Sat, 25 Feb 2006 10:28:49 -0500 (EST)
From:	Stuart Anderson <anderson@netsweng.com>
X-X-Sender: anderson@trantor.stuart.netsweng.com
To:	Mark E Mason <mark.e.mason@broadcom.com>
cc:	linux-mips@linux-mips.org
Subject: RE: [RFC] SMP initialization order fixes.
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D077D619E@NT-SJCA-0750.brcm.ad.broadcom.com>
Message-ID: <Pine.LNX.4.64.0602251024210.28575@trantor.stuart.netsweng.com>
References: <7E000E7F06B05C49BDBB769ADAF44D077D619E@NT-SJCA-0750.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at netsweng.com
Return-Path: <anderson@netsweng.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anderson@netsweng.com
Precedence: bulk
X-list: linux-mips

On Fri, 24 Feb 2006, Mark E Mason wrote:

> In the meantime, adding the following line manually to net/core/dev.c
> (in netif_rx(), right after the enqueue label) appears to suppress the
> problem with no ill effects...  Note: this is *NOT* a fix, it's a hack.
> Please let me know if it works for you.

It certainly improved things. I let it run "make clean;make -j 4" in a
loop. It ran for at least 3 hours, maybe longer (I left it running over
night), but it did finally end in an Oops:

    .
    .
    .
   LD      .tmp_vmlinux2
   KSYM    .tmp_kallsyms2.S
   AS      .tmp_kallsyms2.o
   LD      vmlinux
eth0: Link speed: 100BaseT FDX
CPU 0 Unable to handle kernel paging request at virtual address
0000000000000088, epc == ffffffff80274ad0, ra == ffffffff80274a64
Oops[#1]:
Cpu 0
$ 0   : 0000000000000000 0000000014001fe0 00000000014e8ad8 0000000000000000
$ 4   : 000000017534a510 0000000000000000 ffffffff8036be20 0000001000000000
$ 8   : 0000000000000000 0000000000000002 ffffffffffffffc0 ffffffff803e33a8
$12   : 0000000000000024 ffffffff803e92d8 0000000000000024 9000000000000000
$16   : a80000000055c3a0 a80000000fcddd80 0000000000050000 ffffffff803e6d00
$20   : a80000000fcddc00 000000ffffffffff a80000000fcddc08 ffffffff803e8008
$24   : 0000000000000002 ffffffff80410000 
$28   : ffffffff80368000 ffffffff8036bd30 0000000014001fe1 ffffffff80274a64
Hi    : 0000000000000000
Lo    : 0000000000000000
epc   : ffffffff80274ad0 sbmac_intr+0x3b0/0x5e8     Not tainted
ra    : ffffffff80274a64 sbmac_intr+0x344/0x5e8
Status: 14001fe2    KX SX UX KERNEL EXL 
Cause : 00809008
BadVA : 0000000000000088
PrId  : 01041100
Process swapper (pid: 0, threadinfo=ffffffff80368000, task=ffffffff8036c000)
Stack : a80000000055c3a0 0000000000000000 0000000000000024 ffffffff8036be20
         0000000000000000 0000000000000001 ffffffff80400000 fffffffffffffffb
         ffffffff8ffff2b0 ffffffff801612e8 0000001000000000 ffffffff803b4ba0
         0000000000000024 a80000000055c3a0 ffffffff803b4bc8 ffffffff8036be20
         ffffffff80161494 ffffffff8016142c 0000001000000000 000000000000001b
         0000000000000000 0000000000000040 0000001000000001 0000000000005188
         ffffffff803e0000 0000000000000004 ffffffff8010465c ffffffff801084bc
         ffffffff8010248c ffffffff80102414 0000000000000000 0000000014001fe1
         0000000000000000 0000000000000004 a8000000cbea6060 ffffffff803e8008
         0000000014001fe0 ffffffff803f0000 0000000000000001 ffffffff803f0000
         ...
Call Trace:
  [<ffffffff801612e8>] handle_IRQ_event+0x80/0xf0
  [<ffffffff80161494>] __do_IRQ+0x13c/0x1f8
  [<ffffffff8016142c>] __do_IRQ+0xd4/0x1f8
  [<ffffffff8010465c>] do_IRQ+0x1c/0x38
  [<ffffffff801084bc>] ll_local_timer_interrupt+0x8c/0x98
  [<ffffffff8010248c>] bcm1480_irq_handler+0x18c/0x1a0
  [<ffffffff80102414>] bcm1480_irq_handler+0x114/0x1a0
  [<ffffffff80299850>] dev_queue_xmit+0x0/0x338
  [<ffffffff80104fa0>] cpu_idle+0x70/0x78
  [<ffffffff80104f60>] cpu_idle+0x30/0x78
  [<ffffffff803b7bf4>] start_kernel+0x39c/0x3e0


Code: de840058  de820048  64420001 <9ca30088> 0083202d  fe820048
fe840058  c0a300ac  2462ffff 
Kernel panic - not syncing: Aiee, killing interrupt handler!
  <0>Rebooting in 5 seconds..Passing control back to CFE...



The "Link speed" message right before it crashed makes me wonder if this may
be a different issue from the one the patch, er, hack, was working around.

Still, this is progress in the right direction.



                                 Stuart

Stuart R. Anderson                               anderson@netsweng.com
Network & Software Engineering                   http://www.netsweng.com/
1024D/37A79149:                                  0791 D3B8 9A4C 2CDC A31F
                                                  BD03 0A62 E534 37A7 9149
