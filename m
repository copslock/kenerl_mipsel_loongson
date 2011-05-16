Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2011 11:04:55 +0200 (CEST)
Received: from mail-qw0-f49.google.com ([209.85.216.49]:54920 "EHLO
        mail-qw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490982Ab1EPJEw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2011 11:04:52 +0200
Received: by qwi2 with SMTP id 2so2579908qwi.36
        for <linux-mips@linux-mips.org>; Mon, 16 May 2011 02:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=MTHcP4aEjoUvX0DMoPf5h7GklkxqZk69s52hYdxnuyc=;
        b=cFZ/Hm9+1gvnzilBpzd0ERWFsouC8nHDGJMNHwjgaCFG8OPU8O+jzhSL/rRbJSgrAS
         YVehJJ/c+tVtAgPDq8iCkXFQHYM4MG2099wIWgo6TKCzZSzuZpSP2ci1VNjwv0FkP2Th
         GifLRlZUUlJUwwr716VjBl+hT7vfCMdb7QV+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=V8RocWKCSKYG9/6gFLOar3EuIXVq087UEZtbAFkiD+mpACN4UCAEj9urYKOpZGEHvb
         m/UWay0XDlyckI+Rwkqt3ZFBTgnHzbG+IxcKTIZuifAgcFctGXku7XzQrQ402njCiGCW
         O+n91dLvNQ8NvrpvuiTUvs3EEhZS2262dhhdk=
MIME-Version: 1.0
Received: by 10.224.215.70 with SMTP id hd6mr3052998qab.266.1305536686055;
 Mon, 16 May 2011 02:04:46 -0700 (PDT)
Received: by 10.229.86.82 with HTTP; Mon, 16 May 2011 02:04:46 -0700 (PDT)
Date:   Mon, 16 May 2011 14:34:46 +0530
Message-ID: <BANLkTikzAjpOL1GwTw9JQFV3z9G3kRJ=1g@mail.gmail.com>
Subject: Stack frame for netlink_broadcast
From:   Bharat Bhushan <bharat.76@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <bharat.76@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bharat.76@gmail.com
Precedence: bulk
X-list: linux-mips

I am using linux kernel version 2.6.16.51 MIPS port.

I see the crash while using netlink_broadcast from kernel module.

CPU 0 Unable to handle kernel paging request at virtual address
00000000, epc == 8011c1c8, ra == 80120950
Oops[#1]:
Cpu 0
$ 0   : 00000000 50104c00 00000000 804008c0
$ 4   : 803841a0 00000000 00000001 00000000
$ 8   : 40000000 00000000 00000000 00000000
$12   : 00000000 00000001 8093bfff 00000002
$16   : 81201480 8120193c 8a69e018 881e1b80
$20   : 8ba5a520 00000001 80412d34 00000000
$24   : 00000000 80343f04
$28   : 80382000 80383d08 80383d10 80120950
Hi    : 00000090
Lo    : 0000007e
epc   : 8011c1c8 dequeue_task+0xc/0x94     Tainted: PF
ra    : 80120950 sys_sched_yield+0x7c/0xf8
Status: 50104c02    KERNEL EXL
Cause : 00808008
BadVA : 00000000
PrId  : 000c0904
Modules linked in: cf ipi_hsl dataplane evb sjtag xlr_fmn hw_random
ipt_connlimit xt_tcpudp xt_mark ipt_REDIRECT iptable_nat ip_nat
ip_conntrack iptable_filter ip_tables x_tables hwreset panic_dump
Process swapper (pid: 0, threadinfo=80382000, task=803841a0)
Stack : 80383d10 802c0180 ffffffff 00000001 8a69e018 881e1b80 ffffffff 00000001
        00000001 802d6390 8e143390 00000000 8e11f848 8e002d8c 00000000 00000001
        00000001 00000000 881e1c08 80410000 8e9c7f30 881e1b80 8fc7de00 8fc7def8
        00000002 8e409400 8e143390 00000000 00000000 8e0d7840 817a3e00 0001164d
        00000000 00000000 000000d0 8e40c0e4 8e0d9ea0 8e0d9cb4 8e706738 00000002



Please note netlink_broadcast reserves Stack frame of 80bytes but
tries to write to access 88(sp).

802d60c8 <netlink_broadcast>:
802d60c8:   27bdffb0    addiu   sp,sp,-80
802d60cc:   afb40038    sw  s4,56(sp)
802d60d0:   afb30034    sw  s3,52(sp)
802d60d4:   afbf004c    sw  ra,76(sp)
802d60d8:   afbe0048    sw  s8,72(sp)
802d60dc:   afb70044    sw  s7,68(sp)
802d60e0:   afb60040    sw  s6,64(sp)
802d60e4:   afb5003c    sw  s5,60(sp)
802d60e8:   afb20030    sw  s2,48(sp)
802d60ec:   afb1002c    sw  s1,44(sp)
802d60f0:   afb00028    sw  s0,40(sp)
802d60f4:   afa40050    sw  a0,80(sp)  <-------Can this corrupt the
previous stack frame?
802d60f8:   8ca20078    lw  v0,120(a1)
802d60fc:   00a09821    move    s3,a1
802d6100:   afa60058    sw  a2,88(sp) <------- Can this corrupt the
previous stack frame?


In dequeue_task, it crashes @
array->nr_active--, since array is NULL.


Regards,
Bharat
