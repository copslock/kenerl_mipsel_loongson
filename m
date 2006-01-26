Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 08:20:30 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:51650 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133467AbWAZIUL
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 08:20:11 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0Q8OSHJ019387;
	Thu, 26 Jan 2006 00:24:28 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k0Q8OQYr013364;
	Thu, 26 Jan 2006 00:24:27 -0800 (PST)
Message-ID: <43D887BB.3030906@mips.com>
Date:	Thu, 26 Jan 2006 09:26:35 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>	 <20060125124738.GA3454@linux-mips.org>	 <cda58cb80601250534r5f464fd1v@mail.gmail.com>	 <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org>	 <cda58cb80601250632r3e8f7b9en@mail.gmail.com>	 <20060125150404.GF3454@linux-mips.org>	 <cda58cb80601251003m6ba4379w@mail.gmail.com>	 <43D7C050.5090607@mips.com> <cda58cb80601260011r6136c3fq@mail.gmail.com>
In-Reply-To: <cda58cb80601260011r6136c3fq@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Franck wrote:
> 2006/1/25, Kevin D. Kissell <kevink@mips.com>:
>> Franck wrote:
>>> OK. So the patch I sent to you 3 months ago that adds support for
>>> 4ks[cd] cpu and smartmips extension is wrong. It added new
>>> CONFIG_CPU_4KS[CD] macro whereas it must have used MIPS32_R[12] macros
>>> like Kevin suggested...
>> Not really.  As we discussed at the time, the 4KSc is a superset of
>> MIPS32 which includes some, but not all MIPS32R2 features (plus other
>> stuff), and the 4KSd is a strict superset of MIPS32R2.  So some additional
>> information is required to express the desired support.  I was just pointing
>> out, in the case of the SWAB optimizations, that there was no need to invent
>> yet another way of describing MIPS32R2.
> 
> Let's say that the 4KSC has "wsbh" instruction which is part of
> MIPS32R2 instructrion set (I haven't checked it). The question is how
> the 4KSC would use the SWAB optimizations since it doesn't define
> CONFIG_CPU_MIPS32_R2  ? The 4KSC might not be the only one case...

The 4KSc happens not to have the MIPS32R2 WSBH (is that pronounced
"wasabi"? ;o) instruction, but it does have the MIPS32R2 ROTR, because
it's part of the SmartMIPS ASE.  Our options here include:

* Say "to heck with it" and deny the 4KSc use of the ROTR, and stay
   with a "#ifdef CONFIG_CPU_MIPS32R2" conditional.

* Define CONFIG_CPU_MIPS4KSC as an additional oddball CPU flag, and
   make it "#if defined(CONFIG_CPU_MIPS32R2) || defined(CONFIG_CPU_MIPS4KSC)

* Have an ASE-support flag, CONFIG_CPU_SMARTMIPS, which would cover both
   the 4KSc and 4KSd.  In that case code using ROTR could be conditional on
   #if defined(CPU_CONFIG_MIPS32R2) || defined(CONFIG_CPU_SMARTMIPS).

I personally think that the third option is the cleanest and most conceptually
correct, but I'm not the guy operationally responsible for maintaining
that code.

		Regards,

		Kevin K.
