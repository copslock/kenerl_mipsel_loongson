Received:  by oss.sgi.com id <S305166AbPLFPZ6>;
	Mon, 6 Dec 1999 07:25:58 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:45898 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305158AbPLFPZd>;
	Mon, 6 Dec 1999 07:25:33 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA13565; Mon, 6 Dec 1999 07:28:35 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA40793
	for linux-list;
	Mon, 6 Dec 1999 07:21:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA44463
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 07:21:30 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA06193
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 07:21:29 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA08366;
	Mon, 6 Dec 1999 07:21:27 -0800 (PST)
Received: from satanas (fr-host2 [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id HAA01699;
	Mon, 6 Dec 1999 07:21:25 -0800 (PST)
Message-ID: <00b501bf3ffe$f25a9910$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc:     <ralf@oss.sgi.com>, <linux@cthulhu.engr.sgi.com>
Subject: Re: Nomenclature: "MIPS32", "MIPS64"
Date:   Mon, 6 Dec 1999 16:31:13 +0100
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

>On Mon, Dec 06, 1999 at 01:35:54PM +0000, Alan Cox wrote:
>
>> I would suggest that until someone from MIPS legal specifically raises an
issue
>> you don't worry about it. With the sparc people they were quite happy with
>> Linux/sparc - which denotes Linux for sparc systems (they objected to
>> sparclinux as that implied it was their product). In fact given the "/" is
>> 'for' then I don't think there is even a valid trademark issue to be raised.
>>
>> Its also not in MIPS interest to cause trouble. Its a product for their
>> system. If they started being silly then everyones lawyers would be advising
>> them to pull their "xyz product for mips" as a legal precaution.
>
>I wouldn't expect MIPS to create any legal problems for anybody; you should
>consider this no more than an advice.
>
>  Ralf

Exactly.  The point is that there are two different concepts to be represented
in the kernel for which we risk having a name collision, and that the
registration
of the trademark provides an argument somewhat stronger than a coin toss
for resolving it one way and not the other.
