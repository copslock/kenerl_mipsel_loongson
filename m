Received:  by oss.sgi.com id <S42343AbQEZQ52>;
	Fri, 26 May 2000 09:57:28 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:44060 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42325AbQEZQTK>;
	Fri, 26 May 2000 09:19:10 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA03458; Fri, 26 May 2000 07:05:24 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA01564
	for linux-list;
	Fri, 26 May 2000 07:02:56 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA96839;
	Fri, 26 May 2000 07:02:47 -0700 (PDT)
	mail_from (jimix@watson.ibm.com)
Received: from igw8.watson.ibm.com (igw8.watson.ibm.com [198.81.209.20]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA07367; Fri, 26 May 2000 07:02:18 -0700 (PDT)
	mail_from (jimix@watson.ibm.com)
Received: from sp1n189at0.watson.ibm.com (sp1n189at0.watson.ibm.com [9.2.104.62])
	by igw8.watson.ibm.com (8.9.3/8.9.3/05-14-1999) with ESMTP id KAA17310;
	Fri, 26 May 2000 10:02:13 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.229.13]) by sp1n189at0.watson.ibm.com (8.9.3/Feb-20-98) with ESMTP id KAA20648; Fri, 26 May 2000 10:02:12 -0400
Received: (from jimix@localhost)
	by kitch0.watson.ibm.com (AIX4.3/8.9.3/8.9.3/01-10-2000) id KAA29814;
	Fri, 26 May 2000 10:02:12 -0400
From:   jimix@pobox.com (Jimi X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14638.33763.840817.330892@kitch0.watson.ibm.com>
Date:   Fri, 26 May 2000 10:02:11 -0400 (EDT)
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
CC:     linux@cthulhu.engr.sgi.com
Subject: Re: cross Mips64-linux binutils problem
In-Reply-To: <Pine.LNX.4.21.0005241637480.15277-100000@calypso.engr.sgi.com>
References: <14636.15579.327225.215562@kitch0.watson.ibm.com>
	<Pine.LNX.4.21.0005241637480.15277-100000@calypso.engr.sgi.com>
X-Mailer: VM 6.75 under 20.4 "Emerald" XEmacs  Lucid
Reply-To: jimix@watson.ibm.com
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>>>>> "UC" == Ulf Carlsson <ulfc@calypso.engr.sgi.com> writes:

 UC> You could try my superpatch that I have on oss.sgi.com.  It's a
 UC> newer than Ralf's patch that you have:
 UC>
 UC> 	ftp://oss.sgi.com/pub/linux/mips/src/binutils/binutils-000424.diff.gz

I forward ported your patch to binutils-000524 since I could not get
my hands on 000524. 

  $ /../mips-000524/gas/as-new -64 -mips3 -non_shared  crt0s.s -o crt0s.o
  crt0s.s: Assembler messages:
  crt0s.s:7: Internal error, aborting at /../binutils-000524/gas/config/tc-mips.c line 4364 in macro
  Please report this bug.

The line may not match because of the different base snapshot but it
certainly comes from line 1427 of the patch.

If I add a -G 0 (which is how I normaly build anyway) then the assembler
does not complain.

However, my relocations seem messed up! objdump fails reading them,
IRIX elfdump seems confused though readelf seems to handle it fine.

Here is the source again:

.text
	.align 4
.ent  _start , 0
	.globl _start
_start:  
	dla	$sp, kernelInfoLocal
	ld	$sp, 0($sp) 
	daddu	$sp, $sp, 0x6000

	dla	$25, crtInit  
	j	$25 
 #  NOTREACHED
	j	$31 	 
.end   _start

An interesing item (but may be a red herring) is that IRIX as(1) places
R_MIPS_LO16 relocations int the .rel.text section, and gas(1) places
them (an all relocations) in .rela.text

I'm assuming that if objdump can't read my .o's then the gld(1)
probably can't either. Does that make sense?

Any ideas?

-Jimi X
