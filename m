Received:  by oss.sgi.com id <S42346AbQFAHQ7>;
	Thu, 1 Jun 2000 00:16:59 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:37716 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42272AbQFAHQp>; Thu, 1 Jun 2000 00:16:45 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id BAA04002; Thu, 1 Jun 2000 01:21:32 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA13318
	for linux-list;
	Thu, 1 Jun 2000 01:06:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA72538;
	Thu, 1 Jun 2000 01:06:00 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1])
	by calypso.engr.sgi.com (Postfix) with ESMTP
	id 25756A7875; Thu,  1 Jun 2000 01:04:40 -0700 (PDT)
Date:   Thu, 1 Jun 2000 01:04:40 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
To:     jimix@watson.ibm.com
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: cross Mips64-linux binutils problem
In-Reply-To: <14638.33763.840817.330892@kitch0.watson.ibm.com>
Message-ID: <Pine.LNX.4.21.0006010053110.1711-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> I forward ported your patch to binutils-000524 since I could not get
> my hands on 000524. 

You can check out the CVS repository on sourceware.cygnus.com from 000424.  I
think I told you how to do it.  I haven't been working with my binutils
patches much this month, but I will probably verify them again soon.

> crt0s.s:7: Internal error, aborting at /../binutils-000524/gas/config/tc-mips.c line 4364 in macro

I've actually explicitly put an arort() there.  If you look at line line 4364
there's a comment that explains why the abort() is there.  It can be fixed,
but someone still has to do it.  For now, just use -G 0.

> However, my relocations seem messed up! objdump fails reading them,
> IRIX elfdump seems confused though readelf seems to handle it fine.

I don't know what you're doing wrong.  I could objdump it just fine.  I
haven't tested with IRIX.

$ ../binutils/objdump -dr jimi-testcase.o 

test.o:     file format elf64-littlemips

Disassembly of section .text:

0000000000000000 <_start>:
   0:   3c1d0000        lui     $sp,0x0
                        0: R_MIPS_HIGHEST       kernelInfoLocal
   4:   67bd0000        daddiu  $sp,$sp,0
                        4: R_MIPS_HIGHER        kernelInfoLocal
   8:   001dec38        dsll    $sp,$sp,0x10
   c:   67bd0000        daddiu  $sp,$sp,0
                        c: R_MIPS_HI16  kernelInfoLocal
  10:   001dec38        dsll    $sp,$sp,0x10
  14:   67bd0000        daddiu  $sp,$sp,0
                        14: R_MIPS_LO16 kernelInfoLocal
  18:   dfbd0000        ld      $sp,0($sp)
  1c:   67bd6000        daddiu  $sp,$sp,24576
  20:   3c190000        lui     $t9,0x0
                        20: R_MIPS_HIGHEST      crtInit
  24:   67390000        daddiu  $t9,$t9,0
                        24: R_MIPS_HIGHER       crtInit
  28:   0019cc38        dsll    $t9,$t9,0x10
  2c:   67390000        daddiu  $t9,$t9,0
                        2c: R_MIPS_HI16 crtInit
  30:   0019cc38        dsll    $t9,$t9,0x10
  34:   67390000        daddiu  $t9,$t9,0
                        34: R_MIPS_LO16 crtInit
  38:   03200008        jr      $t9
  3c:   00000000        nop
  40:   03e00008        jr      $ra
        ...

I can't see anything that's obviously wrong with the assembler output either
so it should be fine.

> An interesing item (but may be a red herring) is that IRIX as(1) places
> R_MIPS_LO16 relocations int the .rel.text section, and gas(1) places
> them (an all relocations) in .rela.text

We can use both RELA and REL relocations in the 64-bit ABI.  IRIX as tends to
switch from one to another.

Ulf
