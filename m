Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Apr 2005 18:41:26 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:55528 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225296AbVDERlL>; Tue, 5 Apr 2005 18:41:11 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 5 Apr 2005 13:37:01 -0400
Message-ID: <4252CDB1.9060809@timesys.com>
Date:	Tue, 05 Apr 2005 13:41:05 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: malta 4kc bus error
References: <425277B1.7080501@timesys.com> <20050405162725.GB16601@linux-mips.org> <4252C51F.6040907@timesys.com> <20050405172933.GH16601@linux-mips.org>
In-Reply-To: <20050405172933.GH16601@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2005 17:37:01.0609 (UTC) FILETIME=[13308990:01C53A06]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7598
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Tue, Apr 05, 2005 at 01:04:31PM -0400, Greg Weeks wrote:
>
>  
>
>>It appears to be turned on always now.
>>    
>>
>
>Correct.
>
>  
>
>>From arch/mips/Kconfig
>>
>>config CPU_MIPS32
>>   bool "MIPS32"
>>   select CPU_SUPPORTS_32BIT_KERNEL
>>   select CPU_HAS_PREFETCH
>>
>>I'll try turning it off directly in the memcpy function.
>>    
>>
>
>That's certainly a hack - but likely to result in the best performance.
>  
>
It's the quickest way to find out if it's the problem I'm seeing. It 
appears to be. Now, what's the best way to fix this for real?

Greg Weeks
