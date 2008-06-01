Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Jun 2008 19:02:14 +0100 (BST)
Received: from p549F48FC.dip.t-dialin.net ([84.159.72.252]:39557 "EHLO
	p549F48FC.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20024340AbYFASCJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 1 Jun 2008 19:02:09 +0100
Received: from h155.mvista.com ([63.81.120.155]:19062 "EHLO imap.sh.mvista.com")
	by lappi.linux-mips.net with ESMTP id S1111459AbYFAR4y (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 1 Jun 2008 19:56:54 +0200
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 8DB163EC9; Sun,  1 Jun 2008 10:56:19 -0700 (PDT)
Message-ID: <4842E2C0.1020106@ru.mvista.com>
Date:	Sun, 01 Jun 2008 21:56:16 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 1.5.0.14 (Windows/20071210)
MIME-Version: 1.0
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: make r4k clocksource/clockevent usable in other
 codepaths
References: <20080528122838.GA5976@roarinelk.homelinux.net>
In-Reply-To: <20080528122838.GA5976@roarinelk.homelinux.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Manuel Lauss wrote:
> Make the r4k cp0 counter clocksource and clockevent modules
> library code so it may be used e.g. as a fallback in case other
> clocksources/events aren't available.
>
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
>   
[...]

> diff --git a/include/asm-mips/time.h b/include/asm-mips/time.h
> index d3bd5c5..01a4c93 100644
> --- a/include/asm-mips/time.h
> +++ b/include/asm-mips/time.h
> @@ -50,27 +50,35 @@ extern int (*perf_irq)(void);
>  /*
>   * Initialize the calling CPU's compare interrupt as clockevent device
>   */
> -#ifdef CONFIG_CEVT_R4K
> -extern int mips_clockevent_init(void);
> +#ifdef CONFIG_CEVT_R4K_LIB
>  extern unsigned int __weak get_c0_compare_int(void);
> -#else
> +extern int r4k_clockevent_init(void);
> +#endif
> +
>  static inline int mips_clockevent_init(void)
>  {
> +#ifdef CONFIG_CEVT_R4K
> +	return r4k_clockevent_init();
> +#else
>  	return -ENXIO;
> -}
>  #endif
> +}
>  
>  /*
>   * Initialize the count register as a clocksource
>   */
> -#ifdef CONFIG_CEVT_R4K
> -extern int init_mips_clocksource(void);
> -#else
> +#ifdef CONFIG_CSRC_R4K_LIB
> +extern int init_r4k_clocksource(void);
> +#endif
>   

   Hm, does it make sense to hedge ''extern' declaration by #ifdef's?

WBR, Sergei
