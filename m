Received:  by oss.sgi.com id <S305193AbQBJKfL>;
	Thu, 10 Feb 2000 02:35:11 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:12908 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbQBJKex>;
	Thu, 10 Feb 2000 02:34:53 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id CAA27082; Thu, 10 Feb 2000 02:30:23 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA68783
	for linux-list;
	Thu, 10 Feb 2000 02:14:03 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA74197
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 10 Feb 2000 02:13:58 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA06649
	for <linux@cthulhu.engr.sgi.com>; Thu, 10 Feb 2000 02:13:57 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA01307;
	Thu, 10 Feb 2000 02:13:53 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id CAA06439;
	Thu, 10 Feb 2000 02:13:48 -0800 (PST)
Message-ID: <00bc01bf73af$c7b19bc0$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:     <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>
Subject: Re: Enhanced 2.2.12 MIPS Kernel Sources  Available
Date:   Thu, 10 Feb 2000 11:15:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>"Kevin D. Kissell" wrote:
>> 
>> This code is NOT a supported product of MIPS
>> Technologies Inc.   It is being made available on an
>> "as is" basis subject to the ususal GPL.  It should be
>> accessible via anonymous (and blind) FTP for a while at
>> ftp://ftp.mips.com/incoming/linux.mips.src.01.01.tar.gz
>> and is archived on the Paralogos MIPS/Linux web site at
>> http://www.paralogos.com/mipslinux/.  We'd be very interested
>> in any feedback, experimental results, and enhancements
>> that any of you may wish to provide, and I will answer
>> email questions to the extent that my time allows.
>> 
>
>It'll be great if you would put just patches too. I guess, it'll be easy
>for us to look through set of patches instead of downloading entire
>2.2.12 and making diff -ruN on it. Then, there might be a core patch
>that decribes changes in machine independent part of the kernel and the
>rest might cover specific boards. Most of developers here will be
>interested in the core patch, I guess.
>
>Regards,
>Gleb.

The thought had certainly occurred to me to generate the patch
relative to the 2.2.12 baseline - it would certainly be more compact
than the whole source tree!   I'll try and find the time to do so, but
it probably won't be any time this week...
