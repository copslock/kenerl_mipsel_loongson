Received:  by oss.sgi.com id <S305172AbQCUWne>;
	Tue, 21 Mar 2000 14:43:34 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:8755 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQCUWnS>;
	Tue, 21 Mar 2000 14:43:18 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA01439; Tue, 21 Mar 2000 14:38:39 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA60192
	for linux-list;
	Tue, 21 Mar 2000 14:24:17 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA87166
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 21 Mar 2000 14:24:01 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from mx.mips.com (mx.mips.com [206.31.31.226]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA09437
	for <linux@cthulhu.engr.sgi.com>; Tue, 21 Mar 2000 14:23:54 -0800 (PST)
	mail_from (kevink@mips.com)
Received: from newman.mips.com (newman [206.31.31.8])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id OAA11981;
	Tue, 21 Mar 2000 14:23:47 -0800 (PST)
Received: from satanas (satanas [192.168.236.12])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id OAA11488;
	Tue, 21 Mar 2000 14:23:44 -0800 (PST)
Message-ID: <00f101bf9384$a2ec6230$0ceca8c0@satanas.mips.com>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Dominic Sweetman" <dom@algor.co.uk>
Cc:     "Linux SGI" <linux@cthulhu.engr.sgi.com>, <linux-mips@fnet.fr>,
        <linux-mips@vger.rutgers.edu>
Subject: Re: FP emulation patch available
Date:   Tue, 21 Mar 2000 23:27:19 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.5
X-Mimeole: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

>> Denormalised operands (for example) will cause any computational
>> operation to blow up (change sign, load, store and move will survive -
>> can you think of much else?).  The requirement for MIPS hardware is
>> something like "you can throw an unimplemented exception in response
>> to any combination of operands and operation you don't like, so long
>> as it's rare".  That's why a complete emulator is probably a good
>> idea.
>>
>> Dominic Sweetman
>> dom@algor.co.uk
>
>OK, I'm convinced.  I believe I know how to make the Algorithmics
>emulator SMP-safe *and* more efficient in the general case, thanks
>in part to a suggestion from Ralf.  Time permitting, I will also wire it
>up to the unimplemented operation handler.  Give me a week or so
>to accumulate enough spare time...


OK, I've done it, and it seems to work very nicely indeed.
The combination of a real FPU with the Algorithmics emulator
for the Unimplemented corner case has given me the first
100% successful "paranoia" runs I've seen under MIPS Linux.
I also merged in some R3000 fixes that Harald pointed out
to me.  I'm holding off on distribution to give my colleagues
some time to merge in some CP0 hazard fixes, but we'll be 
putting the sources and patches up on the web in the next 
few days...

            Kevin K.
