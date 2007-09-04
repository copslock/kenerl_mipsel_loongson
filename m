Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2007 13:06:31 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:10759 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20024700AbXIDMGX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2007 13:06:23 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1ISXAd-0001qo-00; Tue, 04 Sep 2007 13:06:15 +0100
Received: from ukcvpn55.mips-uk.com ([192.168.193.55])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1ISXAS-00025z-00; Tue, 04 Sep 2007 13:06:04 +0100
Message-ID: <46DD49B9.2090306@mips.com>
Date:	Tue, 04 Sep 2007 13:04:09 +0100
From:	Nigel Stephens <nigel@mips.com>
User-Agent: IceDove 1.5.0.12 (X11/20070607)
MIME-Version: 1.0
To:	Thiemo Seufer <ths@networkno.de>
CC:	"Kevin D. Kissell" <kevink@mips.com>,
	yshi <yang.shi@windriver.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] malta4kec hang in calibrate_delay fix
References: <46DD1CD1.5040306@windriver.com> <006901c7eeda$d8049a50$10eca8c0@grendel> <1188901951.4106.16.camel@yshi.CORP> <006f01c7eee5$bbe77c60$10eca8c0@grendel> <20070904115527.GA848@networkno.de>
In-Reply-To: <20070904115527.GA848@networkno.de>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Thiemo Seufer wrote:
> Kevin D. Kissell wrote:
>   
>>> ??? 2007-09-04?????? 12:03 +0200???Kevin D. Kissell?????????
>>>       
>>>> The 4KEc is a MIPS32 Release 2 processor, for which the implementation
>>>> of the Cause.TI bit (bit 30) is required.  You may have a defective board
>>>> or a bad FPGA bitfile.  Please work with your support contacts at MIPS
>>>> to verify that this is not the case.  It may also be that there's something more
>>>> subtle going on in the interrupt processing, such that the Cause.TI bit is being
>>>> cleared before it can be sampled by the code you've changed.  But while the
>>>> patch below presumably solves the symptoms of your problem, I really
>>>> don't think that a kernel hack based on detecting CoreFPA3 is an appropriate
>>>> solution.  I work every day with Malta/CoreFPGA3 bitfiles and have not
>>>> seen Cause.TI fail to function in any of the Release 2 core bitfiles I've used.
>>>>         
>>> My board's core is Release 1 core. So Cause.TI bit always is zero. Maybe
>>> I need update this patch to reflect this, i.e add #ifdef to distinguish
>>> Release 1 and Release 2. Thanks.
>>>       
>> In that case, your core is a 4Kc and not a 4KEc.
>>     
>
> Not quite true, early revisions of the 4KEc were only release 1. This
> seems to be a bug in arch/mips/cpu-probe.c:
>
> static inline void cpu_probe_mips(struct cpuinfo_mips *c)
> {
>         decode_configs(c);
>         switch (c->processor_id & 0xff00) {
>         case PRID_IMP_4KC:
>                 c->cputype = CPU_4KC;
>                 break;
>         case PRID_IMP_4KEC:
>                 c->cputype = CPU_4KEC;
>                 break;
>         case PRID_IMP_4KECR2:
>                 c->cputype = CPU_4KEC;
>                 break;
> 	...
>
> The type for PRID_IMP_4KEC should be CPU_4KC.
>
>   

Maybe the probing code should read the ISA revision level from the AR 
bits (12:10) of the Config0 register to figure out which revision of the 
ISA is implemented.

Nigel
