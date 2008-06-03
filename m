Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Jun 2008 15:12:14 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:33197 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20032857AbYFCOMM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Jun 2008 15:12:12 +0100
Received: (qmail 24431 invoked by uid 1000); 3 Jun 2008 16:12:10 +0200
Date:	Tue, 3 Jun 2008 16:12:10 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: make r4k clocksource/clockevent usable in
	other codepaths
Message-ID: <20080603141210.GA21501@roarinelk.homelinux.net>
References: <20080528122838.GA5976@roarinelk.homelinux.net> <4842E2C0.1020106@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4842E2C0.1020106@ru.mvista.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19398
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

hi Sergei,

> Manuel Lauss wrote:
>> Make the r4k cp0 counter clocksource and clockevent modules
>> library code so it may be used e.g. as a fallback in case other
>> clocksources/events aren't available.
>>
>> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>>   
> [...]
>
>> diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
>> index d3bd5c5..01a4c93 100644
>> --- a/include/asm-mips/time.h
>> +++ b/include/asm-mips/time.h
>> @@ -50,27 +50,35 @@ extern int (*perf_irq)(void);
>>  /*
>>   * Initialize the calling CPU's compare interrupt as clockevent device
>>   */
>> -#ifdef CONFIG_CEVT_R4K
>> -extern int mips_clockevent_init(void);
>> +#ifdef CONFIG_CEVT_R4K_LIB
>>  extern unsigned int __weak get_c0_compare_int(void);
>> -#else
>> +extern int r4k_clockevent_init(void);
>> +#endif
>> +
>>  static inline int mips_clockevent_init(void)
>>  {
>> +#ifdef CONFIG_CEVT_R4K
>> +	return r4k_clockevent_init();
>> +#else
>>  	return -ENXIO;
>> -}
>>  #endif
>> +}
>>   /*
>>   * Initialize the count register as a clocksource
>>   */
>> -#ifdef CONFIG_CEVT_R4K
>> -extern int init_mips_clocksource(void);
>> -#else
>> +#ifdef CONFIG_CSRC_R4K_LIB
>> +extern int init_r4k_clocksource(void);
>> +#endif
>>   
>
>   Hm, does it make sense to hedge ''extern' declaration by #ifdef's?

To be honest, I didn't think about that (and I don't know the exact
semantics of 'extern' either),  I just followed the original code ;-)

MfG,
	Manuel Lauss
