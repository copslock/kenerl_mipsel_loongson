Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 08:52:49 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:53938 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28574021AbYGPHwr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Jul 2008 08:52:47 +0100
Received: (qmail 4392 invoked by uid 1000); 16 Jul 2008 09:52:46 +0200
Date:	Wed, 16 Jul 2008 09:52:46 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: 2.6.26-gitX: insane number of section headers
Message-ID: <20080716075246.GA3184@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello,

Todays 2.6.26-git kernel produces an insane amout of section headers in the
vmlinux file, one for every function. Is that intentional, or a toolchain
problem on my side (binutils-2.18, gcc-4.2.4)?

ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           MIPS R3000
  Version:                           0x1
  Entry point address:               0x801045d0
  Start of program headers:          52 (bytes into file)
  Start of section headers:          29726396 (bytes into file)
  Flags:                             0x50001001, noreorder, o32, mips32
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         2
  Size of section headers:           40 (bytes)
  Number of section headers:         9282
  Section header string table index: 9279

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk
Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0
0  0
  [ 1] .text             PROGBITS        80100000 002000 009bd0 00  AX  0
0 32
  [ 2] .text.run_init_pr PROGBITS        80109bd0 00bbd0 000018 00  AX  0
0  4
  [ 3] .text.init_post   PROGBITS        80109be8 00bbe8 0000f0 00  AX  0
0  4
  [ 4] .text.name_to_dev PROGBITS        80109cd8 00bcd8 0002dc 00  AX  0
0  4
  [ 5] .text.prom_getcmd PROGBITS        80109fb4 00bfb4 00000c 00  AX  0
0  4
  [ 6] .text.prom_init_c PROGBITS        80109fc0 00bfc0 0000c4 00  AX  0
0  4
  [ 7] .text.prom_getenv PROGBITS        8010a084 00c084 000110 00  AX  0
0  4
  [ 8] .text.prom_get_et PROGBITS        8010a194 00c194 000160 00  AX  0
0  4
  [ 9] .text.local_enabl PROGBITS        8010a2f4 00c2f4 000048 00  AX  0
0  4
  [10] .text.local_disab PROGBITS        8010a33c 00c33c 000048 00  AX  0
0  4
  [11] .text.plat_irq_di PROGBITS        8010a384 00c384 000220 00  AX  0
0  4
  [12] .text.restore_au1 PROGBITS        8010a5a4 00c5a4 00021c 00  AX  0
0  4
  [13] .text.mask_and_ac PROGBITS        8010a7c0 00c7c0 000048 00  AX  0
0  4
  [14] .text.mask_and_ac PROGBITS        8010a808 00c808 000048 00  AX  0
0  4
  [15] .text.mask_and_ac PROGBITS        8010a850 00c850 000050 00  AX  0
0  4
  [16] .text.save_au1xxx PROGBITS        8010a8a0 00c8a0 000154 00  AX  0


Thanks!
	Manuel Lauss
