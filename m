Received:  by oss.sgi.com id <S305167AbPLFLf6>;
	Mon, 6 Dec 1999 03:35:58 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:34842 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305158AbPLFLfk>;
	Mon, 6 Dec 1999 03:35:40 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA27514; Mon, 6 Dec 1999 03:38:41 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA29394
	for linux-list;
	Mon, 6 Dec 1999 03:31:26 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA86507
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 03:31:23 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA00348
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 03:31:22 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id DAA05094;
	Mon, 6 Dec 1999 03:31:21 -0800 (PST)
Received: from satanas (fr-host2 [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA28053;
	Mon, 6 Dec 1999 03:31:19 -0800 (PST)
Message-ID: <006801bf3fde$cd110ec0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Marc Esipovich" <marc@mucom.co.il>
Cc:     "Linux SGI" <linux@cthulhu.engr.sgi.com>
Subject: Re: Question for David Miller or anyone else about R6000 code
Date:   Mon, 6 Dec 1999 12:41:08 +0100
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

The R10000/R12000 programs are still within SGI,
and are not supported directly by MIPS Technologies
Inc.   The MIPS/Linux kernel today does not support
the R10000 (there's a panic("CPU too expensive");
somewhere if the Processor ID for R10K is detected),
but the CPU should not be at all difficult to support in
the kernel - it was a design constraint of the R10K
that it run the same Windows NT kernel as the
R4400, so the CP0 is a pretty strict superset of 
the R4K.   The hard part of an R10K/O2 port would
be more in the drivers than in the CPU support.
The O2 went for a high-bandwidth "unified memory
architecture" design which has very little resemblence
to any other Linux platform of which I am aware.
I've seen references on this and other mailing lists
to people working on getting Linux onto the O2.
Hopefully, they will respond.

            Regards,

            Kevin K.

-----Original Message-----
From: Marc Esipovich <marc@mucom.co.il>
To: Kevin D. Kissell <kevink@mips.com>
Cc: Linux SGI <linux@cthulhu.engr.sgi.com>
Date: Monday, December 06, 1999 11:33 AM
Subject: Re: Question for David Miller or anyone else about R6000 code


>Hello,
>
> How about R10000 on O2 ? are you working on that aswell?
> Do you have or know where to get documentation of O2's hardware,
> I've opened mine up, the only thing I was able to recognize were
> two Adaptec 7880P controllers (if I recall the model number
> correctly),  could you point me to some place which has docs?
>
> Thanks,
> Marc Esipovich.
>
>--
>root is only a few clicks away...
>
>
