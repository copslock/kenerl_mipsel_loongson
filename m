Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2014 11:17:24 +0100 (CET)
Received: from cassarossa.samfundet.no ([193.35.52.29]:56930 "EHLO
        cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012215AbaKAKRV4Exr0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 1 Nov 2014 11:17:21 +0100
Received: from egtvedt by cassarossa.samfundet.no with local (Exim 4.80)
        (envelope-from <egtvedt@samfundet.no>)
        id 1XkVjZ-0003c6-QA; Sat, 01 Nov 2014 11:16:37 +0100
Date:   Sat, 1 Nov 2014 11:16:37 +0100
From:   Hans-Christian Egtvedt <egtvedt@samfundet.no>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Haavard Skinnemoen <hskinnemoen@gmail.com>
Subject: Re: [PATCH 33/44] avr32: atngw100: Register with kernel poweroff
 handler
Message-ID: <20141101101637.GA5765@samfundet.no>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-34-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412659726-29957-34-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <egtvedt@samfundet.no>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: egtvedt@samfundet.no
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

Around Mon 06 Oct 2014 22:28:35 -0700 or thereabout, Guenter Roeck wrote:
> Register with kernel poweroff handler instead of setting pm_power_off
> directly.
> 
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/avr32/boards/atngw100/mrmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/avr32/boards/atngw100/mrmt.c b/arch/avr32/boards/atngw100/mrmt.c
> index 91146b4..54d0c27 100644
> --- a/arch/avr32/boards/atngw100/mrmt.c
> +++ b/arch/avr32/boards/atngw100/mrmt.c
> @@ -274,7 +274,7 @@ static int __init mrmt1_init(void)
>  {
>  	gpio_set_value( PIN_PWR_ON, 1 );	/* Ensure PWR_ON is enabled */
>  
> -	pm_power_off = mrmt_power_off;
> +	register_poweroff_handler_simple(mrmt_power_off, 128);
>  
>  	/* Setup USARTS (other than console) */
>  	at32_map_usart(2, 1, 0);	/* USART 2: /dev/ttyS1, RMT1:DB9M */
-- 
mvh
Hans-Christian Egtvedt
