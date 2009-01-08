Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2009 21:25:57 +0000 (GMT)
Received: from relay1.sgi.com ([192.48.179.29]:29374 "EHLO relay.sgi.com")
	by ftp.linux-mips.org with ESMTP id S21365035AbZAHVZz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Jan 2009 21:25:55 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [150.166.39.100])
	by relay1.corp.sgi.com (Postfix) with ESMTP id AB64F8F80A5;
	Thu,  8 Jan 2009 13:25:48 -0800 (PST)
Received: from [134.15.31.35] (vpn-2-travis.corp.sgi.com [134.15.31.35])
	by cthulhu.engr.sgi.com (8.12.10/8.12.10/SuSE Linux 0.7) with ESMTP id n08LPlF5029428;
	Thu, 8 Jan 2009 13:25:47 -0800
Message-ID: <49666F5B.2090605@sgi.com>
Date:	Thu, 08 Jan 2009 13:25:47 -0800
From:	Mike Travis <travis@sgi.com>
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	Linus Torvalds <torvalds@linux-foundation.org>,
	rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] cpumask fallout: Initialize irq_default_affinity earlier.
References: <1231446081-8448-1-git-send-email-ddaney@caviumnetworks.com> <alpine.LFD.2.00.0901081227360.3283@localhost.localdomain> <496666CE.3050205@caviumnetworks.com>
In-Reply-To: <496666CE.3050205@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <travis@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: travis@sgi.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> Linus Torvalds wrote:
> [...]
>> In fact, I think it already is a no-op in the UP case, and you can
>> literally just do
>>
>>     static inline void __init init_irq_default_affinity(void)
>>     {
>>          alloc_cpumask_var(&irq_default_affinity, GFP_KERNEL);
>>          cpumask_setall(irq_default_affinity);
>>     }
>>
>> and be done with it. I think it should all compile away to nothing if
>> CONFIG_SMP isn't set.
> 
> The 'inline' seems gratuitous to me.  Since it is static GCC should do
> the Right Thing.  However since you suggested it, I am testing it that way.
> 
> David Daney

It will probably need to be:

	alloc_bootmem_cpumask_var(&irq_default_affinity);

I am testing it on x86_64 as well.

Thanks,
Mike
