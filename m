Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Sep 2015 10:36:59 +0200 (CEST)
Received: from mailout1.w1.samsung.com ([210.118.77.11]:11092 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006776AbbIQIg5F3iXN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Sep 2015 10:36:57 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NUT00CV8BXDVN00@mailout1.w1.samsung.com>; Thu,
 17 Sep 2015 09:36:49 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-08-55fa7ba1a5b5
Received: from eusync1.samsung.com ( [203.254.199.211])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 86.B2.04846.1AB7AF55; Thu,
 17 Sep 2015 09:36:49 +0100 (BST)
Received: from [106.120.53.23] by eusync1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTPA id <0NUT002L7BXCEW40@eusync1.samsung.com>; Thu,
 17 Sep 2015 09:36:49 +0100 (BST)
Message-id: <55FA7BA0.4080706@samsung.com>
Date:   Thu, 17 Sep 2015 10:36:48 +0200
From:   Jacek Anaszewski <j.anaszewski@samsung.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804
 Thunderbird/17.0.8
MIME-version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-leds@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v2] LED/MIPS: Move SEAD3 LED driver to where it belongs.
References: <20150803150401.GD2843@linux-mips.org>
In-reply-to: <20150803150401.GD2843@linux-mips.org>
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t/xy7oLq3+FGuzfxWJxdOdEJoutb9Yx
        WkyYOond4vPt7awWl/aoWOze9ZTVgc1j56y77B49O88wehxduZbJY8/8H6wenzfJBbBGcdmk
        pOZklqUW6dslcGUs+DmPvaBLt2Lx0UWsDYyvlLoYOTkkBEwk7q+/wwhhi0lcuLeerYuRi0NI
        YCmjxJadn9hAEkICzxglvrQ4dzFycPAKaEnMWpcHEmYRUJV4vawfrJdNwFDi54vXTCC2qECE
        xJ/T+1hBbF4BQYkfk++xgNgiAmoSr75tZgWZzyywjlHi/90rYEXCAj4SGz5/Z4HYZSTRvfcf
        mM0pYCzxZEEz2AJmAWuJlZO2QdnyEpvXvGWewCgwC8mOWUjKZiEpW8DIvIpRNLU0uaA4KT3X
        UK84Mbe4NC9dLzk/dxMjJLC/7GBcfMzqEKMAB6MSD6+Cy69QIdbEsuLK3EOMEhzMSiK8LNlA
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxzd70PERJITyxJzU5NLUgtgskycXBKNTBm1E66Z9pz
        6INd+b1LatZPKsu7uD9Nu993fb3E3eXCEw+KHnBz10gWNqwK/rVk8tOjRpOcHa6vuH41Yoro
        rt5VZV3M2aYZG3d+v+Ay26rR6VrX2tueGf/bllvdTPn9sLDsSae9jUdMV06dYGXXTKG2X9ZL
        Vveaq/7ZVTLL7KU1X8ChDcpTnvArsRRnJBpqMRcVJwIAELvZrmgCAAA=
Return-Path: <j.anaszewski@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49226
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

This patch got stuck somewhere in my mailbox and just
recently showed up to my eyes again, so I applied it to v4.3-rc1, but 
when tried to compile-test it, I got following errors:

arch/mips/kernel/signal.c: In function 'sc_to_extcontext':
arch/mips/kernel/signal.c:143:12: error: 'struct ucontext' has no member 
named 'uc_extcontext'
   return &uc->uc_extcontext;
             ^
In file included from include/linux/poll.h:11:0,
                  from include/linux/ring_buffer.h:7,
                  from include/linux/trace_events.h:5,
                  from include/trace/syscall.h:6,
                  from include/linux/syscalls.h:81,
                  from arch/mips/kernel/signal.c:26:
arch/mips/kernel/signal.c: In function 'save_msa_extcontext':
arch/mips/kernel/signal.c:171:40: error: dereferencing pointer to 
incomplete type
    err = __put_user(read_msa_csr(), &msa->csr);
                                         ^
./arch/mips/include/asm/uaccess.h:441:15: note: in definition of macro 
'__put_user_nocheck'
   __typeof__(*(ptr)) __pu_val;     \
                ^
arch/mips/kernel/signal.c:171:9: note: in expansion of macro '__put_user'
    err = __put_user(read_msa_csr(), &msa->csr);
          ^
arch/mips/kernel/signal.c:171:40: error: dereferencing pointer to 
incomplete type
    err = __put_user(read_msa_csr(), &msa->csr);
                                         ^
