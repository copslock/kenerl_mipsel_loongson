Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2012 11:36:40 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:48271 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903648Ab2BXKgd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2012 11:36:33 +0100
Received: by bkcjk13 with SMTP id jk13so2428781bkc.36
        for <linux-mips@linux-mips.org>; Fri, 24 Feb 2012 02:36:27 -0800 (PST)
Received-SPF: pass (google.com: domain of sshtylyov@mvista.com designates 10.204.152.208 as permitted sender) client-ip=10.204.152.208;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of sshtylyov@mvista.com designates 10.204.152.208 as permitted sender) smtp.mail=sshtylyov@mvista.com
Received: from mr.google.com ([10.204.152.208])
        by 10.204.152.208 with SMTP id h16mr866275bkw.6.1330079787618 (num_hops = 1);
        Fri, 24 Feb 2012 02:36:27 -0800 (PST)
Received: by 10.204.152.208 with SMTP id h16mr720808bkw.6.1330079787416;
        Fri, 24 Feb 2012 02:36:27 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-85-203.pppoe.mtu-net.ru. [91.79.85.203])
        by mx.google.com with ESMTPS id x22sm7819507bkw.11.2012.02.24.02.36.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 24 Feb 2012 02:36:26 -0800 (PST)
Message-ID: <4F4767DF.4090102@mvista.com>
Date:   Fri, 24 Feb 2012 14:35:11 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 1/6] MIPS: lantiq: remove redunant ltq_gpio_request()
 declaration and add device parameter
References: <1330012913-13293-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1330012913-13293-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQm27IjMHVkDuCRcKlwwVqqkOZTv1uNCGA2CMzJpRkvCncPpwp/6lSkH0q6EGYoo3uxHqs+/
X-archive-position: 32538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 23-02-2012 20:01, John Crispin wrote:

> 3.2 introduced devm_request_gpio() to allow managed gpios.

> The devres api requires a struct device pointer to work. Add a parameter to ltq_gpio_request()
> so that managed gpios can work.

> Signed-off-by: John Crispin<blogic@openwrt.org>
[...]

> diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
> index bf05854..d90eef3 100644
> --- a/arch/mips/include/asm/mach-lantiq/lantiq.h
> +++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
> @@ -39,6 +39,10 @@ extern unsigned int ltq_get_soc_type(void);
>   /* spinlock all ebu i/o */
>   extern spinlock_t ebu_lock;
>
> +/* request a non-gpio and set the PIO config */
> +extern int ltq_gpio_request(struct device *dev, unsigned int pin,
> +		unsigned int mux, unsigned int dir, const char *name);
> +

    Where are the call sites of this function? Shoudln't they be modified?

WBR, Sergei
