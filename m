Received:  by oss.sgi.com id <S305157AbPLCPhT>;
	Fri, 3 Dec 1999 07:37:19 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:40223 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbPLCPhD>; Fri, 3 Dec 1999 07:37:03 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id HAA00517; Fri, 3 Dec 1999 07:45:38 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA13960
	for linux-list;
	Fri, 3 Dec 1999 07:26:20 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA21799
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 3 Dec 1999 07:26:13 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA00596
	for <linux@cthulhu.engr.sgi.com>; Fri, 3 Dec 1999 07:26:12 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA07327;
	Fri, 3 Dec 1999 07:26:10 -0800 (PST)
Received: from thinkpad (par-c45-008-vty229.as.wcom.net [195.232.72.229])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id HAA16008;
	Fri, 3 Dec 1999 07:25:49 -0800 (PST)
Message-ID: <000c01bf3da2$dab2a400$e548e8c3@thinkpad>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Ralf Baechle" <ralf@oss.sgi.com>,
        "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc:     "Marc Esipovich" <marc@mucom.co.il>, <e1097757@ceng.metu.edu.tr>,
        <linux@cthulhu.engr.sgi.com>
Subject: Re: EXT2 fs error
Date:   Fri, 3 Dec 1999 16:26:42 +0100
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

>On Tue, Nov 30, 1999 at 07:52:04PM +0000, Alan Cox wrote:
>
>> If there is a scsi error before the ext2fs error then yes probably so
>> You are looking for a "media error" probably.
>>
>> > > SCSI bus is being reset for 0 channel 0.
>> > > scsi0 reset. sending SDTR
>> >
>> > SCSI reset is due to repeated attempts to read a block, or I might be
>> > wrong and it it's due to a malfunction of the controller on your HD.
>>
>> You can get it off some working sane hardware if you try and ask for
stupid
>> block numbers. It is worth doing a full fsck on the drive before assuming
>> hardware. Also check the cabling seems sound and is well attached and
that
>> parity is enabled on the controller if the bios sets it.
>
>I've seen this happening on my Indy as well like once every month or even
>more rarely.  It only happens very rarely but it happens.  I think the
>hardware of my Indy is fine as all my attempts to reduce the problems I'm
>experiencing during my development to a hardware problem have failed.
>
>  Ralf

By any chance are you guys seeing this on R5000 Indys?
There is an assumption in arch/mips/mm/r4xx0.c that
flushing the secondary cache automagically flushes
the same address in the primary data cache, but that
assumption is not universally valid and there is no
reason to believe that it is true on the R5K.   This
could cause periodic random corruptions of DMA
transfers, which could in turn manifest themselves
as corrupted files or file system meta-data.  The
R4000/R4400SC systems, and the entry-level
Indy's without secondary caches should not be
at risk.

            Kevin K.
