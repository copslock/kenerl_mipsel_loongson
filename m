Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Dec 2004 03:28:28 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:12537 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225321AbULPD2Y>; Thu, 16 Dec 2004 03:28:24 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 42EBF1877B; Wed, 15 Dec 2004 19:28:12 -0800 (PST)
Message-ID: <41C100CB.2070000@mvista.com>
Date: Wed, 15 Dec 2004 19:28:11 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Avoid compile warnings on Sibyte using 2.6.10-rc3
References: <20041215235632.GA11386@prometheus.mvista.com> <41C0FCFD.9010603@realitydiluted.com>
In-Reply-To: <41C0FCFD.9010603@realitydiluted.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6689
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Steven J. Hill wrote:

> Manish Lachwani wrote:
>
>>
>> The attached patch is needed to prevent the compilation warnings that
>> occur when using 2.6.10-rc3 on Sibyte. Please review
>
> I don't ever see any warning associated with this. Can you provide a
> little more information?
>
> -Steve
>
Hi Steve,

When did you last sync with CVS?  There was a change introduced : 
http://www.linux-mips.org/cvsweb/linux/include/asm-mips/mach-sibyte/cpu-feature-overrides.h.diff?r1=1.1&r2=1.2

There is another #define in include/asm-mips/

#ifdef CONFIG_SMP
#ifndef cpu_icache_snoops_remote_store
#define cpu_icache_snoops_remote_store  (cpu_data[0].icache.flags & 
MIPS_IC_SNOOPS_REMOTE)
#endif
#else
#define cpu_icache_snoops_remote_store  1
#endif

And if running Sibyte in UP mode, cpu_icache_snoops_remote_store is 
redefined

Thanks
Manish
