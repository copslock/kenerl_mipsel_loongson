Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 15:22:17 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:38366 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133373AbWAJPV7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Jan 2006 15:21:59 +0000
Received: from localhost (p5252-ipad212funabasi.chiba.ocn.ne.jp [58.91.169.252])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id DFD18A348
	for <linux-mips@linux-mips.org>; Wed, 11 Jan 2006 00:25:01 +0900 (JST)
Date:	Wed, 11 Jan 2006 00:24:31 +0900 (JST)
Message-Id: <20060111.002431.93019846.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: QEMU and kernel 2.6.15
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Hi.  I'm a QEMU newbie.  Does anybody tried QEMU 0.8.0 with recent
linux-mips kernel ?

I got following output and the kernel hangs.

$ qemu-system-mips -kernel ../build-qemu/arch/mips/boot/vmlinux.bin -m 16 -nographic
(qemu) mips_r4k_init: start
mips_r4k_init: load BIOS '/usr/local/share/qemu/mips_bios.bin' size 131072
Linux version 2.6.15-gb3880251 (anemo@debian) (gcc version 3.4.5) #12 Tue Jan 10 23:50:55 JST 2006
CPU revision is: 00018000
Determined physical RAM map:
 memory: 01000000 @ 00000000 (usable)
On node 0 totalpages: 4096
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Built 1 zonelists
Kernel command line: console=ttyS0 debug ip=172.20.0.2:172.20.0.1::255.255.0.0
Primary instruction cache 2kB, physically tagged, 2-way, linesize 16 bytes.
Primary data cache 2kB, 2-way, linesize 16 bytes.
Synthesized TLB refill handler (19 instructions).
Synthesized TLB load handler fastpath (31 instructions).
Synthesized TLB store handler fastpath (31 instructions).
Synthesized TLB modify handler fastpath (30 instructions).
PID hash table entries: 128 (order: 7, 2048 bytes)
Using 100.000 MHz high precision timer.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 13916k/16384k available (1702k kernel code, 2468k reserved, 321k data, 112k init, 0k highmem)
Calibrating delay loop... 478.41 BogoMIPS (lpj=2392064)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.


I can get qemu prompt by typing C-a c and 'info register' shows
PC=0x80010d40 (qemu_handle_int+0xe0).

(qemu) info registers
pc=0x80010d40 HI=0x00000000 LO=0x00000000 ds 0000 801b6cd8 0
GPR00: r0 00000000 at 10008401 v0 8027fbe8 v1 00000000
GPR04: a0 80281f0c a1 80281e9c a2 8027fbe8 a3 80281f0c
GPR08: t0 10008400 t1 1000001f t2 00000000 t3 00000000
GPR12: t4 7fffffff t5 ffffffff t6 00100100 t7 7fffffff
GPR16: s0 00000002 s1 80281f08 s2 00000000 s3 00000000
GPR20: s4 00000000 s5 00000000 s6 00000000 s7 00000000
GPR24: t8 00000000 t9 00000001 k0 80281e80 k1 80281e80
GPR28: gp 80280000 sp 80281dd0 s8 80281e80 ra 801b74f8
CP0 Status  0x10008400 Cause   0x80000400 EPC    0x801b74f4
    Config0 0x80008081 Config1 0x1e190c8a LLAddr 0x00000001


Whant's going on ?  An interrupt is not cleared?

Any advise is welcome.  Thanks.
---
Atsushi Nemoto
