Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Mar 2004 16:09:44 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:41454 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225438AbUCSQJn>;
	Fri, 19 Mar 2004 16:09:43 +0000
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id IAA08953;
	Fri, 19 Mar 2004 08:09:38 -0800
Message-ID: <405B1B47.80100@mvista.com>
Date: Fri, 19 Mar 2004 08:09:43 -0800
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: erras stefan <stefan.erras@dallmeier-electronic.com>
CC: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: AW: PMON documentation
References: <765921A8173EC145948ACBAA0480F67E2A1D24@server10.dallmeier.de>
In-Reply-To: <765921A8173EC145948ACBAA0480F67E2A1D24@server10.dallmeier.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4595
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

erras stefan wrote:

>I'm using PMON version 0.0291 (This says the boot sequence via serial port)
>I have to do modifications in the section for the RTC. Where can I find the code for this modifications.
>We have problems with our RTC because it does not work very well with the actual initialization.
>I'm searching for a good manual for the used assembler in PMON. Can anybody help me?
>  
>
Which board is this? I think we may still have a version of PMON for the 
ITE 8172 board somewhere.
As far as docs, I don't have any.

Pete

>Stefan
>
>
>-----Ursprüngliche Nachricht-----
>Von: Pete Popov [mailto:ppopov@mvista.com] 
>Gesendet: Donnerstag, 18. März 2004 21:57
>An: erras stefan
>Cc: Linux MIPS mailing list
>Betreff: Re: PMON documentation
>
>
>On Thu, 2004-03-18 at 05:09, erras stefan wrote:
>  
>
>>Hello,
>>I'm working on a development project with a RM5231 MIPS processor. I 
>>have to modify some things in the PMON bootloader source-code. Can 
>>anybody give me an advice where I can find PMON source code 
>>documentation or a detailed explanation how PMON works. Which files do 
>>I have to look into, when I would like to modify the bootloader.
>>Maybe I can use another bootloader. Which alternatives do I have. I do
>>not need the debug functionality of PMON. Maybe there is an easier to
>>understand and modify bootloader.
>>
>>Thank you all in advance for your help!
>>    
>>
>
>I think there were too many versions of "PMON" floating out there. I'm not sure which one you have.
>
>If you are starting from scratch, take a look at uboot. I think that would be a much better alternative.
>
>Pete
>
>
>  
>
