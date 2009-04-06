Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Apr 2009 16:09:46 +0100 (BST)
Received: from gateway02.websitewelcome.com ([67.18.80.20]:11730 "HELO
	gateway02.websitewelcome.com") by ftp.linux-mips.org with SMTP
	id S20023881AbZDFPJk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Apr 2009 16:09:40 +0100
Received: (qmail 24639 invoked from network); 6 Apr 2009 15:10:48 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway02.websitewelcome.com with SMTP; 6 Apr 2009 15:10:48 -0000
Received: from [217.109.65.213] (port=3674 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LqqS6-0006Ux-4L; Mon, 06 Apr 2009 10:09:34 -0500
Message-ID: <49DA1B30.8080408@paralogos.com>
Date:	Mon, 06 Apr 2009 17:09:36 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] Fix build error if CONFIG_CEVT_R4K was not defined
References: <1239030295-14080-1-git-send-email-anemo@mba.ocn.ne.jp>
In-Reply-To: <1239030295-14080-1-git-send-email-anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

Drat, and I was *sure* that I'd tested that in a non-SMTC
configuration!  Thanks!

          Kevin K.

Atsushi Nemoto wrote:
> This patch fixes build error introduced by "MIPS: SMTC:
> Fix xxx_clockevent_init() naming conflict for SMT".
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> ---
>  arch/mips/include/asm/time.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
> index e46f23f..df6a430 100644
> --- a/arch/mips/include/asm/time.h
> +++ b/arch/mips/include/asm/time.h
> @@ -61,7 +61,7 @@ static inline int mips_clockevent_init(void)
>  	extern int smtc_clockevent_init(void);
>  
>  	return smtc_clockevent_init();
> -#elif CONFIG_CEVT_R4K
> +#elif defined(CONFIG_CEVT_R4K)
>  	return r4k_clockevent_init();
>  #else
>  	return -ENXIO;
>   
