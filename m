Received:  by oss.sgi.com id <S42277AbQEXTpS>;
	Wed, 24 May 2000 12:45:18 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:13845 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42238AbQEXTo5>;
	Wed, 24 May 2000 12:44:57 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA23448; Wed, 24 May 2000 13:40:05 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA26193
	for linux-list;
	Wed, 24 May 2000 13:34:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA63405
	for <linux@engr.sgi.com>;
	Wed, 24 May 2000 13:34:35 -0700 (PDT)
	mail_from (jimix@watson.ibm.com)
Received: from igw8.watson.ibm.com (igw8.watson.ibm.com [198.81.209.20]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA04458
	for <linux@engr.sgi.com>; Wed, 24 May 2000 13:34:34 -0700 (PDT)
	mail_from (jimix@watson.ibm.com)
Received: from sp1n189at0.watson.ibm.com (sp1n189at0.watson.ibm.com [9.2.104.62])
	by igw8.watson.ibm.com (8.9.3/8.9.3/05-14-1999) with ESMTP id QAA06298
	for <linux@engr.sgi.com>; Wed, 24 May 2000 16:34:37 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.229.13]) by sp1n189at0.watson.ibm.com (8.9.3/Feb-20-98) with ESMTP id QAA23924 for <linux@engr.sgi.com>; Wed, 24 May 2000 16:34:36 -0400
Received: (from jimix@localhost)
	by kitch0.watson.ibm.com (AIX4.3/8.9.3/8.9.3/01-10-2000) id QAA60628;
	Wed, 24 May 2000 16:34:36 -0400
From:   jimix@pobox.com (Jimi X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14636.15579.327225.215562@kitch0.watson.ibm.com>
Date:   Wed, 24 May 2000 16:34:35 -0400 (EDT)
To:     linux@cthulhu.engr.sgi.com
Subject: cross Mips64-linux binutils problem
X-Mailer: VM 6.75 under 20.4 "Emerald" XEmacs  Lucid
Reply-To: jimix@watson.ibm.com
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


I hope this isn't a repeat but the archive has been down for a few days:
  http://www.linux.sgi.com/mips/archive/

I'm using binutils-19990825 patched with binutils-19991011.diff

They were obtained from:
  ftp://ftp.linux.sgi.com/pub/linux/mips/crossdev/src/mips64/

Are these the latest? If so please read on..

I have built them for cross-compiling on AIX.
Here is the configure invocation:
  ./configure --host=powerpc-ibm-aix4.3.2.0 --target=mips64-unknown-linux-gnu

All built and installed fine, however the linker halts using the .o's
because on an unknoen relocation.


The following assembler:
.text
	.align 4
.ent  _start , 0
	.globl    _start
_start:  
	dla	$sp, kernelInfoLocal
	ld	$sp, 0($sp) 
	daddu	$sp, $sp, 0x6000
	dla	$25, crtInit  
	j	$25 
 #  NOTREACHED
	j	ra 	 
.end   _start

on irix:
  $ as -version
  MIPSpro Compilers: Version 7.2.1

  $ as -64 -non_shared -mips3 crt0s.s -o crt0s.o

on aix:
  $ mips64-unknown-linux-gnu-objdump -r crt0s.o

  crt0s.o:     file format elf64-bigmips
...
successfully dumps the relocation information.

if I compiler the same file in aix:
  $ mips64-unknown-linux-gnu-as -64 -mips3 -non_shared crt0s.s -o crt0s.o
  $ mips64-unknown-linux-gnu-objdump -r crt0s.o

  crt0s.o:     file format elf64-bigmips

  mips64-unknown-linux-gnu-objdump: crt0s.o: File in wrong format
RELOCATION RECORDS FOR [.text]:

-Jimi X
