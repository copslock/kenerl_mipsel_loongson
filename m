Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 01:27:31 +0100 (CET)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:41643 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492989AbZJZA1Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Oct 2009 01:27:24 +0100
Received: by fxm25 with SMTP id 25so11985458fxm.0
        for <multiple recipients>; Sun, 25 Oct 2009 17:27:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rUCtjA/6UZHP8vqAYJb7Zk514dMb5zV/xtoqppgh17c=;
        b=kafyxHC7tW5dUf0B+qt2Lea+ommF3tUf9NllzJfztTLsAAoMn0veEIpE5Pb0aOUQdA
         LdFTkrlUcNGugmFPI/1rNeUaGjkvd5FyicBOwNJ0oYHg0xBnCs0kv4E146ZvBSIPHeZO
         5fYf1b4mfuaR9AGRzRoiFMohfsVlTqPhwoDv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JqTwmpTpYvwrsfeH9PYGIi3FC5anL3wqXPdOJ0B6rqnI/AJNo3zU8DNqO4BsUBLb7k
         xjSh/o0I/YjuuRJtAV7hX7KxMOhv95d/tZJudNiU5bE9BAlOKO55tx4F0z676csx2G1Z
         Udjh7Jk7fzgSmpH6SyudQfPyU8Ut7qZdimqF4=
MIME-Version: 1.0
Received: by 10.223.143.73 with SMTP id t9mr2531565fau.89.1256516838356; Sun, 
	25 Oct 2009 17:27:18 -0700 (PDT)
In-Reply-To: <49b3c441a57f4db423732f81432a3450ccb3240e.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
	 <028867b99ec532b84963a35e7d552becc783cafc.1256483735.git.wuzhangjin@gmail.com>
	 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
	 <3e0c2d7d8b8f196a8153beb41ea7f3cbf42b3d84.1256483735.git.wuzhangjin@gmail.com>
	 <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com>
	 <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com>
	 <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com>
	 <cover.1256483735.git.wuzhangjin@gmail.com>
	 <6140dd8f4e1783e5ac30977cf008bb98e4698322.1256483735.git.wuzhangjin@gmail.com>
	 <49b3c441a57f4db423732f81432a3450ccb3240e.1256483735.git.wuzhangjin@gmail.com>
Date:	Mon, 26 Oct 2009 01:27:18 +0100
Message-ID: <c62985530910251727o23beafcco539870e4b2f84637@mail.gmail.com>
Subject: Re: [PATCH -v5 08/11] tracing: not trace mips_timecounter_init() in 
	MIPS
From:	Frederic Weisbecker <fweisbec@gmail.com>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <fweisbec@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24497
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fweisbec@gmail.com
Precedence: bulk
X-list: linux-mips

2009/10/25 Wu Zhangjin <wuzhangjin@gmail.com>:
> -static inline u64 mips_timecounter_read(void)
> +static inline u64 notrace mips_timecounter_read(void)


You don't need to set notrace functions, unless their addresses
are referenced somewhere, which unfortunately might happen
for some functions but this is rare.


>  {
>  #ifdef CONFIG_CSRC_R4K
>        return r4k_timecounter_read();
> diff --git a/arch/mips/kernel/csrc-r4k.c b/arch/mips/kernel/csrc-r4k.c
> index 4e7705f..0690bea 100644
> --- a/arch/mips/kernel/csrc-r4k.c
> +++ b/arch/mips/kernel/csrc-r4k.c
> @@ -42,7 +42,7 @@ static struct timecounter r4k_tc = {
>        .cc = NULL,
>  };
>
> -static cycle_t r4k_cc_read(const struct cyclecounter *cc)
> +static cycle_t notrace r4k_cc_read(const struct cyclecounter *cc)
>  {
>        return read_c0_count();
>  }
> @@ -66,7 +66,7 @@ int __init init_r4k_timecounter(void)
>        return 0;
>  }
>
> -u64 r4k_timecounter_read(void)
> +u64 notrace r4k_timecounter_read(void)
>  {
>        u64 clock;
>
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index 83d2fbd..2a02992 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -73,7 +73,7 @@ struct timecounter {
>  * XXX - This could use some mult_lxl_ll() asm optimization. Same code
>  * as in cyc2ns, but with unsigned result.
>  */
> -static inline u64 cyclecounter_cyc2ns(const struct cyclecounter *cc,
> +static inline u64 notrace cyclecounter_cyc2ns(const struct cyclecounter

ditto here.


*cc,
>                                      cycle_t cycles)
>  {
>        u64 ret = (u64)cycles;
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 5e18c6a..9ce9d02 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -52,7 +52,7 @@ EXPORT_SYMBOL(timecounter_init);
>  * The first call to this function for a new time counter initializes
>  * the time tracking and returns an undefined result.
>  */
> -static u64 timecounter_read_delta(struct timecounter *tc)
> +static u64 notrace timecounter_read_delta(struct timecounter *tc)
>  {
>        cycle_t cycle_now, cycle_delta;
>        u64 ns_offset;
> @@ -72,7 +72,7 @@ static u64 timecounter_read_delta(struct timecounter


Hmm yeah this is not very nice to do that in core functions because
of a specific arch problem.
At least you have __notrace_funcgraph, this is a notrace
that only applies if CONFIG_FUNCTION_GRAPH_TRACER
so that it's still traceable by the function tracer in this case.

But I would rather see a __mips_notrace on these two core functions.
