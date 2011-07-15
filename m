Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jul 2011 16:56:45 +0200 (CEST)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:64809 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491782Ab1GOO4m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Jul 2011 16:56:42 +0200
Received: by eyh6 with SMTP id 6so857447eyh.36
        for <linux-mips@linux-mips.org>; Fri, 15 Jul 2011 07:56:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.14.97.75 with SMTP id s51mr1309308eef.131.1310741796662; Fri,
 15 Jul 2011 07:56:36 -0700 (PDT)
Received: by 10.14.27.139 with HTTP; Fri, 15 Jul 2011 07:56:36 -0700 (PDT)
Date:   Fri, 15 Jul 2011 15:56:36 +0100
Message-ID: <CALGOZk2M8Hn_EA+Mqg3frZzLGZgr0bbj3VV8mUqUB1taCdwXJg@mail.gmail.com>
Subject: Confusion with vmlinux objcopy translation
From:   David Peverley <pev@sketchymonkey.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 30628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pev@sketchymonkey.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11015

Hi all,

First off Hello! My first post on the list so *wave*.

I've got something going on where I'm not sure if I'm missing a
subtlety (likely) or if something bizarre is going on. I'm building a
hacked variant of kernel 2.6.29.6 that's come from somone who's ported
it to the particular board I'm using. I've built a working kernel but
I'm not sure what's going on when I try to boot it as it seems like
the objcopy to make a binary image from vmlinux is a bit odd... To
walk through what I'm doing :

This kernel is compiled with a load address of 0x80500000. Looking at
vmlinux to find kernel_entry  :
  $ mipsel-percello-linux-gnu-nm ../../../vmlinux | grep kernel_entry
  80504590 T kernel_entry

Checking via GDB to see what the code looks like :
 (gdb) disassemble kernel_entry
  Dump of assembler code for function kernel_entry:
  0x80504590 <kernel_entry+0>:    add    %ah,0x8(%eax)
  0x80504593 <kernel_entry+3>:    inc    %eax
  0x80504594 <kernel_entry+4>:    add    %dl,(%eax)
  0x80504596 <kernel_entry+6>:    add    %edi,(%edi,%ebx,1)
  0x80504599 <kernel_entry+9>:    add    %ah,(%ecx)
  0x8050459b <kernel_entry+11>:   xor    $0x25,%al

So it's where we expected it to be from the output of nm...  :
  (gdb) x/90xw 0x80504590
  0x80504590 <kernel_entry>:	0x40086000	0x3c011000	0x3421001f	0x01014025
  0x805045a0 <kernel_entry+16>:	0x3908001f	0x40886000	0x000000c0	0x3c088050

I then convert this vmlinux file to a binary image :
  $ mipsel-percello-linux-gnu-objcopy -O binary ./vmlinux ./vmlinux.bin.test

and then hexdump to see what's at the kernel_entry offset :
  $ xxd -g xxd -g 4 -s 0x4550 -l 0x80 ./vmlinux.bin.test
  0004550: 00600840 0010013c 1f002134 25400101  .`.@...<..!4%@..
  0004560: 1f000839 00608840 c0000000 5080083c  ...9.`.@....P..<
  0004570: bc450825 08000001 00000000 9c80083c  .E.%...........<
  0004580: 00700825 000000ad a180093c dcb22925  .p.%.......<..)%
  0004590: 04000825 feff0915 000000ad 9c80013c  ...%...........<
  00045a0: 647624ac 9c80013c 687625ac 9c80013c  dv$....<hv%....<
  00045b0: 6c7626ac 9c80013c 707627ac 00208040  lv&....<pv'.. .@
  00045c0: 96801c3c 00609c27 e01f1d24 21e8bc03  ...<.`.'...$!...

The code for kernel_entry seems to be at an offset of 0x0004550. This
is -0x40 bytes below where I'd expected! Am I missing something? I can
confirm this by using my bootloader to load vmlinux.bin a
(load_address + 0x40) and it runs just fine.

The toolchain we have is :
  binutils 2.16.1
  gcc 4.2.0

Any insight would be appreciated!

Cheers!

~Pev
