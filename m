Received:  by oss.sgi.com id <S42225AbQGAGot>;
	Fri, 30 Jun 2000 23:44:49 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:11566 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42200AbQGAGoc>; Fri, 30 Jun 2000 23:44:32 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id XAA03774
	for <linux-mips@oss.sgi.com>; Fri, 30 Jun 2000 23:50:01 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id XAA12459
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 30 Jun 2000 23:44:01 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id XAA06719
	for <linux@cthulhu.engr.sgi.com>; Fri, 30 Jun 2000 23:44:00 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA20994;
	Fri, 30 Jun 2000 23:44:18 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id XAA14777;
	Fri, 30 Jun 2000 23:44:16 -0700 (PDT)
Message-ID: <000601bfe328$2e3fe6c0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Jun Sun" <jsun@mvista.com>, "Dominic Sweetman" <dom@algor.co.uk>
Cc:     <linux-mips@fnet.fr>, <linux@cthulhu.engr.sgi.com>,
        <nigel@algor.co.uk>
Subject: Re: R5000 support (specifically two-way set-associative cache...)
Date:   Sat, 1 Jul 2000 08:46:59 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

In any case, note that the cache descriptor structures
defined by MIPS Technologies for the Linux 2.2 kernels
(coming one of these days to 2.3) allow for the cache
geometry to be fully described and specified, either
as a simple table copy based on the PrID, or as a
combination of table data and dynamic probing.

            Kevin K.

-----Original Message-----
From: Jun Sun <jsun@mvista.com>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: linux-mips@fnet.fr <linux-mips@fnet.fr>; linux@cthulhu.engr.sgi.com
<linux@cthulhu.engr.sgi.com>; nigel@algor.co.uk <nigel@algor.co.uk>
Date: Saturday, July 01, 2000 3:29 AM
Subject: Re: R5000 support (specifically two-way set-associative cache...)


>
>> Fundamentally:
>>
>> o "index" operations just go first through one set, then the other.
>>   So long as initialisation routines are applied to each possible
>>   index in turn, both sets get initialised.
>>
>> o "hit" operations "just work".
>>
>> So long as initialisation is done carefully (basic rule: perform one
>> stage to the whole cache before going on to the next), run-time cache
>> maintenance can and should be done with "hit" instructions, and you
>> don't need to worry whether the CPU is direct mapped, 2- or 4-way set
>> associative.
>>
>> (it's all explained in my book, "See MIPS Run", of course...)
>>
>> Even with the Vr5432 you only have to know the difference when first
>> setting up the CPU.
>>
>
>Not exactly - the current Linux/MIPS implementation uese index
>operations to flush cache.
>As a result flush_all_cache() does not really flush all cache.
>
>
>> Dominic Sweetman
>> Algorithmics Ltd
>
>Jun
>> dom@algor.co.uk
