Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2012 11:57:50 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:56528 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823426Ab2J2K5pkkCzD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Oct 2012 11:57:45 +0100
Received: by mail-la0-f49.google.com with SMTP id z14so3577833lag.36
        for <linux-mips@linux-mips.org>; Mon, 29 Oct 2012 03:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=xePCsiKrtXzrBEE0I/vaadOvvUSdMU2pRojTshkyzuI=;
        b=bOxLoOcWAn2Ujqns/YUAC94+YMcpaUL822KP3tJCBNs+N3RuxvVaqgN/1C85dt9aMd
         gLUNSVMMGx73rl/b+4jrVJu9IQfrI1zWVXxOrLcfLOtIvAJduLbBYI6+OhBukAlGdE5Z
         uS1g7UrsOKYyowGyZbTPo7NczbQN8gs7UqcTMJOtTsaaxuy1NMU8AFHALfm+KfkvY2ep
         VuuLe1NlhxuGvpbuVnPAo+0U/f3ux+o1Pu51S/aTWH1hy/Nx3/WEvoj8ug1LP8bP3XKD
         DtbDHoKuuIvxyJEM3CP4OIUDaM9x62RJRYmr0o5IPFjsOAkMQ/Dlzp5kmuzAbmHcFJTB
         UBPw==
Received: by 10.152.124.201 with SMTP id mk9mr27186508lab.33.1351508259544;
        Mon, 29 Oct 2012 03:57:39 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-70-64.pppoe.mtu-net.ru. [91.79.70.64])
        by mx.google.com with ESMTPS id ew2sm3056743lbb.2.2012.10.29.03.57.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2012 03:57:37 -0700 (PDT)
Message-ID: <508E60DB.6050005@mvista.com>
Date:   Mon, 29 Oct 2012 14:56:27 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
MIME-Version: 1.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 1/3] MIPS: BCM63XX: add softreset register description
 for BCM6358
References: <1351430275-14509-1-git-send-email-jonas.gorski@gmail.com> <1351430275-14509-2-git-send-email-jonas.gorski@gmail.com>
In-Reply-To: <1351430275-14509-2-git-send-email-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmZOWw58M6wZILC/EycaYS4Btw6yRZ64pj9is6LmAqOxXn4zHQyW7BwH++jOCER5SIfq3l0
X-archive-position: 34787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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

Hello.

On 28-10-2012 17:17, Jonas Gorski wrote:

> The softreset register description for BCM6358 was missing, so add it.

> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>   arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |   10 ++++++++++
>   1 files changed, 10 insertions(+), 0 deletions(-)

> diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> index 12963d0..e84e602 100644
> --- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
> +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
[...]
> @@ -244,6 +245,15 @@
>   				  SOFTRESET_6348_ACLC_MASK |		\
>   				  SOFTRESET_6348_ADSLMIPSPLL_MASK)
>
> +#define SOFTRESET_6358_SPI_MASK		(1 << 0)
> +#define SOFTRESET_6358_ENET_MASK	(1 << 2)
> +#define SOFTRESET_6358_MPI_MASK		(1 << 3)
> +#define SOFTRESET_6358_EPHY_MASK	(1 << 6)
> +#define SOFTRESET_6358_SAR_MASK		(1 << 7)
> +#define SOFTRESET_6358_USBH_MASK	(1 << 12)
> +#define SOFTRESET_6358_PCM_MASK		(1 << 13)
> +#define SOFTRESET_6358_ADSL_MASK	(1 << 14)
> +

    Why not use BIT(n) instead of (1 << n)?

WBR, Sergei
