Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Mar 2013 14:39:12 +0100 (CET)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:65239 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827575Ab3CWNjLA-g4m convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 23 Mar 2013 14:39:11 +0100
Received: by mail-wg0-f45.google.com with SMTP id dq12so59657wgb.0
        for <linux-mips@linux-mips.org>; Sat, 23 Mar 2013 06:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:organization:to:subject:date:user-agent:cc
         :references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=TV2Ip4itVo+uzs6FObqjNfP0+mmiNwJcD3eT+3eFnZE=;
        b=S/kRbKtST+MqSCKcTNNCXVkkK/5ehCYQDIGL8d7VrHOAOT2U7ZSnQls44rqcU9P3+x
         hp/GyVqXB9c+LbD1AldbwBcaNjZ3XXLLHCvaQ0aC0B8iI9lkExmMI0odwXgalvpAr/Ib
         0S6UgrTfsiyHfKEGZnUkQHSIbZD8pTPpfbGsK5mYWC44C3Fft/16mqd5ngF8XRJZ0xUN
         rvCuyTGzbFiyCWVtiOrFUBkKcZvGAwI5g51S69Qm0nVmdOZGt2HdWDJ0AAOPjW64AaNk
         E14+hCP76RtcWaud5JC023YfUX0fUflUmqdvTiJy/m5RL03HFaffMv1A8VMJNIJU30/b
         HyLw==
X-Received: by 10.194.119.200 with SMTP id kw8mr8684477wjb.31.1364045945640;
        Sat, 23 Mar 2013 06:39:05 -0700 (PDT)
Received: from lenovo.localnet ([2a01:e35:2f70:4010:21d:7dff:fe45:5399])
        by mx.google.com with ESMTPS id ej8sm16704816wib.9.2013.03.23.06.39.03
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 23 Mar 2013 06:39:04 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH 2/3] MIPS: BCM63XX: export PSI size from nvram
Date:   Sat, 23 Mar 2013 14:39:00 +0100
User-Agent: KMail/1.13.7 (Linux/3.7-trunk-amd64; KDE/4.8.4; x86_64; ; )
Cc:     linux-mtd@lists.infradead.org,
        Artem Bityutskiy <dedekind1@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org
References: <1364044070-10486-1-git-send-email-jogo@openwrt.org> <1364044070-10486-3-git-send-email-jogo@openwrt.org>
In-Reply-To: <1364044070-10486-3-git-send-email-jogo@openwrt.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <201303231439.00694.florian@openwrt.org>
X-archive-position: 35949
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

Hello Jonas,

A few minor comments below:

Le samedi 23 mars 2013 14:07:48, Jonas Gorski a écrit :
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>
> ---
>  arch/mips/bcm63xx/nvram.c                          |   11 +++++++++++
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h |    2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/mips/bcm63xx/nvram.c b/arch/mips/bcm63xx/nvram.c
> index 6206116..44af608 100644
> --- a/arch/mips/bcm63xx/nvram.c
> +++ b/arch/mips/bcm63xx/nvram.c
> @@ -35,6 +35,8 @@ struct bcm963xx_nvram {
>  	u32	checksum_high;
>  };
> 
> +#define BCM63XX_DEFAULT_PSI_SIZE	64
> +
>  static struct bcm963xx_nvram nvram;
>  static int mac_addr_used;
> 
> @@ -105,3 +107,12 @@ int bcm63xx_nvram_get_mac_address(u8 *mac)
>  	return 0;
>  }
>  EXPORT_SYMBOL(bcm63xx_nvram_get_mac_address);
> +
> +int bcm63xx_nvram_get_psi_size(void)
> +{
> +	if (nvram.psi_size > 0)
> +		return nvram.psi_size;
> +
> +	return BCM63XX_DEFAULT_PSI_SIZE;

I wonder if it would not be better to return a size in KBytes here instead of 
a multiple of KBytes?

> +}
> +EXPORT_SYMBOL(bcm63xx_nvram_get_psi_size);
> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
> b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h index
> 62d6a3b..d76a486 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_nvram.h
> @@ -32,4 +32,6 @@ u8 *bcm63xx_nvram_get_name(void);
>   */
>  int bcm63xx_nvram_get_mac_address(u8 *mac);
> 
> +int bcm63xx_nvram_get_psi_size(void);

You could use an unsigned int here.
-- 
Florian
