Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2005 15:52:56 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:18053 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225007AbVDLOwk>; Tue, 12 Apr 2005 15:52:40 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 12 Apr 2005 10:48:14 -0400
Message-ID: <425BE0B6.4080801@timesys.com>
Date:	Tue, 12 Apr 2005 10:52:38 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Kevin D. Kissell" <kevink@mips.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: another 4kc machine check.
References: <42553E49.7080004@timesys.com> <4256991C.4020601@timesys.com> <20050408161357.GB19166@linux-mips.org> <4256B524.2080509@timesys.com> <425AD440.5050600@timesys.com> <004a01c53ed4$dab12b00$10eca8c0@grendel>
In-Reply-To: <004a01c53ed4$dab12b00$10eca8c0@grendel>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2005 14:48:14.0812 (UTC) FILETIME=[A80A31C0:01C53F6E]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Kevin D. Kissell wrote:

>If the 4KC and 4KEC need it, so does the 4KSC (and 4KSD).
>
>  
>
Is this a reasonable thing to do though. I always hate making changes 
that work, but that I don't understand why.

Greg Weeks

>----- Original Message ----- 
>From: "Greg Weeks" <greg.weeks@timesys.com>
>To: "Ralf Baechle" <ralf@linux-mips.org>
>Cc: <linux-mips@linux-mips.org>
>Sent: Monday, April 11, 2005 21:47
>Subject: Re: another 4kc machine check.
>
>
>  
>
>>This patch appears to fix my machine check problem on the 4kc. The 4kc 
>>shouldn't need an ssnop here, but this appears to fix it.
>>
>>Greg Weeks
>>
>>    
>>
>
>
>--------------------------------------------------------------------------------
>
>
>  
>
>>--- mips-malta4kcle-basic/arch/mips/mm/tlbex.c-orig
>>+++ mips-malta4kcle-basic/arch/mips/mm/tlbex.c
>>@@ -847,7 +847,6 @@
>> 
>>  case CPU_R10000:
>>  case CPU_R12000:
>>- case CPU_4KC:
>>  case CPU_SB1:
>>  case CPU_4KSC:
>>  case CPU_20KC:
>>@@ -874,6 +873,7 @@
>>  tlbw(p);
>>  break;
>> 
>>+ case CPU_4KC:
>>  case CPU_4KEC:
>>  case CPU_24K:
>>  i_ehb(p);
>>
>>    
>>
