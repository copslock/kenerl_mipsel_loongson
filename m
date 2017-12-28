Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 19:41:09 +0100 (CET)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:37715
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990921AbdL1SlBYCIMO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 19:41:01 +0100
Received: by mail-pf0-x243.google.com with SMTP id n6so21250799pfa.4;
        Thu, 28 Dec 2017 10:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pgICEwAPE1vXbEW8DMnG+VRYEKNCB+wTLwxbGtTd7CI=;
        b=IOhGbS9C4JSpqKNRUmrZOiY8V5BkRGJdDngcDUuqYf0+lbhoyk3RWCrK3dePcKETPO
         93RyDNTQsMZaO0cMtaThPXahNL9SZSDf+9A+2XltHbpw/P9UmKESKXxij72E5lErYJAa
         ZB1TEhADcdZQiryBBMu5D9aXlwJpzDCAi1MoavAfu141Zp7Pii6jsHlZKFi7q4UyghjV
         w2vgDEaF3CWmjrNhNYHfHtdRsOGQjyF/5G+UIhyK88Qt5+J3NwaocYJP4IhkkEhk5qf+
         Fx/HlbZMeTO+qnKABguzqVf/nDOmjJd7R7HCTesqDvQ5hV1fbKmFRJJbonrhUciHgYl/
         VYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pgICEwAPE1vXbEW8DMnG+VRYEKNCB+wTLwxbGtTd7CI=;
        b=IK0Sw79qjhMnxDgyR0vmACNv/D4OuvkKS7zJPJ46nO5kQwAx5BF7FDIcuquyAXKwby
         NK+5ycZEj2HzHgxjPIpUDwt45XoJcOiUyjOFEhI/NSkXdPk5rLM6vx9yb8uho+qPA1FQ
         kBUHCsuFAaSz7aPKGOFNe3ip7iIf1eEJoSOcx+ZYieEmDaU8hsk7dla636ITX9AdGQN4
         2L21KQqfzSEdgkpCmUi8vz9yhEbYNcBkv1xho88Q9ZknFc9SqLbVZGIF8bQPDnMHxghM
         CeETKUWIBMWPpdcw1p/me55XY3lCORFw6l72u9BDZmW3xl/J2VAGnVbC9g6vzBoaHZaH
         Ix9A==
X-Gm-Message-State: AKGB3mIC1sJr0VoHam1GMlwDNe2bhNXz6q+hqoUrr/A2n0eZoSzkQnDb
        K0UYlOP77DtKdJARG7U1qRw=
X-Google-Smtp-Source: ACJfBouEme4aSymbRnCfOY0IfMHuytccKbMUk1LvbsZwoa+54y3fsd6QLnfff/zNPWIYVp6QRVNEog==
X-Received: by 10.98.160.193 with SMTP id p62mr33040236pfl.138.1514486455029;
        Thu, 28 Dec 2017 10:40:55 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n12sm74722101pfb.5.2017.12.28.10.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 10:40:54 -0800 (PST)
Subject: Re: [PATCH 3/7] watchdog: JZ4740: Register a restart handler
To:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20171228162939.3928-1-paul@crapouillou.net>
 <20171228162939.3928-4-paul@crapouillou.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e1871276-fc00-eefd-1a43-e528f6da1269@roeck-us.net>
Date:   Thu, 28 Dec 2017 10:40:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171228162939.3928-4-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 12/28/2017 08:29 AM, Paul Cercueil wrote:
> The watchdog driver can restart the system by simply configuring the
> hardware for a timeout of 0 seconds.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/jz4740_wdt.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 92d6ca8ceb49..fa7f49a3212c 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -130,6 +130,14 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>   	return 0;
>   }
>   
> +static int jz4740_wdt_restart(struct watchdog_device *wdt_dev,
> +			      unsigned long action, void *data)
> +{
> +	wdt_dev->timeout = 0;
> +	jz4740_wdt_start(wdt_dev);
> +	return 0;
> +}
> +
>   static const struct watchdog_info jz4740_wdt_info = {
>   	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>   	.identity = "jz4740 Watchdog",
> @@ -141,6 +149,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
>   	.stop = jz4740_wdt_stop,
>   	.ping = jz4740_wdt_ping,
>   	.set_timeout = jz4740_wdt_set_timeout,
> +	.restart = jz4740_wdt_restart,
>   };
>   
>   #ifdef CONFIG_OF
> 
