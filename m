Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 15:35:43 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52267 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491024Ab1EPNfj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 16 May 2011 15:35:39 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4GDbKx3021071;
        Mon, 16 May 2011 14:37:20 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4GDbJTB021070;
        Mon, 16 May 2011 14:37:19 +0100
Date:   Mon, 16 May 2011 14:37:19 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bharat Bhushan <bharat.76@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Stack frame for netlink_broadcast
Message-ID: <20110516133719.GA13589@linux-mips.org>
References: <BANLkTikzAjpOL1GwTw9JQFV3z9G3kRJ=1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTikzAjpOL1GwTw9JQFV3z9G3kRJ=1g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 16, 2011 at 02:34:46PM +0530, Bharat Bhushan wrote:

> I am using linux kernel version 2.6.16.51 MIPS port.
>
> I see the crash while using netlink_broadcast from kernel module.
> 
> CPU 0 Unable to handle kernel paging request at virtual address
> 00000000, epc == 8011c1c8, ra == 80120950
> Oops[#1]:
> Cpu 0
> $ 0   : 00000000 50104c00 00000000 804008c0
> $ 4   : 803841a0 00000000 00000001 00000000
> $ 8   : 40000000 00000000 00000000 00000000
> $12   : 00000000 00000001 8093bfff 00000002
> $16   : 81201480 8120193c 8a69e018 881e1b80
> $20   : 8ba5a520 00000001 80412d34 00000000
> $24   : 00000000 80343f04
> $28   : 80382000 80383d08 80383d10 80120950
> Hi    : 00000090
> Lo    : 0000007e
> epc   : 8011c1c8 dequeue_task+0xc/0x94     Tainted: PF
> ra    : 80120950 sys_sched_yield+0x7c/0xf8
> Status: 50104c02    KERNEL EXL
> Cause : 00808008
> BadVA : 00000000
> PrId  : 000c0904
> Modules linked in: cf ipi_hsl dataplane evb sjtag xlr_fmn hw_random
> ipt_connlimit xt_tcpudp xt_mark ipt_REDIRECT iptable_nat ip_nat
> ip_conntrack iptable_filter ip_tables x_tables hwreset panic_dump
> Process swapper (pid: 0, threadinfo=80382000, task=803841a0)
> Stack : 80383d10 802c0180 ffffffff 00000001 8a69e018 881e1b80 ffffffff 00000001
>         00000001 802d6390 8e143390 00000000 8e11f848 8e002d8c 00000000 00000001
>         00000001 00000000 881e1c08 80410000 8e9c7f30 881e1b80 8fc7de00 8fc7def8
>         00000002 8e409400 8e143390 00000000 00000000 8e0d7840 817a3e00 0001164d
>         00000000 00000000 000000d0 8e40c0e4 8e0d9ea0 8e0d9cb4 8e706738 00000002
> 
> 
> 
> Please note netlink_broadcast reserves Stack frame of 80bytes but
> tries to write to access 88(sp).
> 
> 802d60c8 <netlink_broadcast>:
> 802d60c8:   27bdffb0    addiu   sp,sp,-80
> 802d60cc:   afb40038    sw  s4,56(sp)
> 802d60d0:   afb30034    sw  s3,52(sp)
> 802d60d4:   afbf004c    sw  ra,76(sp)
> 802d60d8:   afbe0048    sw  s8,72(sp)
> 802d60dc:   afb70044    sw  s7,68(sp)
> 802d60e0:   afb60040    sw  s6,64(sp)
> 802d60e4:   afb5003c    sw  s5,60(sp)
> 802d60e8:   afb20030    sw  s2,48(sp)
> 802d60ec:   afb1002c    sw  s1,44(sp)
> 802d60f0:   afb00028    sw  s0,40(sp)
> 802d60f4:   afa40050    sw  a0,80(sp)  <-------Can this corrupt the
> previous stack frame?
> 802d60f8:   8ca20078    lw  v0,120(a1)
> 802d60fc:   00a09821    move    s3,a1
> 802d6100:   afa60058    sw  a2,88(sp) <------- Can this corrupt the
> previous stack frame?

No; this is entirely normal.  In the O32 ABI which is used to compile 32-bit
kernels the caller allocates the stackframe for the callee to save the
argument registers $a0 .. $a3 so you expect to see accesses to the 16 bytes
above the current stack frame just like here.

  Ralf

PS: 2.6.16.51 is now over 4 years old.  Please ship to the following address:

  British Museum
  Great Russell Street
  WC1B 3DG
  London
  Great Britain

;-)
