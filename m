Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jan 2004 00:03:25 +0000 (GMT)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:60006 "EHLO
	avtrex.com") by linux-mips.org with ESMTP id <S8225592AbUAWADY>;
	Fri, 23 Jan 2004 00:03:24 +0000
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 22 Jan 2004 16:03:20 -0800
Message-ID: <40106492.6050400@avtrex.com>
Date: Thu, 22 Jan 2004 16:02:26 -0800
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
CC: linux-mips@linux-mips.org
Subject: Re: Lossage do to #ifndef __ASSEMBLY__ in mipsregs.h
References: <40105A6F.3060009@avtrex.com> <20040122235619.GR23173@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20040122235619.GR23173@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jan 2004 00:03:20.0481 (UTC) FILETIME=[4F877910:01C3E144]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4115
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:

>David Daney wrote:
>  
>
>>I am using gcc 3.3.1 to compile the linux_2_4 kernel obtained from cvs a 
>>couple of days ago.
>>    
>>
>[snip]
>  
>
>>-#endif /* !defined (_LANGUAGE_ASSEMBLY) */
>>+#endif /* !__ASSEMBLY__ */
>>
>>#endif /* _ASM_MIPSREGS_H */
>>
>>Why the change?
>>    
>>
>
>__ASSEMBLY__ is defined by the Linux build system in order to have a
>compiler independent test.
>
I am starting to understand this.

>
>  
>
>>I will fix my local mipsregs.h so that I can continue, but it seems like 
>>the sources in CVS should be changed to allow gcc 3.3.1 to work.
>>    
>>
>
>It works here (for my configs). Your linux tree seems to be broken.
>
>
>Thiemo
>  
>
I am porting my BSP from 2.4.18 to the latest, and it seems I may have 
some Makefile incompatibility.  So I withdraw my criticism of 
defined(__ASSEMBLY__).

David Daney
