Received:  by oss.sgi.com id <S42349AbQFANdL>;
	Thu, 1 Jun 2000 06:33:11 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:17703 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42272AbQFANc6>;
	Thu, 1 Jun 2000 06:32:58 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA22688; Thu, 1 Jun 2000 07:28:04 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA21960
	for linux-list;
	Thu, 1 Jun 2000 07:22:00 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA09786;
	Thu, 1 Jun 2000 07:21:58 -0700 (PDT)
	mail_from (jimix@watson.ibm.com)
Received: from igw8.watson.ibm.com (igw8.watson.ibm.com [198.81.209.20]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA09570; Thu, 1 Jun 2000 07:21:51 -0700 (PDT)
	mail_from (jimix@watson.ibm.com)
Received: from sp1n189at0.watson.ibm.com (sp1n189at0.watson.ibm.com [9.2.104.62])
	by igw8.watson.ibm.com (8.9.3/8.9.3/05-14-1999) with ESMTP id KAA15606;
	Thu, 1 Jun 2000 10:21:52 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.251.57]) by sp1n189at0.watson.ibm.com (8.9.3/Feb-20-98) with ESMTP id KAA28530; Thu, 1 Jun 2000 10:21:51 -0400
Received: (from jimix@localhost)
	by kitch0.watson.ibm.com (AIX4.3/8.9.3/8.9.3/01-10-2000) id KAA36312;
	Thu, 1 Jun 2000 10:21:51 -0400
From:   jimix@pobox.com (Jimi X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14646.29054.561175.977539@kitch0.watson.ibm.com>
Date:   Thu, 1 Jun 2000 10:21:50 -0400 (EDT)
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: cross Mips64-linux binutils problem
In-Reply-To: <Pine.LNX.4.21.0006010053110.1711-100000@calypso.engr.sgi.com>
References: <14638.33763.840817.330892@kitch0.watson.ibm.com>
	<Pine.LNX.4.21.0006010053110.1711-100000@calypso.engr.sgi.com>
X-Mailer: VM 6.75 under 20.4 "Emerald" XEmacs  Lucid
Reply-To: jimix@watson.ibm.com
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>>>>> "UC" == Ulf Carlsson <ulfc@calypso.engr.sgi.com> writes:

 >> However, my relocations seem messed up! objdump fails reading
 >> them, IRIX elfdump seems confused though readelf seems to handle
 >> it fine.

 UC> I don't know what you're doing wrong.  I could objdump it just
 UC> fine.  I haven't tested with IRIX.

How did you run the assembler? I'm using "as-new -64 -mips3 -G0", is
there more?

 UC> $ ../binutils/objdump -dr jimi-testcase.o

 UC> test.o: file format elf64-littlemips

hmmm.. Are you defaulting to elf64-littlemips? I had tried to do this
using '-EL' option but it doesn't seem to make the switch and I still
have problems.

I'll get a hold of the same snapshot you are using and add the patch
and see if it works any better.


-Jimi X
