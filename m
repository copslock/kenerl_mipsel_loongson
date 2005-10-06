Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 19:52:46 +0100 (BST)
Received: from mail.timesys.com ([65.117.135.102]:7491 "EHLO
	exchange.timesys.com") by ftp.linux-mips.org with ESMTP
	id S8133558AbVJFSw3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 19:52:29 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 6 Oct 2005 14:49:49 -0400
Message-ID: <43457266.3090208@timesys.com>
Date:	Thu, 06 Oct 2005 14:52:22 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org, "Cooper, John" <john.cooper@timesys.com>
Subject: Re: PREEMPT
References: <43456EA9.8020209@timesys.com> <20051006184656.GA12173@linux-mips.org>
In-Reply-To: <20051006184656.GA12173@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2005 18:49:49.0953 (UTC) FILETIME=[BAEEEF10:01C5CAA6]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Thu, Oct 06, 2005 at 02:36:25PM -0400, Greg Weeks wrote:
>
>  
>
>>Does anyone know of any current problems with CONFIG_PREEMPT on a 4kc 
>>malta board? We're seeing some oddness in the floating point emulator 
>>with PREEMPT_RT and wondered if it was in our RT code, or if it's from 
>>the base kernel code.
>>    
>>
>
>No known problem in current problems in that area.
>
> 
>
I'd remembered some problems ages ago, but had thought they'd been 
fixed. John was just picking my brain about it so I thought I'd ask to 
be sure.

Greg W
