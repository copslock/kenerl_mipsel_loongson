Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 16:52:10 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:4292 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133614AbWAZQvx
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 16:51:53 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0QGtubW021282;
	Thu, 26 Jan 2006 08:55:57 -0800 (PST)
Received: from olympia.mips.com (olympia [192.168.192.128])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k0QGtuYr021349;
	Thu, 26 Jan 2006 08:55:57 -0800 (PST)
Received: from highbury.mips.com ([192.168.192.236])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1F2APY-0001pT-00; Thu, 26 Jan 2006 16:55:52 +0000
Message-ID: <43D8FF16.40107@mips.com>
Date:	Thu, 26 Jan 2006 16:55:50 +0000
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
CC:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>	 <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org>	 <cda58cb80601250632r3e8f7b9en@mail.gmail.com>	 <20060125150404.GF3454@linux-mips.org>	 <cda58cb80601251003m6ba4379w@mail.gmail.com>	 <43D7C050.5090607@mips.com>	 <cda58cb80601260702wf781e70l@mail.gmail.com>	 <005101c6228c$6ebfb0a0$10eca8c0@grendel> <43D8F000.9010106@mips.com> <cda58cb80601260831i61167787g@mail.gmail.com>
In-Reply-To: <cda58cb80601260831i61167787g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.763,
	required 4, AWL, BAYES_00)
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Franck wrote:

>>-march=mips32r2 is to allow the compiler to generate branch-likely
>>instructions -- they're deprecated for generic mips32 code but carry no
>>penalty on the 4K core. It will also cause the compiler's "4kc" pipeline
>>description to be used for instruction scheduling, instead of the
>>default "24kc", but that should only change the order of instructions
>>    
>>
>
>Do you mean that the code can be run faster when using -march=4ksd ?
>  
>

Yes, though the difference is likely to be small. The -march=4ksd option 
also enables the SmartMIPS ASE, but you've already done that explicitly 
with -msmartmips.

>  
>
>>and shouldn't really make a significant difference to the code size.
>>
>>    
>>
>
>yes but I have :(
>  
>

Then you'll have to have a look at the resulting disassembled code and 
figure what's changed. :)

Thinking about this in more detail:

1) Using -march=4ksd reduces the cost of a multiply by 1 instruction 
(from 5 to 4 cycles), so a few more constant multiplications, previously 
expanded into a sequence of shifts, adds and subs, may now be replaced 
by a shorter sequence of "li" and "mul" instructions.

2) Enabling branch-likely may allow some instructions to be moved into a 
branch delay slot which previously couldn't be -- but usually these are 
duplicates of the code at the original branch target, so have little 
effect on overall code size.

3) Using -march=mips32r2 with -O1 and above (but not -Os) enables 64-bit 
alignment of functions and frequently-used branch targets (e.g. loop 
headers); whereas -march=4ksc will not do that. This will add some 
additional "nops" to the code.

Nigel