./arch/mips/include/asm/uaccess.h:430:10: note: in definition of macro 
'__put_user_common'
   switch (size) {       \
           ^
./arch/mips/include/asm/uaccess.h:446:3: note: in expansion of macro 
'__put_kernel_common'
    __put_kernel_common(ptr, size);    \
    ^
./arch/mips/include/asm/uaccess.h:214:2: note: in expansion of macro 
'__put_user_nocheck'
   __put_user_nocheck((x), (ptr), sizeof(*(ptr)))
   ^
arch/mips/kernel/signal.c:171:9: note: in expansion of macro '__put_user'
    err = __put_user(read_msa_csr(), &msa->csr);
          ^
arch/mips/kernel/signal.c:171:40: error: dereferencing pointer to 
incomplete type
    err = __put_user(read_msa_csr(), &msa->csr);
                                         ^
./arch/mips/include/asm/uaccess.h:241:51: note: in definition of macro '__m'
  #define __m(x) (*(struct __large_struct __user *)(x))
                                                    ^
-- cut listing here - it is much longer --


Compilation succeeds with v4.2-rc8.
Is it a known issue?

-- 
Best Regards,
Jacek Anaszewski

On 08/03/2015 05:04 PM, Ralf Baechle wrote:
> Fixes the following randconfig problem
>
> leds-sead3.c:(.text+0x7dc): undefined reference to `led_classdev_unregister'
> leds-sead3.c:(.text+0x7e8): undefined reference to `led_classdev_unregister'
>
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> Cc: Bryan Wu <cooloney@gmail.com>
> Cc: Richard Purdie <rpurdie@rpsys.net>
> Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
> Cc: Markos Chandras <markos.chandras@imgtec.com>
> Cc: linux-leds@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
>   arch/mips/mti-sead3/Makefile                       |  2 --
>   drivers/leds/Kconfig                               | 10 ++++++++++
>   drivers/leds/Makefile                              |  1 +
>   {arch/mips/mti-sead3 => drivers/leds}/leds-sead3.c |  1 +
>   4 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
> index 2e52cbd..7a584e0 100644
> --- a/arch/mips/mti-sead3/Makefile
> +++ b/arch/mips/mti-sead3/Makefile
> @@ -12,6 +12,4 @@ obj-y				:= sead3-lcd.o sead3-display.o sead3-init.o \
>   				   sead3-int.o sead3-platform.o sead3-reset.o \
>   				   sead3-setup.o sead3-time.o
>
> -obj-y				+= leds-sead3.o
> -
>   obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 9ad35f7..531729c 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -550,6 +550,16 @@ config LEDS_KTD2692
>
>   	  Say Y to enable this driver.
>
> +config LEDS_SEAD3
> +	tristate "LED support for the MIPS SEAD 3 board"
> +	depends on LEDS_CLASS && MIPS_SEAD3
> +	help
> +	  Say Y here to include support for the FLED and PLED LEDs on SEAD3 eval
> +	  boards.
> +
> +	  This driver can also be built as a module. If so the module
> +	  will be called leds-sead3.
> +
>   comment "LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)"
>
>   config LEDS_BLINKM
> diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
> index 8d6a24a..a976161 100644
> --- a/drivers/leds/Makefile
> +++ b/drivers/leds/Makefile
> @@ -65,6 +65,7 @@ obj-$(CONFIG_LEDS_VERSATILE)		+= leds-versatile.o
>   obj-$(CONFIG_LEDS_MENF21BMC)		+= leds-menf21bmc.o
>   obj-$(CONFIG_LEDS_PM8941_WLED)		+= leds-pm8941-wled.o
>   obj-$(CONFIG_LEDS_KTD2692)		+= leds-ktd2692.o
> +obj-$(CONFIG_LEDS_SEAD3)		+= leds-sead3.o
>
>   # LED SPI Drivers
>   obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
> diff --git a/arch/mips/mti-sead3/leds-sead3.c b/drivers/leds/leds-sead3.c
> similarity index 99%
> rename from arch/mips/mti-sead3/leds-sead3.c
> rename to drivers/leds/leds-sead3.c
> index c938cee..eb97a32 100644
> --- a/arch/mips/mti-sead3/leds-sead3.c
> +++ b/drivers/leds/leds-sead3.c
> @@ -59,6 +59,7 @@ static int sead3_led_remove(struct platform_device *pdev)
>   {
>   	led_classdev_unregister(&sead3_pled);
>   	led_classdev_unregister(&sead3_fled);
> +
>   	return 0;
>   }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-leds" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
