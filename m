Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2005 22:48:50 +0000 (GMT)
Received: from 63-207-7-10.ded.pacbell.net ([IPv6:::ffff:63.207.7.10]:23727
	"EHLO cassini.enmediainc.com") by linux-mips.org with ESMTP
	id <S8229678AbVCYWsf>; Fri, 25 Mar 2005 22:48:35 +0000
Received: from [127.0.0.1] (unknown [192.168.10.203])
	by cassini.enmediainc.com (Postfix) with ESMTP
	id D128F25C95F; Fri, 25 Mar 2005 14:48:06 -0800 (PST)
Message-ID: <424494AC.7020407@c2micro.com>
Date:	Fri, 25 Mar 2005 14:46:04 -0800
From:	Ed Martini <martini@c2micro.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Observations on LLSC and SMP
References: <4230DB4C.7090103@c2micro.com> <20050314110101.GF7759@linux-mips.org> <423763B9.2000907@c2micro.com> <20050316120647.GB8563@linux-mips.org> <42446555.6090005@c2micro.com> <20050325193759.GA23046@nevyn.them.org>
In-Reply-To: <20050325193759.GA23046@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <martini@c2micro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martini@c2micro.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:

>On Fri, Mar 25, 2005 at 11:24:05AM -0800, Ed Martini wrote:
>  
>
>>1. If the first part of the if were an ifdef instead it would result in 
>>a code size reduction as well as a runtime performance gain.
>>    
>>
>
>You should spend a little time playing with an optimizing compiler. 
>They're capable of working out when a condition will always be false.
>  
>
Yes, but in the case where R10000_LLSC_WAR is true, but cpu_has_llsc 
returns false there are still two wasted tests, and two blocks of code 
that the compiler can't optimize out.
