Received:  by oss.sgi.com id <S42350AbQFAOOP>;
	Thu, 1 Jun 2000 07:14:15 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:31026 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42349AbQFAOOE>;
	Thu, 1 Jun 2000 07:14:04 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA27296; Thu, 1 Jun 2000 08:09:10 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA27260
	for linux-list;
	Thu, 1 Jun 2000 08:06:06 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA81029;
	Thu, 1 Jun 2000 08:05:55 -0700 (PDT)
	mail_from (jimix@watson.ibm.com)
Received: from igw8.watson.ibm.com (igw8.watson.ibm.com [198.81.209.20]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA09414; Thu, 1 Jun 2000 08:05:37 -0700 (PDT)
	mail_from (jimix@watson.ibm.com)
Received: from sp1n189at0.watson.ibm.com (sp1n189at0.watson.ibm.com [9.2.104.62])
	by igw8.watson.ibm.com (8.9.3/8.9.3/05-14-1999) with ESMTP id LAA13964;
	Thu, 1 Jun 2000 11:05:40 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.251.57]) by sp1n189at0.watson.ibm.com (8.9.3/Feb-20-98) with ESMTP id LAA23352; Thu, 1 Jun 2000 11:05:40 -0400
Received: (from jimix@localhost)
	by kitch0.watson.ibm.com (AIX4.3/8.9.3/8.9.3/01-10-2000) id LAA37438;
	Thu, 1 Jun 2000 11:05:37 -0400
From:   jimix@pobox.com (Jimi X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14646.31673.28065.650524@kitch0.watson.ibm.com>
Date:   Thu, 1 Jun 2000 11:05:28 -0400 (EDT)
To:     Ralf Baechle <ralf@uni-koblenz.de>,
        Ulf Carlsson <ulfc@calypso.engr.sgi.com>
CC:     linux@cthulhu.engr.sgi.com
Subject: Re: cross Mips64-linux binutils problem
In-Reply-To: <20000601164415.A23324@uni-koblenz.de>
References: <14638.33763.840817.330892@kitch0.watson.ibm.com>
	<Pine.LNX.4.21.0006010053110.1711-100000@calypso.engr.sgi.com>
	<14646.29054.561175.977539@kitch0.watson.ibm.com>
	<20000601164415.A23324@uni-koblenz.de>
X-Mailer: VM 6.75 under 20.4 "Emerald" XEmacs  Lucid
Reply-To: jimix@watson.ibm.com
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>>>>> "RB" == Ralf Baechle <ralf@uni-koblenz.de> writes:

 RB> On Thu, Jun 01, 2000 at 10:21:50AM -0400, Jimi X wrote:
 >>
 >> How did you run the assembler? I'm using "as-new -64 -mips3 -G0",
 >> is there more?

 RB> Are you trying to assemble pic code?  I think that's still very
 RB> broken in binutils even with all of Ulf's fixes.

No I'm not trying to use PIC code.
I made a braino on the assembler line, I'm using:
	as-new -64 -mips3 -G0 -non_shared
I've tries just about every combination.

-Jimi X

BTW: For those of you who do not have my test source, here it is:

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
