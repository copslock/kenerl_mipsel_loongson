Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2016 09:53:18 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:11463 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041344AbcFMHxQ3N-IC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jun 2016 09:53:16 +0200
Received: from eucpsbgm2.samsung.com (unknown [203.254.199.245])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0O8P0030N9WLSU60@mailout1.w1.samsung.com>; Mon,
 13 Jun 2016 08:53:09 +0100 (BST)
X-AuditID: cbfec7f5-f792a6d000001302-8a-575e6665fbdb
Received: from eusync3.samsung.com ( [203.254.199.213])
        by eucpsbgm2.samsung.com (EUCPMTA) with SMTP id 29.75.04866.5666E575; Mon,
 13 Jun 2016 08:53:09 +0100 (BST)
Received: from [106.120.53.23] by eusync3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0O8P00IVK9WKY320@eusync3.samsung.com>; Mon,
 13 Jun 2016 08:53:09 +0100 (BST)
Message-id: <575E6663.4040303@samsung.com>
Date:   Mon, 13 Jun 2016 09:53:07 +0200
From:   Jacek Anaszewski <j.anaszewski@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804
 Thunderbird/17.0.8
MIME-version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Stephan Linz <linz@li-pro.net>, linux-leds@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] mips: use the new LED disk activity trigger
References: <20160610060021.12382-1-linz@li-pro.net>
 <20160610060021.12382-5-linz@li-pro.net>
In-reply-to: <20160610060021.12382-5-linz@li-pro.net>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t/xq7qpaXHhBlO3s1kc2/GIyeLyrjls
        FlvfrGO0mDB1ErvF1deLWCwu7VFxYPPY/TbV4+jKtUwenzfJBTBHcdmkpOZklqUW6dslcGX8
        eiNVMFup4vXr26wNjN9kuhg5OSQETCR2L77KDmGLSVy4t56ti5GLQ0hgKaNE35uJUM4zRolL
        P/cxg1TxCmhJrHz3mgXEZhFQlXj+8BojiM0mYCjx88VrJhBbVCBC4s/pfawQ9YISPybfA6sX
        EVCTePVtMyvIUGaBaYwSz9YeBxsqLOAu0T/9BdgZQgLxErtvzAEbyilgKvGjsxOsmVnAWmLl
        pG2MELa8xOY1b5knMArMQrJjFpKyWUjKFjAyr2IUTS1NLihOSs810itOzC0uzUvXS87P3cQI
        CeKvOxiXHrM6xCjAwajEw6uxKjZciDWxrLgy9xCjBAezkghvVGpcuBBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXHembvehwgJpCeWpGanphakFsFkmTg4pRoY4+3fZKsfb43fF1Fnt+jdjsmCKox8
        5Wsr+CIKHobP7tUR/F25z6WyWE7ic7aqpMk6hX23cjO9ebdqzJlw6r+16Id/W27clr9ktuyb
        7A6pgo8ml/8KZ/g3ivcqmBzd35qwrePDy7PHr2leO2lpGiknqB3duDH1Is+pgxW6hjktSoqn
        xD7bRd9WYinOSDTUYi4qTgQA+Uxo/l4CAAA=
Return-Path: <j.anaszewski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: j.anaszewski@samsung.com
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

Hi Ralf,

For consistency reasons this patch should be merged through LED tree,
but I need an ack for this.

Thanks,
Jacek Anaszewski

