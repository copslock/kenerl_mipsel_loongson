Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 13:41:46 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:39624 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133414AbWA0Nl3
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 13:41:29 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0RDjtAa027084;
	Fri, 27 Jan 2006 05:45:55 -0800 (PST)
Received: from olympia.mips.com (olympia [192.168.192.128])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k0RDjrYr013405;
	Fri, 27 Jan 2006 05:45:53 -0800 (PST)
Received: from highbury.mips.com ([192.168.192.236])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1F2TvE-0006wm-00; Fri, 27 Jan 2006 13:45:52 +0000
Message-ID: <43DA240F.5070301@mips.com>
Date:	Fri, 27 Jan 2006 13:45:51 +0000
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Debian Thunderbird 1.0.2 (X11/20050817)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
CC:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>	 <cda58cb80601251003m6ba4379w@mail.gmail.com>	 <43D7C050.5090607@mips.com>	 <cda58cb80601260702wf781e70l@mail.gmail.com>	 <005101c6228c$6ebfb0a0$10eca8c0@grendel> <43D8F000.9010106@mips.com>	 <cda58cb80601260831i61167787g@mail.gmail.com>	 <43D8FF16.40107@mips.com>	 <cda58cb80601261002w6eb02249k@mail.gmail.com>	 <43D93025.9040800@mips.com> <cda58cb80601270103t1419117cq@mail.gmail.com>
In-Reply-To: <cda58cb80601270103t1419117cq@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.777,
	required 4, AWL, BAYES_00)
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10209
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
>>You could, but why not stick with -march=4ksd if that's your CPU of
>>choice? It appears to result in  marginally smaller code even when using
>>-Os, and should have (slightly) better performance than a generic
>>mips32r2 kernel?
>>
>>    
>>
>
>Just to avoid a new CPU_4KSD definition in the kernel code as
>suggested by Kevin. Basically all mips32r2 specific code is the same
>as 4ksd specific code (except the code that deals with SmartMIPS
>extension). So it can use CONFIG_CPU_MIPS32_R2 macro.
>

Not that I'm a Linux hacker, but aren't those separate things? Can't you 
compile with -march=4ksd to get the CPU-specific compiler optimisations, 
but then use the more generic CONFIG_CPU_MIPSR2 and/or 
CONFIG_CPU_SMARTMIPS to select the appropriate code inside the kernel 
source (i.e. no need for CONFIG_CPU_4KSD)?

Nigel
