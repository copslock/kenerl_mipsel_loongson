Received:  by oss.sgi.com id <S42240AbQEYOOG>;
	Thu, 25 May 2000 07:14:06 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:53256 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42238AbQEYONt>;
	Thu, 25 May 2000 07:13:49 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA06829; Thu, 25 May 2000 08:08:57 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA37668
	for linux-list;
	Thu, 25 May 2000 07:59:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA31264;
	Thu, 25 May 2000 07:59:37 -0700 (PDT)
	mail_from (jimix@watson.ibm.com)
Received: from igw8.watson.ibm.com (igw8.watson.ibm.com [198.81.209.20]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA07072; Thu, 25 May 2000 07:59:35 -0700 (PDT)
	mail_from (jimix@watson.ibm.com)
Received: from sp1n189at0.watson.ibm.com (sp1n189at0.watson.ibm.com [9.2.104.62])
	by igw8.watson.ibm.com (8.9.3/8.9.3/05-14-1999) with ESMTP id KAA12000;
	Thu, 25 May 2000 10:59:38 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.229.13]) by sp1n189at0.watson.ibm.com (8.9.3/Feb-20-98) with ESMTP id KAA22998; Thu, 25 May 2000 10:59:37 -0400
Received: (from jimix@localhost)
	by kitch0.watson.ibm.com (AIX4.3/8.9.3/8.9.3/01-10-2000) id KAA44418;
	Thu, 25 May 2000 10:59:37 -0400
From:   jimix@pobox.com (Jimi X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14637.16344.751320.262100@kitch0.watson.ibm.com>
Date:   Thu, 25 May 2000 10:59:36 -0400 (EDT)
To:     Ulf Carlsson <ulfc@calypso.engr.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com
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

 >> I'm using binutils-19990825 patched with binutils-19991011.diff
 UC> I have used that patch together with the binutils CVS from
 UC> 19991011 and that worked for me.  At least for building 32-bit
 UC> kernel.

Well, I'm only interested in 64-bit static only. I'm not ready for
shared yet either.

 >> They were obtained from:
 >> ftp://ftp.linux.sgi.com/pub/linux/mips/crossdev/src/mips64/
 >>
 >> Are these the latest? If so please read on..

 UC> You could try my superpatch that I have on oss.sgi.com.  It's a
 UC> newer than Ralf's patch that you have:

 UC>
 UC> 	ftp://oss.sgi.com/pub/linux/mips/src/binutils/binutils-000424.diff.gz

thanks I will try and let you know.

BTW: what are your people using to build the mip64 linux kernel changes 
that went in a few months ago?

-Jimi X
