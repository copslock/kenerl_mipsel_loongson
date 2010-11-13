Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Nov 2010 12:48:22 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:61244 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491054Ab0KMLsQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Nov 2010 12:48:16 +0100
Received: by ewy19 with SMTP id 19so2269057ewy.36
        for <multiple recipients>; Sat, 13 Nov 2010 03:48:14 -0800 (PST)
Received: by 10.213.7.65 with SMTP id c1mr3058931ebc.26.1289648894679;
        Sat, 13 Nov 2010 03:48:14 -0800 (PST)
Received: from [192.168.2.2] ([91.79.89.47])
        by mx.google.com with ESMTPS id v56sm4294731eeh.20.2010.11.13.03.48.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Nov 2010 03:48:13 -0800 (PST)
Message-ID: <4CDE7A92.8040602@mvista.com>
Date:   Sat, 13 Nov 2010 14:46:26 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [RFC 05/18] MIPS: ath79: add initial support for the Atheros
 PB44 reference board
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org> <1289598684-30624-6-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1289598684-30624-6-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 13-11-2010 0:51, Gabor Juhos wrote:

> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
[...]

> diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
> index 32e2658..47a8af4 100644
> --- a/arch/mips/ath79/Kconfig
> +++ b/arch/mips/ath79/Kconfig
> @@ -1,5 +1,17 @@
>   if ATH79
>
> +menu "Atheros AR71XX/AR724X/AR913X machine selection"
> +
> +config ATH79_MACH_PB44
> +	bool "Atheros PB44 reference board"
> +	select SOC_AR71XX
> +	default n

    That "default n" is assumed, so there's no need to specify it.

WBR, Sergei
