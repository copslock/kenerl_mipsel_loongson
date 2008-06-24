Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2008 22:42:12 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:63909 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20042175AbYFXVmJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jun 2008 22:42:09 +0100
Received: (qmail 3573 invoked by uid 1000); 24 Jun 2008 23:42:06 +0200
Date:	Tue, 24 Jun 2008 23:42:06 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [RFC PATCH 1/7] Alchemy: remove cpu_table.
Message-ID: <20080624214206.GB3376@roarinelk.homelinux.net>
References: <20080624200810.GA2463@roarinelk.homelinux.net> <20080624200919.GB2463@roarinelk.homelinux.net> <48616162.6080400@ru.mvista.com> <20080624212630.GA3376@roarinelk.homelinux.net> <48616910.1020002@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48616910.1020002@ru.mvista.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Hello.

> Manuel Lauss wrote:
>
>>>> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
>>>> index 2709675..bb22649 100644
>>>> --- a/arch/mips/mm/c-r4k.c
>>>> +++ b/arch/mips/mm/c-r4k.c
>>>>         
>>> [...]
>>>
>>>     
>>>> @@ -1287,20 +1262,18 @@ static void __cpuinit coherency_setup(void)
>>>>  	case CPU_R4400MC:
>>>>  		clear_c0_config(CONF_CU);
>>>>  		break;
>>>> -	/*
>>>> -	 * We need to catch the early Alchemy SOCs with
>>>> -	 * the write-only co_config.od bit and set it back to one...
>>>> -	 */
>>>> -	case CPU_AU1000: /* rev. DA, HA, HB */
>>>> -	case CPU_AU1100: /* rev. AB, BA, BC ?? */
>>>> -	case CPU_AU1500: /* rev. AB */
>>>> -		au1x00_fixup_config_od();
>>>> -		break;
>>>>   	case PRID_IMP_PR4450:
>>>>  		nxp_pr4450_fixup_config();
>>>>  		break;
>>>>  	}
>>>> +
>>>> +#ifdef CONFIG_MACH_ALCHEMY
>>>> +	{
>>>> +		extern void au1x00_fixup_config_od(void);
>>>> +		au1x00_fixup_config_od();
>>>> +	}
>>>> +#endif
>>>>  }
>>>>         
>>>   I've been thru this before. Ralf will hardly accept #ifdef'ery and 
>>> extern in this file. That's why we have what we have now. :-)
>>>     
>>
>> I believe it can be removed entirely from c-r4k.c, the Alchemy
>> plat_mem_setup and resume code run it too (and earlier).
>>   
>
>   You cleraly didn't get it. ;-)
>   It's here because what is written earlier was *discarded* while doing the 
> coherency setup (remember, the OD bit is write only, so you can't just RMW 
> the Config reg).
> That lead to some crap with USB on Au1500 in particular, IIRC.

Ah ok.  I'll leave c-r4k untouched then. Thanks.

	Manuel Lauss
