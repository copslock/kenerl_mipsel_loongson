Received:  by oss.sgi.com id <S305166AbPLFNWS>;
	Mon, 6 Dec 1999 05:22:18 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:13358 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305158AbPLFNWC>;
	Mon, 6 Dec 1999 05:22:02 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id FAA03550; Mon, 6 Dec 1999 05:25:04 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id FAA17968
	for linux-list;
	Mon, 6 Dec 1999 05:19:21 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id FAA70363
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 05:19:16 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id FAA00356
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 05:19:16 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA06665;
	Mon, 6 Dec 1999 05:19:14 -0800 (PST)
Received: from satanas (fr-host2 [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA29747;
	Mon, 6 Dec 1999 05:19:12 -0800 (PST)
Message-ID: <00a201bf3fed$df8c82f0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>
Cc:     "Linux SGI" <linux@cthulhu.engr.sgi.com>
Subject: Re: Nomenclature: "MIPS32", "MIPS64"
Date:   Mon, 6 Dec 1999 14:29:06 +0100
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

>On Mon, Dec 06, 1999 at 01:44:55PM +0100, Kevin D. Kissell wrote:
>
>> "MIPS32" and "MIPS64" have a very specific
>> meaning now, and for all I know are already
>> trademarked/brandmarked/whatever by
>> MIPS Technologies Inc. to describe the new
>> baseline ISA and privileged resource architecture
>> (CP0, in other words) standards for 32-bit
>> and 64-bit MIPS devices.   It's no big deal
>> for informal discussion, but *please* do not
>> use the strings "MIPS32" or "MIPS64" in the
>> code or documentation unless you are really
>> and truly referring to MIPS32 and MIPS64
>> as defined by MIPS.   If you want to refer to
>> the 64-bit versus 32-bit Linux ports, please
>> express it otherwise, e.g. MIPS64bit,
>> MIPS_64_bit, 64bitMIPS, etc.   Otherwise
>> there is going to be a lot of needless confusion
>> and a further source schism.
>
>The use of these terms is pretty coherent with their meaning as given by
>Mips, Inc.  Linux/MIPS32 is a implementation of Linux (mostly) for MIPS32
>processors, Linux/MIPS64 for MIPS64 processors, so I don't see the problem.
>
>  Ralf

The problems are twofold.  First, while it is of course possible to create
a kernel that will run on both MIPS64 and pre-MIPS64 MIPS-III and
MIPS-IV CPUs, it is also possible to create a MIPS64 kernel that
would not necessarily run on R10000s and vice versa.  Secondly,
we are referring to two distinct things that ought to be distinguished
at the source and documentation level.   We need a name for something 
that is 64-bit-MIPS but not necessarily tied up with any particular CPU 
and a distinct name for something that is compatible with a particular 
CPU type.  "MIPS32" and "MIPS64" are already trademarked
by MIPS to describe the CPUs, so we need another name for the 
generic OS infrastructure for 64-bit MIPS registers/addresses.
