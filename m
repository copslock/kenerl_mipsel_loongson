Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2009 05:15:40 +0100 (CET)
Received: from mail-pz0-f194.google.com ([209.85.222.194]:54438 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491905AbZKIEPd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 9 Nov 2009 05:15:33 +0100
Received: by pzk32 with SMTP id 32so2180265pzk.21
        for <multiple recipients>; Sun, 08 Nov 2009 20:15:23 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=ei7clv15wKKuydOKUSU0J2boP4ac4j8VxgvzOlfLMAY=;
        b=FWW3mhPRbgu0Vz0oE7MNOtC9ON7NiQCm+RNisBp93LXvEVw1XFjn351S36iiBYFYfk
         VlSF0xKi+D9O7yVuxzcSr/6J0v6SRVcYMmjZKdn9zLds8GBC9bwSk+FfTEcdOhvKveai
         6sqw6IA0+DdgmvMywk9+CG0EGEyo4xnRV+18U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=F4vAqXDDleGbCUAN57l53NWJojEAosNwNkxPcN6BtiwW+CfGmwplpLS7Z79+SoZcHD
         +nHE9SBFvWnPaC9stNi/Wm+lb7xzK8DEIxiJV+rc1ZtogIOFDxuCD6kbsKwmrZ+Dc9FZ
         JCUCZF6zE9Dnd1n3dc/W13XdTlgExYD2x+7vY=
Received: by 10.114.214.24 with SMTP id m24mr12840690wag.93.1257740122963;
        Sun, 08 Nov 2009 20:15:22 -0800 (PST)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm1725275pzk.11.2009.11.08.20.15.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 20:15:22 -0800 (PST)
Subject: Re: [PATCH -v6 02/13] tracing: add mips_timecounter_read() for MIPS
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-kernel@vger.kernel.org,
	Frederic Weisbecker <fweisbec@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
In-Reply-To: <3f47087b70a965fd679b17a59521671296457df1.1256569489.git.wuzhangjin@gmail.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
	 <747deea2f18d5ccffe842df95a9dd1c86251a958.1256569489.git.wuzhangjin@gmail.com>
	 <3f47087b70a965fd679b17a59521671296457df1.1256569489.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:	Mon, 09 Nov 2009 12:15:16 +0800
Message-ID: <1257740116.3451.14.camel@falcon.domain.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf, 

Could you please give some feedback on this patch?

Really looking forward to your feedback and then resend this patchset
out ;)

Thanks & Regards,
	Wu Zhangjin

On Mon, 2009-10-26 at 23:13 +0800, Wu Zhangjin wrote:
> This patch add a new function: mips_timecounter_read() to get high
> precision timestamp without extra lock.
> 
> It is based on the clock counter register and the
> timecounter/cyclecounter abstraction layer of kernel.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/include/asm/time.h |   19 +++++++++++++++++++
>  arch/mips/kernel/csrc-r4k.c  |   41 +++++++++++++++++++++++++++++++++++++++++
>  arch/mips/kernel/time.c      |    2 ++
>  3 files changed, 62 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
> index df6a430..b8af7fa 100644
> --- a/arch/mips/include/asm/time.h
> +++ b/arch/mips/include/asm/time.h
> @@ -73,8 +73,18 @@ static inline int mips_clockevent_init(void)
>   */
>  #ifdef CONFIG_CSRC_R4K_LIB
>  extern int init_r4k_clocksource(void);
> +extern int init_r4k_timecounter(void);
> +extern u64 r4k_timecounter_read(void);
>  #endif
>  
> +static inline u64 mips_timecounter_read(void)
> +{
> +#ifdef CONFIG_CSRC_R4K
> +	return r4k_timecounter_read();
> +#else
> +	return sched_clock();
> +#endif
> +}
>  static inline int init_mips_clocksource(void)
>  {
>  #ifdef CONFIG_CSRC_R4K
> @@ -84,6 +94,15 @@ static inline int init_mips_clocksource(void)
>  #endif
>  }
>  
> +static inline int init_mips_timecounter(void)
> +{
> +#ifdef CONFIG_CSRC_R4K
> +	return init_r4k_timecounter();
> +#else
> +	return 0;
> +#endif
> +}
> +
>  extern void clocksource_set_clock(struct clocksource *cs, unsigned int clock);
>  extern void clockevent_set_clock(struct clock_event_device *cd,
>  		unsigned int clock);
> diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
> index e95a3cd..4e7705f 100644
> --- a/arch/mips/kernel/csrc-r4k.c
> +++ b/arch/mips/kernel/csrc-r4k.c
> @@ -7,6 +7,7 @@
>   */
>  #include <linux/clocksource.h>
>  #include <linux/init.h>
> +#include <linux/sched.h>
>  
>  #include <asm/time.h>
>  
> @@ -36,3 +37,43 @@ int __init init_r4k_clocksource(void)
>  
>  	return 0;
>  }
> +
> +static struct timecounter r4k_tc = {
> +	.cc = NULL,
> +};
> +
> +static cycle_t r4k_cc_read(const struct cyclecounter *cc)
> +{
> +	return read_c0_count();
> +}
> +
> +static struct cyclecounter r4k_cc = {
> +	.read = r4k_cc_read,
> +	.mask = CLOCKSOURCE_MASK(32),
> +	.shift = 32,
> +};
> +
> +int __init init_r4k_timecounter(void)
> +{
> +	if (!cpu_has_counter || !mips_hpt_frequency)
> +		return -ENXIO;
> +
> +	r4k_cc.mult = div_sc((unsigned long)mips_hpt_frequency, NSEC_PER_SEC,
> +			32);
> +
> +	timecounter_init(&r4k_tc, &r4k_cc, sched_clock());
> +
> +	return 0;
> +}
> +
> +u64 r4k_timecounter_read(void)
> +{
> +	u64 clock;
> +
> +	if (r4k_tc.cc != NULL)
> +		clock = timecounter_read(&r4k_tc);
> +	else
> +		clock = sched_clock();
> +
> +	return clock;
> +}
> diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
> index 1f467d5..e38cca1 100644
> --- a/arch/mips/kernel/time.c
> +++ b/arch/mips/kernel/time.c
> @@ -156,4 +156,6 @@ void __init time_init(void)
>  
>  	if (!mips_clockevent_init() || !cpu_has_mfc0_count_bug())
>  		init_mips_clocksource();
> +	if (!cpu_has_mfc0_count_bug())
> +		init_mips_timecounter();
>  }
