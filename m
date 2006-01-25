Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 18:09:53 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:22463 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133463AbWAYSJf
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 18:09:35 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0PIDi6B015312;
	Wed, 25 Jan 2006 10:13:45 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k0PIDcYr027273;
	Wed, 25 Jan 2006 10:13:41 -0800 (PST)
Message-ID: <43D7C050.5090607@mips.com>
Date:	Wed, 25 Jan 2006 19:15:44 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>	 <20060125124738.GA3454@linux-mips.org>	 <cda58cb80601250534r5f464fd1v@mail.gmail.com>	 <43D78725.6050300@mips.com> <20060125141424.GE3454@linux-mips.org>	 <cda58cb80601250632r3e8f7b9en@mail.gmail.com>	 <20060125150404.GF3454@linux-mips.org> <cda58cb80601251003m6ba4379w@mail.gmail.com>
In-Reply-To: <cda58cb80601251003m6ba4379w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10149
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Franck wrote:
> 2006/1/25, Ralf Baechle <ralf@linux-mips.org>:
>> On Wed, Jan 25, 2006 at 03:32:22PM +0100, Franck wrote:
>>
>>>> We have CPU_MIPS32_R1, CPU_MIPS32_R2, CPU_MIPS64_R1, CPU_MIPS64_R2.
>>>> Based on those we also define CPU_MIPS32, CPU_MIPS64, CPU_MIPSR1,
>>>> and CPU_MIPSR2 as short cuts.
>>>>
>>> hm I should have missed something, but what about CPUs which have
>>> their own CPU_XXX (different form CPU_MIPS32_R[12]) and which are a
>>> mips32-r2 compliant for example ? (I'm thinking of 4KSD for example)
>> The 4KSD is still a MIPS32 processor - just one with an ASE.
>>
>> The real bug here - and what's causing your confusion - is that the
>> processor configuration is mixing up all the architecture variants
>> (MIPS I - IV, MIPS32 and MIPS64 R1/R2, weirdo variants ...) and the
>> processor types.  Example: 4K, 4KE, 24K, 24KE, 34K, AMD Alchemy are all
>> MIPS32 (either R1 or R2).  R4000, R4400, R4600 are all MIPS III.  But
>> what we actually offer in the processor configuration is R4X00, MIPS32_R1,
>>
> 
> OK. So the patch I sent to you 3 months ago that adds support for
> 4ks[cd] cpu and smartmips extension is wrong. It added new
> CONFIG_CPU_4KS[CD] macro whereas it must have used MIPS32_R[12] macros
> like Kevin suggested...

Not really.  As we discussed at the time, the 4KSc is a superset of
MIPS32 which includes some, but not all MIPS32R2 features (plus other
stuff), and the 4KSd is a strict superset of MIPS32R2.  So some additional
information is required to express the desired support.  I was just pointing
out, in the case of the SWAB optimizations, that there was no need to invent
yet another way of describing MIPS32R2.

	Regards,

	Kevin K.
