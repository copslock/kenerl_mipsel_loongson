Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Dec 2010 11:42:43 +0100 (CET)
Received: from mail-ey0-f177.google.com ([209.85.215.177]:38701 "EHLO
        mail-ey0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491019Ab0LWKmk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Dec 2010 11:42:40 +0100
Received: by eyd9 with SMTP id 9so4106932eyd.36
        for <multiple recipients>; Thu, 23 Dec 2010 02:42:37 -0800 (PST)
Received: by 10.213.13.14 with SMTP id z14mr6508543ebz.52.1293100957466;
        Thu, 23 Dec 2010 02:42:37 -0800 (PST)
Received: from [192.168.2.2] ([91.79.89.129])
        by mx.google.com with ESMTPS id u1sm5482943eeh.10.2010.12.23.02.42.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 23 Dec 2010 02:42:35 -0800 (PST)
Message-ID: <4D13275D.8010204@mvista.com>
Date:   Thu, 23 Dec 2010 13:41:33 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>
Subject: Re: [PATCH v2 07/16] MIPS: ath79: add common watchdog device
References: <1293049861-28913-1-git-send-email-juhosg@openwrt.org> <1293049861-28913-8-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1293049861-28913-8-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 22-12-2010 23:30, Gabor Juhos wrote:

> All supported SoCs have a built-in hardware watchdog driver. This patch
> registers a platform_device for that to make it usable.

> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
> Signed-off-by: Imre Kaloz<kaloz@openwrt.org>
[...]

> diff --git a/arch/mips/ath79/dev-common.h b/arch/mips/ath79/dev-common.h
> index 1cec894..65bf400 100644
> --- a/arch/mips/ath79/dev-common.h
> +++ b/arch/mips/ath79/dev-common.h
> @@ -13,5 +13,6 @@
>   #define _ATH79_DEV_COMMON_H
>
>  void ath79_register_uart(void) __init;
> +void ath79_register_wdt(void) __init;

    '__init' not needed with declarations.

WBR, Sergei