On 06/10/2016 08:00 AM, Stephan Linz wrote:
> - platform: rename 'ide-disk' to 'disk-activity'
> - defconfig: rename 'LEDS_TRIGGER_IDE_DISK' to 'LEDS_TRIGGER_DISK'
>
> Signed-off-by: Stephan Linz <linz@li-pro.net>
> ---
>   arch/mips/configs/malta_qemu_32r6_defconfig | 2 +-
>   arch/mips/configs/maltaaprp_defconfig       | 2 +-
>   arch/mips/configs/maltasmvp_eva_defconfig   | 2 +-
>   arch/mips/configs/maltaup_defconfig         | 2 +-
>   arch/mips/configs/rbtx49xx_defconfig        | 2 +-
>   arch/mips/txx9/generic/setup.c              | 2 +-
>   arch/mips/txx9/rbtx4939/setup.c             | 2 +-
>   7 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/mips/configs/malta_qemu_32r6_defconfig b/arch/mips/configs/malta_qemu_32r6_defconfig
> index 7f50dd6..65f140e 100644
> --- a/arch/mips/configs/malta_qemu_32r6_defconfig
> +++ b/arch/mips/configs/malta_qemu_32r6_defconfig
> @@ -146,7 +146,7 @@ CONFIG_NEW_LEDS=y
>   CONFIG_LEDS_CLASS=y
>   CONFIG_LEDS_TRIGGERS=y
>   CONFIG_LEDS_TRIGGER_TIMER=y
> -CONFIG_LEDS_TRIGGER_IDE_DISK=y
> +CONFIG_LEDS_TRIGGER_DISK=y
>   CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>   CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>   CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> diff --git a/arch/mips/configs/maltaaprp_defconfig b/arch/mips/configs/maltaaprp_defconfig
> index a9d433a..799c433 100644
> --- a/arch/mips/configs/maltaaprp_defconfig
> +++ b/arch/mips/configs/maltaaprp_defconfig
> @@ -147,7 +147,7 @@ CONFIG_NEW_LEDS=y
>   CONFIG_LEDS_CLASS=y
>   CONFIG_LEDS_TRIGGERS=y
>   CONFIG_LEDS_TRIGGER_TIMER=y
> -CONFIG_LEDS_TRIGGER_IDE_DISK=y
> +CONFIG_LEDS_TRIGGER_DISK=y
>   CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>   CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>   CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> diff --git a/arch/mips/configs/maltasmvp_eva_defconfig b/arch/mips/configs/maltasmvp_eva_defconfig
> index 2774ef0..3184600 100644
> --- a/arch/mips/configs/maltasmvp_eva_defconfig
> +++ b/arch/mips/configs/maltasmvp_eva_defconfig
> @@ -152,7 +152,7 @@ CONFIG_NEW_LEDS=y
>   CONFIG_LEDS_CLASS=y
>   CONFIG_LEDS_TRIGGERS=y
>   CONFIG_LEDS_TRIGGER_TIMER=y
> -CONFIG_LEDS_TRIGGER_IDE_DISK=y
> +CONFIG_LEDS_TRIGGER_DISK=y
>   CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>   CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>   CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> diff --git a/arch/mips/configs/maltaup_defconfig b/arch/mips/configs/maltaup_defconfig
> index 9bbd221..a79107d 100644
> --- a/arch/mips/configs/maltaup_defconfig
> +++ b/arch/mips/configs/maltaup_defconfig
> @@ -146,7 +146,7 @@ CONFIG_NEW_LEDS=y
>   CONFIG_LEDS_CLASS=y
>   CONFIG_LEDS_TRIGGERS=y
>   CONFIG_LEDS_TRIGGER_TIMER=y
> -CONFIG_LEDS_TRIGGER_IDE_DISK=y
> +CONFIG_LEDS_TRIGGER_DISK=y
>   CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>   CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>   CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
> index f8bf9b4..43d55e5 100644
> --- a/arch/mips/configs/rbtx49xx_defconfig
> +++ b/arch/mips/configs/rbtx49xx_defconfig
> @@ -90,7 +90,7 @@ CONFIG_NEW_LEDS=y
>   CONFIG_LEDS_CLASS=y
>   CONFIG_LEDS_GPIO=y
>   CONFIG_LEDS_TRIGGERS=y
> -CONFIG_LEDS_TRIGGER_IDE_DISK=y
> +CONFIG_LEDS_TRIGGER_DISK=y
>   CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>   CONFIG_RTC_CLASS=y
>   CONFIG_RTC_INTF_DEV_UIE_EMUL=y
> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
> index 108f8a8..ada92db 100644
> --- a/arch/mips/txx9/generic/setup.c
> +++ b/arch/mips/txx9/generic/setup.c
> @@ -727,7 +727,7 @@ void __init txx9_iocled_init(unsigned long baseaddr,
>   	int i;
>   	static char *default_triggers[] __initdata = {
>   		"heartbeat",
> -		"ide-disk",
> +		"disk-activity",
>   		"nand-disk",
>   		NULL,
>   	};
> diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
> index 3703040..8b93730 100644
> --- a/arch/mips/txx9/rbtx4939/setup.c
> +++ b/arch/mips/txx9/rbtx4939/setup.c
> @@ -215,7 +215,7 @@ static int __init rbtx4939_led_probe(struct platform_device *pdev)
>   	int i;
>   	static char *default_triggers[] __initdata = {
>   		"heartbeat",
> -		"ide-disk",
> +		"disk-activity",
>   		"nand-disk",
>   	};
>
>


-- 
Best regards,
Jacek Anaszewski
