Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 12:08:50 +0200 (CEST)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:62525 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011063AbaJJKIsaV8x6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 12:08:48 +0200
Received: by mail-lb0-f180.google.com with SMTP id n15so2731526lbi.39
        for <linux-mips@linux-mips.org>; Fri, 10 Oct 2014 03:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=uBogezZKxyWXP/d12lE21gOTLooIk8AcgZnoLefvYsc=;
        b=L00Br0gFnf+YAVPx2HBFi8e4qmPBpNCX66khLQS08Ns+PNZJQE+Ll0fTe7vmx97Zd7
         LSoqfZ4OjjLxlFLY9uxyV8mN8LaHgZjT6xBT+AqbZHEs2YGvoFO5MfODquWFrAT9KS9f
         JlRdxCthVa4QPVaLpf4BiZy/my7VZ6B/XqjRzMTcGt/AG3Ey8Zjvy1GBE2pB8KO3a1Q5
         U6Ty28G96Ow5t+tyHCorXDQP7IzVMHUnOnMGIg3EEYy/EWr1s9vlbvUoGublPfjGwBI1
         FfrD5FgQWq7ibHo/F09rE4uM0tF9suy0SSUy77npPx0TAPfHWwCdJkjFeJHT8b5OQTrl
         Ukpg==
X-Gm-Message-State: ALoCoQmaqfi5rnNbD7WfU7SVzDpV3DjTbe7dfZzcgQB5JPU92ssd93ca55f9k/2tVwUsurEMp2Cg
X-Received: by 10.152.19.167 with SMTP id g7mr3639317lae.31.1412935718866;
        Fri, 10 Oct 2014 03:08:38 -0700 (PDT)
Received: from [192.168.2.5] (ppp18-197.pppoe.mtu-net.ru. [81.195.18.197])
        by mx.google.com with ESMTPSA id xe10sm1682492lbb.37.2014.10.10.03.08.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Oct 2014 03:08:37 -0700 (PDT)
Message-ID: <5437B020.3000405@cogentembedded.com>
Date:   Fri, 10 Oct 2014 14:08:32 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 3/4] MIPS: ralink: add support for MT7620n
References: <1412927388-60721-1-git-send-email-blogic@openwrt.org> <1412927388-60721-4-git-send-email-blogic@openwrt.org>
In-Reply-To: <1412927388-60721-4-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 10/10/2014 11:49 AM, John Crispin wrote:

> This is the small version of MT7620a.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/include/asm/mach-ralink/mt7620.h |    7 ++-----
>   arch/mips/ralink/mt7620.c                  |   20 +++++++++++++-------
>   2 files changed, 15 insertions(+), 12 deletions(-)

[...]

> diff --git a/arch/mips/ralink/mt7620.c b/arch/mips/ralink/mt7620.c
> index 24fb40a..e4b1f82 100644
> --- a/arch/mips/ralink/mt7620.c
> +++ b/arch/mips/ralink/mt7620.c
[...]
> @@ -298,22 +299,27 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
>   	u32 cfg0;
>   	u32 pmu0;
>   	u32 pmu1;
> +	u32 bga;
>
>   	n0 = __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
>   	n1 = __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
> +	rev = __raw_readl(sysc + SYSC_REG_CHIP_REV);
> +	bga = (rev >> CHIP_REV_PKG_SHIFT) & CHIP_REV_PKG_MASK;
>
> -	if (n0 == MT7620N_CHIP_NAME0 && n1 == MT7620N_CHIP_NAME1) {
> -		name = "MT7620N";
> -		soc_info->compatible = "ralink,mt7620n-soc";
> -	} else if (n0 == MT7620A_CHIP_NAME0 && n1 == MT7620A_CHIP_NAME1) {
> +	if (n0 != MT7620_CHIP_NAME0 || n1 != MT7620_CHIP_NAME1)
> +		panic("mt7620: unknown SoC, n0:%08x n1:%08x\n", n0, n1);
> +
> +	if (bga) {
>   		name = "MT7620A";
>   		soc_info->compatible = "ralink,mt7620a-soc";
>   	} else {
> -		panic("mt7620: unknown SoC, n0:%08x n1:%08x", n0, n1);
> +		name = "MT7620N";
> +		soc_info->compatible = "ralink,mt7620n-soc";
> +#ifdef CONFIG_PCI

    I suggest:

		if (IS_ENABLED(CONFIG_PCI))

in order to avoid this #ifdef.

[...]

WBR, Sergei
