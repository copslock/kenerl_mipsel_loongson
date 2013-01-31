Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 14:09:26 +0100 (CET)
Received: from mail-wi0-f173.google.com ([209.85.212.173]:64123 "EHLO
        mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823555Ab3AaNJZSyDrj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 Jan 2013 14:09:25 +0100
Received: by mail-wi0-f173.google.com with SMTP id hq4so430819wib.0
        for <multiple recipients>; Thu, 31 Jan 2013 05:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Nsp2EjXQTxY91DQS8ZtQ7+tPQrE8QPyykAaafJAZb54=;
        b=Y21jx78Pf0QWfILOabTUymHPORzHVUq20odEFGJ+hrYG8VlriMRaQGDT0uLeyUgvv0
         G9X9rqkC56UwzwQ6iTkA2xj965ODedxtyFMsM/bjQkxN8vOA7Wgbez1Arpwt3Ws2G5K1
         QUQtD4SRbo+G5dV9OPZrsPKCRIH4ghP1UaQje6fmocP43CXbeWAEx6Fpc7lYkoxcWfkv
         sPxzoFsWlN2/F9JhQ250z1itr999ojsGuFCwz+2JaPtSWoBbX8Cr5u+0AwiWJ9ec9+3b
         pWxUxzPEvzGyv1yrAkOt7q0P/HR+Nyhi8oqmxdwZu/7i9xl37p0Yh3zvTyZv7DmZ45NJ
         PxVQ==
X-Received: by 10.194.59.40 with SMTP id w8mr15357073wjq.51.1359637759960;
        Thu, 31 Jan 2013 05:09:19 -0800 (PST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id df2sm14990155wib.0.2013.01.31.05.09.19
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 05:09:19 -0800 (PST)
Message-ID: <510A6C55.5080004@openwrt.org>
Date:   Thu, 31 Jan 2013 14:06:29 +0100
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 08/10] MIPS: ralink: adds support for RT305x SoC family
References: <1359633561-4980-1-git-send-email-blogic@openwrt.org> <1359633561-4980-9-git-send-email-blogic@openwrt.org>
In-Reply-To: <1359633561-4980-9-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello John,

On 01/31/2013 12:59 PM, John Crispin wrote:
[snip]

> +
> +struct ralink_pinmux gpio_pinmux = {
> +	.mode = mode_mux,
> +	.uart = uart_mux,
> +	.uart_shift = RT305X_GPIO_MODE_UART0_SHIFT,
> +	.wdt_reset = rt305x_wdt_reset,
> +};

It seems to me like the new convention for pinctrl/pinmux etc .. is to 
actually create drivers/pinctrl/pinctrl-ralink.c and 
drivers/pinctrl/pinctrl-rt305x.c, I guess this can be done later when 
you come up with support for the other Ralink SoCs.
--
Florian
