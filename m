Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Nov 2009 22:43:14 +0100 (CET)
Received: from gateway-1237.mvista.com ([206.112.117.35]:44435 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with SMTP id S1494095AbZKSVnH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Nov 2009 22:43:07 +0100
Received: from [127.0.0.1] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with SMTP
	id 047BF3ED9; Thu, 19 Nov 2009 13:42:46 -0800 (PST)
Message-ID: <4B05BBC6.2010000@ru.mvista.com>
Date:	Fri, 20 Nov 2009 00:42:30 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To:	wuzhangjin@gmail.com
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com,
	Richard Purdie <rpurdie@rpsys.net>, lm-sensors@lm-sensors.org,
	Jamey Hicks <jamey@crl.dec.com>
Subject: Re: [PATCH 5/5] [loongson] yeeloong2f: add platform specific support
References: <cover.1258651050.git.wuzhangjin@gmail.com>	 <08cd92bb27734174fd53df79cc926e76400d586d.1258651050.git.wuzhangjin@gmail.com> <1258653766.14308.13.camel@falcon.domain.org>
In-Reply-To: <1258653766.14308.13.camel@falcon.domain.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Wu Zhangjin wrote:

> Sorry, This patch can not be compiled without CONFIG_PM, this patch is
> needed to fix it:
>
> We need to wrap the source code relative to CONFIG_PM, otherwise, it
> will fail in compiling.
>
> This patch is needed to "[PATCH 5/5] [loongson] yeeloong2f: add platform
> specific support".
>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/loongson/lemote-2f/yeeloong_laptop.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
> b/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
> index ff74f7f..46c3847 100644
> --- a/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
> +++ b/arch/mips/loongson/lemote-2f/yeeloong_laptop.c
> @@ -1025,9 +1025,10 @@ static int yeeloong_hotkey_init(struct device
> *dev)
>  	/* update the current status of lid */
>  	yeeloong_lid_update_status(BIT_LID_DETECT_ON);
>  
> +#ifdef CONFIG_SUSPEND
>  	/* install the real yeeloong_report_lid_status for pm.c */
>  	yeeloong_report_lid_status = yeeloong_lid_update_status;
> -
> +#endif
>  	/* install event handler */
>  	yeeloong_install_sci_handler(EVENT_CAMERA, camera_set);
>  
> @@ -1039,9 +1040,10 @@ static void yeeloong_hotkey_exit(void)
>  	/* free irq */
>  	remove_irq(SCI_IRQ_NUM, &sci_irqaction);
>  
> +#ifdef CONFIG_SUSPEND
>  	/* uninstall the real yeeloong_report_lid_status for pm.c */
>  	yeeloong_report_lid_status = NULL;
> -
> +#endif
>  	/* uninstall event handler */
>  	yeeloong_uninstall_sci_handler(EVENT_CAMERA, camera_set);
>  
> @@ -1083,7 +1085,8 @@ static void get_fixed_battery_info(void)
>  
>  #define APM_CRITICAL		5
>  
> -static void yeeloong_apm_get_power_status(struct apm_power_info *info)
> +static void __maybe_unused yeeloong_apm_get_power_status(struct
> apm_power_info
> +		*info)
>   

   Your patch is line-wrapped.

WBR, Sergei
