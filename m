Received:  by oss.sgi.com id <S42287AbQEXXIR>;
	Wed, 24 May 2000 16:08:17 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:33343 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42281AbQEXXIC>; Wed, 24 May 2000 16:08:02 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA06631; Wed, 24 May 2000 17:12:41 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA96069
	for linux-list;
	Wed, 24 May 2000 16:53:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA31804;
	Wed, 24 May 2000 16:53:04 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1])
	by calypso.engr.sgi.com (Postfix) with ESMTP
	id D9621A78D7; Wed, 24 May 2000 16:52:02 -0700 (PDT)
Date:   Wed, 24 May 2000 16:52:02 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
To:     jimix@watson.ibm.com
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: cross Mips64-linux binutils problem
In-Reply-To: <14636.15579.327225.215562@kitch0.watson.ibm.com>
Message-ID: <Pine.LNX.4.21.0005241637480.15277-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> I'm using binutils-19990825 patched with binutils-19991011.diff

I have used that patch together with the binutils CVS from 19991011 and that
worked for me.  At least for building 32-bit kernel.

> They were obtained from:
>   ftp://ftp.linux.sgi.com/pub/linux/mips/crossdev/src/mips64/
> 
> Are these the latest? If so please read on..

You could try my superpatch that I have on oss.sgi.com.  It's a newer than
Ralf's patch that you have:

	ftp://oss.sgi.com/pub/linux/mips/src/binutils/binutils-000424.diff.gz

It's against the official binutils CVS for the same day.

> I have built them for cross-compiling on AIX.
> Here is the configure invocation:
>   ./configure --host=powerpc-ibm-aix4.3.2.0 --target=mips64-unknown-linux-gnu
> 
> All built and installed fine, however the linker halts using the .o's
> because on an unknoen relocation.
> 
> 
> The following assembler:
> .text
> 	.align 4
> .ent  _start , 0
> 	.globl    _start
> _start:  
> 	dla	$sp, kernelInfoLocal
> 	ld	$sp, 0($sp) 
> 	daddu	$sp, $sp, 0x6000
> 	dla	$25, crtInit  
> 	j	$25 
>  #  NOTREACHED
> 	j	ra 	 
> .end   _start
> 
> on irix:
>   $ as -version
>   MIPSpro Compilers: Version 7.2.1
> 
>   $ as -64 -non_shared -mips3 crt0s.s -o crt0s.o
> 
> on aix:
>   $ mips64-unknown-linux-gnu-objdump -r crt0s.o
> 
>   crt0s.o:     file format elf64-bigmips
> ...
> successfully dumps the relocation information.
> 
> if I compiler the same file in aix:
>   $ mips64-unknown-linux-gnu-as -64 -mips3 -non_shared crt0s.s -o crt0s.o
>   $ mips64-unknown-linux-gnu-objdump -r crt0s.o
> 
>   crt0s.o:     file format elf64-bigmips
> 
>   mips64-unknown-linux-gnu-objdump: crt0s.o: File in wrong format
> RELOCATION RECORDS FOR [.text]:

The relocation format for mips64 is very different, and they aren't handled
correctly in this version of binutils.  I think my later patch fixes this. By
the way, compiling 64-bit PIC code using gas is not recommended (yet).

Ulf
