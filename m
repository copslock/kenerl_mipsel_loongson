Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 20:18:43 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:1276 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225388AbULBUSh>; Thu, 2 Dec 2004 20:18:37 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id AC9DC1869C; Thu,  2 Dec 2004 12:18:35 -0800 (PST)
Message-ID: <41AF789B.3030303@mvista.com>
Date: Thu, 02 Dec 2004 12:18:35 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] Broadcom SWARM IDE in 2.6
References: <20041130230022.GA17202@prometheus.mvista.com> <41AE9390.80705@realitydiluted.com>
In-Reply-To: <41AE9390.80705@realitydiluted.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hi Steve,

"ide_init_default_irq" is defined in include/linux/ide.h and in
include/asm-mips/mach-generic/ide.h.

include/asm-mips/mach-generic/ide.h and include/asm-i386/ide.h are 
replicas. So, this compiler warning should appear on other platforms as 
well.

I have sent an email out to Jeff Garzik to understand why 
"ide_init_default_irq" is redefined

Thanks
Manish Lachwani

Steven J. Hill wrote:
> Manish Lachwani wrote:
> 
>>
>> I had sent an incomplete patch before. Please try out this new patch, 
>> attached.
>> Let me know if it works
>>
> Manish,
> 
> This patch worked, however you need to fix a compiler warning before I am
> willing to commit it. Please get rid of the warning shown below and submit
> a new patch. Thanks!
> 
> -Steve
> 
> *******************
> 
> CC      drivers/ide/ide-generic.o
> In file included from drivers/ide/ide-generic.c:13:
> include/linux/ide.h:277:1: warning: "ide_init_default_irq" redefined
> In file included from include/asm/ide.h:11,
>                  from include/linux/ide.h:271,
>                  from drivers/ide/ide-generic.c:13:
> include/asm-mips/mach-generic/ide.h:64:1: warning: this is the location 
> of the previous definition
