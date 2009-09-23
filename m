Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2009 09:39:12 +0200 (CEST)
Received: from [222.92.8.141] ([222.92.8.141]:41794 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492097AbZIWHjF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Sep 2009 09:39:05 +0200
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 319FC31CC9A;
	Wed, 23 Sep 2009 15:28:27 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qZdurydITM+4; Wed, 23 Sep 2009 15:28:11 +0800 (CST)
Received: from [172.16.2.101] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id D7ADC31CC89;
	Wed, 23 Sep 2009 15:28:11 +0800 (CST)
Subject: Re: [PATCH 3/3] Fix typo "enalbe" -> "enable"
From:	Wu Zhangjin <wuzj@lemote.com>
Reply-To: wuzj@lemote.com
To:	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Cc:	linux-mips@linux-mips.org, oprofile-list@lists.sf.net,
	Yanhua <yanh@lemote.com>, Ralf Baechle <ralf@linux-mips.org>,
	Robert Richter <robert.richter@amd.com>
In-Reply-To: <1253522437-22919-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1253522437-22919-1-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Organization: www.lemote.com, Changshu City, JiangSu Province, China
Date:	Wed, 23 Sep 2009 15:38:33 +0800
Message-Id: <1253691513.17306.5.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 8bit
Return-Path: <wuzj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzj@lemote.com
Precedence: bulk
X-list: linux-mips

On Mon, 2009-09-21 at 10:40 +0200, Uwe Kleine-König wrote:
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: Wu Zhangjin <wuzj@lemote.com>
> Cc: Yanhua <yanh@lemote.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Robert Richter <robert.richter@amd.com>
> ---
>  arch/mips/oprofile/op_model_loongson2.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
> index 655cb8d..deed1d5 100644
> --- a/arch/mips/oprofile/op_model_loongson2.c
> +++ b/arch/mips/oprofile/op_model_loongson2.c
> @@ -44,7 +44,7 @@ static struct loongson2_register_config {
>  	unsigned int ctrl;
>  	unsigned long long reset_counter1;
>  	unsigned long long reset_counter2;
> -	int cnt1_enalbed, cnt2_enalbed;
> +	int cnt1_enabled, cnt2_enabled;
>  } reg;
>  
>  DEFINE_SPINLOCK(sample_lock);
> @@ -81,8 +81,8 @@ static void loongson2_reg_setup(struct op_counter_config *cfg)
>  
>  	reg.ctrl = ctrl;
>  
> -	reg.cnt1_enalbed = cfg[0].enabled;
> -	reg.cnt2_enalbed = cfg[1].enabled;
> +	reg.cnt1_enabled = cfg[0].enabled;
> +	reg.cnt2_enabled = cfg[1].enabled;
>  
>  }
>  
> @@ -99,7 +99,7 @@ static void loongson2_cpu_setup(void *args)
>  static void loongson2_cpu_start(void *args)
>  {
>  	/* Start all counters on current CPU */
> -	if (reg.cnt1_enalbed || reg.cnt2_enalbed)
> +	if (reg.cnt1_enabled || reg.cnt2_enabled)
>  		write_c0_perfctrl(reg.ctrl);
>  }
>  
> @@ -125,7 +125,7 @@ static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
>  	 */
>  
>  	/* Check whether the irq belongs to me */
> -	enabled = reg.cnt1_enalbed | reg.cnt2_enalbed;
> +	enabled = reg.cnt1_enabled | reg.cnt2_enabled;
>  	if (!enabled)
>  		return IRQ_NONE;
>  
> @@ -136,12 +136,12 @@ static irqreturn_t loongson2_perfcount_handler(int irq, void *dev_id)
>  	spin_lock_irqsave(&sample_lock, flags);
>  
>  	if (counter1 & LOONGSON2_PERFCNT_OVERFLOW) {
> -		if (reg.cnt1_enalbed)
> +		if (reg.cnt1_enabled)
>  			oprofile_add_sample(regs, 0);
>  		counter1 = reg.reset_counter1;
>  	}
>  	if (counter2 & LOONGSON2_PERFCNT_OVERFLOW) {
> -		if (reg.cnt2_enalbed)
> +		if (reg.cnt2_enabled)
>  			oprofile_add_sample(regs, 1);
>  		counter2 = reg.reset_counter2;
>  	}

Acked, thanks!

Regards,
	Wu Zhangjin
