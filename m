Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 13:09:02 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:40978 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20021968AbXJJMIy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Oct 2007 13:08:54 +0100
Received: from internal-mx1 ([192.168.192.240] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1IfaMv-0008EJ-00; Wed, 10 Oct 2007 13:08:53 +0100
Received: from southgate.mips.com ([192.168.192.171])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1IfaMo-0001f1-00; Wed, 10 Oct 2007 13:08:46 +0100
Message-ID: <470CC0CE.9080303@mips.com>
Date:	Wed, 10 Oct 2007 13:08:46 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: IceDove 1.5.0.12 (X11/20070606)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: [SPAM?]  Re: [PATCH] mm/pg-r4k.c: Dump the generated code
References: <Pine.LNX.4.64N.0710021447470.32726@blysk.ds.pg.gda.pl> <20071002141125.GC16772@networkno.de> <20071002154918.GA11312@linux-mips.org> <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl> <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl> <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl>
X-Enigmail-Version: 0.94.2.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Maciej W. Rozycki wrote:
> On Tue, 9 Oct 2007, Franck Bui-Huu wrote:
>
>   
>>>  What would be the gain for the kernel from using "-march=4ksd" rather 
>>> than "-march=mips32r2"?
>>>
>>>       
>> It actually results in a kernel image ~30kbytes smaller for the former
>> case. It has been discussed sometimes ago on this list. I'm sorry but
>> I don't know why...
>>     
>
>  Perhaps the pipeline description for the 4KSd CPU is different from the 
> default for the MIPS32r2 ISA.  Barring a study of GCC sources, if that 
> really troubles you, you could build the same version of the kernel with 
> these options:
>
> 1. "-march=mips32r2"
>
> 2. "-march=4ksd"
>
> 3. "-march=mips32r2 -mtune=4ksd"
>
> and compare the results. 



>  I expect the results of #2 and #3 to be the same 
> and it would just back up my suggestion about keeping CPU-specific 
> optimisations separate from the CPU selection.  

Actually the -march=4ksd option will allow gcc to use of the SmartMIPS 
lwxs (indexed load) instruction, which could save a few instructions 
here and there.


> Please also note that our 
> optimisation model is for speed (-O2) rather than size (-Os), so if 
> "-mtune=4ksd" yields smaller code than "-mtune=mips32r2", it just means it 
> is safe for this CPU to shrink code where appropriate without losing 
> performance.  One obvious place for such a choice is the use of the 
> hardware multiplier vs shifts and additions where one multiplicand is a 
> constant.
>
>   

Yes, that's also worth testing.

Nigel
