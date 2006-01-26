Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 20:21:11 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:7109 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133719AbWAZUUx
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 20:20:53 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0QKPFKX022475;
	Thu, 26 Jan 2006 12:25:15 -0800 (PST)
Received: from olympia.mips.com (olympia [192.168.192.128])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k0QKPDYr026730;
	Thu, 26 Jan 2006 12:25:13 -0800 (PST)
Received: from highbury.mips.com ([192.168.192.236])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1F2Dg6-0005vi-00; Thu, 26 Jan 2006 20:25:10 +0000
Message-ID: <43D93025.9040800@mips.com>
Date:	Thu, 26 Jan 2006 20:25:09 +0000
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
CC:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>	 <cda58cb80601250632r3e8f7b9en@mail.gmail.com>	 <20060125150404.GF3454@linux-mips.org>	 <cda58cb80601251003m6ba4379w@mail.gmail.com>	 <43D7C050.5090607@mips.com>	 <cda58cb80601260702wf781e70l@mail.gmail.com>	 <005101c6228c$6ebfb0a0$10eca8c0@grendel> <43D8F000.9010106@mips.com>	 <cda58cb80601260831i61167787g@mail.gmail.com>	 <43D8FF16.40107@mips.com> <cda58cb80601261002w6eb02249k@mail.gmail.com>
In-Reply-To: <cda58cb80601261002w6eb02249k@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.762,
	required 4, AWL, BAYES_00)
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Franck wrote:

>2006/1/26, Nigel Stephens <nigel@mips.com>:
>  
>
>>1) Using -march=4ksd reduces the cost of a multiply by 1 instruction
>>(from 5 to 4 cycles), so a few more constant multiplications, previously
>>expanded into a sequence of shifts, adds and subs, may now be replaced
>>by a shorter sequence of "li" and "mul" instructions.
>>
>>    
>>
>
>Is it really specific to 4ksd cpu ? Could this behaviour be triggered
>by other options ?
>  
>

Yes, when you use -Os the compiler uses the instruction cost (1) of a 
mul, instead of the cycle cost (4), so it will be even more likely to 
replace the expanded shift/add sequence by a mul.

>>   text    data     bss     dec     hex filename
>>2099642  110784   81956 2292382  22fa9e vmlinux-4ksd
>>2136269  110784   81956 2329009  2389b1 vmlinux-mips32r2
>>1953086  110784   81956 2145826  20be22 vmlinux-4ksd-Os
>>1954489  110784   81956 2147229  20c39d vmlinux-mips32r2-Os
>>
>>I now have to check that your first and second points don't have too
>>much bad impact on the overall speed although I don't know how to
>>measure that...But if so, I could safely use -march=mips32r2 -Os
>>options.
>>    
>>

You could, but why not stick with -march=4ksd if that's your CPU of 
choice? It appears to result in  marginally smaller code even when using 
-Os, and should have (slightly) better performance than a generic 
mips32r2 kernel?

Nigel
