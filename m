Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2005 19:26:32 +0000 (GMT)
Received: from 63-207-7-10.ded.pacbell.net ([IPv6:::ffff:63.207.7.10]:47237
	"EHLO cassini.enmediainc.com") by linux-mips.org with ESMTP
	id <S8229662AbVCYT0Q>; Fri, 25 Mar 2005 19:26:16 +0000
Received: from [127.0.0.1] (unknown [192.168.10.203])
	by cassini.enmediainc.com (Postfix) with ESMTP id 45E4E25C95F
	for <linux-mips@linux-mips.org>; Fri, 25 Mar 2005 11:26:07 -0800 (PST)
Message-ID: <42446555.6090005@c2micro.com>
Date:	Fri, 25 Mar 2005 11:24:05 -0800
From:	Ed Martini <martini@c2micro.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Observations on LLSC and SMP
References: <4230DB4C.7090103@c2micro.com> <20050314110101.GF7759@linux-mips.org> <423763B9.2000907@c2micro.com> <20050316120647.GB8563@linux-mips.org>
In-Reply-To: <20050316120647.GB8563@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <martini@c2micro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martini@c2micro.com
Precedence: bulk
X-list: linux-mips

In include/asm-mips/ atomic.h, bitops.h and system.h there are a bunch 
of inline functions which contain this logic:

        if (cpu_has_llsc && R10000_LLSC_WAR) {
                __asm__ (stuff)
        } else if (cpu_has_llsc) {
                __asm__ (other stuff)
        } else {
                C lang stuff;
        }

My two observations relate to both code size and runtime performance.  
These observations don't affect my situation, so I'm not inclined to 
spend a bunch of time on it, but maybe someone else is interested.  This 
should be especially interesting since these inline functions are used 
all over the kernel, so it might actually make a marginally significant 
difference.

I suppose there's a reason this code is the way it is.  If so, feel free 
to ignore me or flame away.

1. If the first part of the if were an ifdef instead it would result in 
a code size reduction as well as a runtime performance gain.

2. In atomic.h the "C lang stuff" is wrapped with a spinlock.  In the 
SMP case the spinlock will result in code that contains ll and sc 
instructions, so I infer that there are no SMP system configs that use 
CPUs that don't have the ll and sc instructions. 

Paranoid version:
-----
        if (cpu_has_llsc) {
#ifdef R10000_LLSC_WAR
                __asm__ (stuff)
#else
                __asm__ (other stuff)
#endif
        } else {
#ifdef CONFIG_SMP
                panic("SMP on CPUs with no LLSC is broken\n");
#else
                C lang stuff;
#endif
        }
-----
Most efficient version:
-----
#ifndef CONFIG_SMP
        if (cpu_has_llsc)
#endif
        {
#ifdef R10000_LLSC_WAR
                __asm__ (stuff)
#else
                __asm__ (other stuff)
#endif
        }
-----
