Received:  by oss.sgi.com id <S42285AbQHBSgD>;
	Wed, 2 Aug 2000 11:36:03 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:4636 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42282AbQHBSff>; Wed, 2 Aug 2000 11:35:35 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA08923
	for <linux-mips@oss.sgi.com>; Wed, 2 Aug 2000 11:40:58 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA23562
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Aug 2000 11:34:47 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA00027
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Aug 2000 11:34:46 -0700 (PDT)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id LAA03354;
	Wed, 2 Aug 2000 11:33:34 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id LAA29718;
	Wed, 2 Aug 2000 11:33:34 -0700 (PDT)
Message-ID: <01c901bffcb0$922057a0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Dominic Sweetman" <dom@algor.co.uk>, "Jun Sun" <jsun@mvista.com>
Cc:     <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <ralf@oss.sgi.com>
Subject: Re: PROPOSAL : multi-way cache support in Linux/MIPS
Date:   Wed, 2 Aug 2000 20:36:17 +0200
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

Dom Sweetman writes:
>So far as I know the Vr5432 is the only CPU to do anything so silly as
>using the lowest index bits to select the "way". 

Alas, the R10000 does the same silly thing, and while you
and I might not consider such a venerable processor interesting
for new embedded MIPS/Linux designs, our friends who
are trying to replace IRIX with Linux on their SGI boxes
are going to have to deal with them for a little while longer.

>The MS-selects-way organisation permits the cache to be initialised
>without the software ever needing to know how many ways it has (just
>crank the index up, but being careful about the tendency to recycle
>the same way when pre-filling cache data).

Which is why MIPS belatedly documented it as the "correct"
way to design a multiway cache...

>Cache maintenance should always use "hit" type instructions, and you
>don't need to know the cache organisation for those, even with the
>Vr5432.

The counterargument to *always* using "hit" ops is that they
generate TLB traffic and TLB refills, which some people
find annoying to allow for and in any case time consuming.


            Regards,

            Kevin K.
