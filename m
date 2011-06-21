Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jun 2011 12:23:25 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:51955 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491151Ab1FUKXT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jun 2011 12:23:19 +0200
Received: by wyf23 with SMTP id 23so3684051wyf.36
        for <multiple recipients>; Tue, 21 Jun 2011 03:23:13 -0700 (PDT)
Received: by 10.216.237.102 with SMTP id x80mr614752weq.111.1308651793304;
        Tue, 21 Jun 2011 03:23:13 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.89.177])
        by mx.google.com with ESMTPS id eq4sm3882408wbb.37.2011.06.21.03.23.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 03:23:11 -0700 (PDT)
Message-ID: <4E0070CA.1070102@mvista.com>
Date:   Tue, 21 Jun 2011 14:22:02 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Kathy Giori <kgiori@qca.qualcomm.com>,
        "Luis R. Rodriguez" <rodrigue@qca.qualcomm.com>
Subject: Re: [PATCH 02/13] MIPS: ath79: add revision id for the AR933X SoCs
References: <1308597973-6037-1-git-send-email-juhosg@openwrt.org> <1308597973-6037-3-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1308597973-6037-3-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17048

Hello.

On 20-06-2011 23:26, Gabor Juhos wrote:

> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
> ---
>   arch/mips/ath79/setup.c                        |   12 ++++++++++++
>   arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    4 ++++
>   arch/mips/include/asm/mach-ath79/ath79.h       |    4 +++-
>   3 files changed, 19 insertions(+), 1 deletions(-)

> diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
> index dea5af1..4cbd5e0 100644
> --- a/arch/mips/ath79/setup.c
> +++ b/arch/mips/ath79/setup.c
> @@ -116,6 +116,18 @@ static void __init ath79_detect_sys_type(void)
>   		rev = id&  AR724X_REV_ID_REVISION_MASK;
>   		break;
>
> +	case REV_ID_MAJOR_AR9330:
> +		ath79_soc = ATH79_SOC_AR9330;
> +		chip = "9330";
> +		rev = (id & AR933X_REV_ID_REVISION_MASK);
> +		break;
> +
> +	case REV_ID_MAJOR_AR9331:
> +		ath79_soc = ATH79_SOC_AR9331;
> +		chip = "9331";
> +		rev = (id & AR933X_REV_ID_REVISION_MASK);

    Hm, you've just removed such parens in the previous patch, why add more of 
them? :-O

WBR, Sergei
