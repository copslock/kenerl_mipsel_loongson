Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 15:47:30 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:55747 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133559AbWAZPrM
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 15:47:12 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0QFpXd5020988;
	Thu, 26 Jan 2006 07:51:33 -0800 (PST)
Received: from olympia.mips.com (olympia [192.168.192.128])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k0QFpXYr020092;
	Thu, 26 Jan 2006 07:51:34 -0800 (PST)
Received: from highbury.mips.com ([192.168.192.236])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1F29PF-0000YU-00; Thu, 26 Jan 2006 15:51:29 +0000
Message-ID: <43D8F000.9010106@mips.com>
Date:	Thu, 26 Jan 2006 15:51:28 +0000
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@mips.com>,
	Franck <vagabon.xyz@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com> <20060125124738.GA3454@linux-mips.org> <cda58cb80601250534r5f464fd1v@mail.gmail.com> <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org> <cda58cb80601250632r3e8f7b9en@mail.gmail.com> <20060125150404.GF3454@linux-mips.org> <cda58cb80601251003m6ba4379w@mail.gmail.com> <43D7C050.5090607@mips.com> <cda58cb80601260702wf781e70l@mail.gmail.com> <005101c6228c$6ebfb0a0$10eca8c0@grendel>
In-Reply-To: <005101c6228c$6ebfb0a0$10eca8c0@grendel>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.758,
	required 4, AWL, BAYES_00)
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Kevin D. Kissell wrote:

>Could you please post your mipsel-linux-gcc -v output?   It might help.
>I've never tried building Linux with any of the Sc/Sd/SmartMIPS options,
>so I really don't know what you could be experiencing.  One thought that
>comes to mind is that the -march=4ksd option may be treated as a hint to
>generate compact code (for smart cards) in a way that -march=mips32r2
>is not.  I'll ask around...
>  
>

Assuming that this is the SDE compiler, then I think that the only 
significant thing which -march=4ksd will do differently from 
-march=mips32r2 is to allow the compiler to generate branch-likely 
instructions -- they're deprecated for generic mips32 code but carry no 
penalty on the 4K core. It will also cause the compiler's "4kc" pipeline 
description to be used for instruction scheduling, instead of the 
default "24kc", but that should only change the order of instructions 
and shouldn't really make a significant difference to the code size.

>
>>Now the size of the kernel code is 33Ko bigger ! I have no idea
>>why...I tried to add -mips16e option but it fails to compile...Do you
>>have an idea ?
>>
>>    
>>

You certainly can't compile the kernel with -mips16e: too much inline 
asm code which won't work in mips16.

Nigel
