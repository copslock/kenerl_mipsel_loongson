Received:  by oss.sgi.com id <S305163AbQCRUS0>;
	Sat, 18 Mar 2000 12:18:26 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:51027 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCRUSL>; Sat, 18 Mar 2000 12:18:11 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id MAA04771; Sat, 18 Mar 2000 12:21:37 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA77026
	for linux-list;
	Sat, 18 Mar 2000 11:56:38 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA78155
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 18 Mar 2000 11:56:34 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA05623
	for <linux@cthulhu.engr.sgi.com>; Sat, 18 Mar 2000 11:56:34 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id LAA05216;
	Sat, 18 Mar 2000 11:56:30 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id LAA29849;
	Sat, 18 Mar 2000 11:56:28 -0800 (PST)
Message-ID: <00aa01bf9114$8bc4b0c0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "SGI Linux Alias" <linux@cthulhu.engr.sgi.com>
Subject: Re: Include coherency problem, sigaction and otherwise
Date:   Sat, 18 Mar 2000 20:59:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>> Certainly the hardhat-sgi-5.1-tar.gz archive on oss.sgi.com is out of sync
>> with any MIPS/Linux kernel sources of which I am aware.  The most recent
>> version of glibc 2.0 for MIPS that I have been able to find is 2.0.7, and it
>> too seems to be out of synch.  Which version of glibc has been fixed,
>> and where can I download it?   Which userland distribution is built with
>> the consistent glibc?
>
>Definately no entire distribution, I'm also not sure if I actually did
>publish a fixed libc due to another binutils related issue.  I'm about to
>jump into a plane but could you take a look at
>pub/linux/mips/redhat/manhattan/RedHat/RPMS/glibc-2.0.6-4.mipseb.rpm
>from oss?
>
>  Ralf  (Up, up and away ...)

I checked.  2.0.6-4 seems to be the same version as is in
the hardhat-sgi-5.1-tar.gz archive, and as such is broken.

Hope you're having a good flight!

            Kevin K.
