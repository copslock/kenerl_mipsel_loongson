Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2012 16:59:36 +0200 (CEST)
Received: from smtp-out-072.synserver.de ([212.40.185.72]:1068 "EHLO
        smtp-out-072.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6869016Ab2JDO7XY4Lrl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2012 16:59:23 +0200
Received: (qmail 17542 invoked by uid 0); 4 Oct 2012 14:59:22 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 17355
Received: from p4fe63703.dip.t-dialin.net (HELO ?192.168.0.176?) [79.230.55.3]
  by 217.119.54.81 with AES256-SHA encrypted SMTP; 4 Oct 2012 14:59:19 -0000
Message-ID: <506DA487.9070400@metafoo.de>
Date:   Thu, 04 Oct 2012 17:00:23 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@avionic-design.de>
CC:     linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Shawn Guo <shawn.guo@linaro.org>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bryan Wu <bryan.wu@canonical.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Ashish Jangam <ashish.jangam@kpitcummins.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH] pwm: Get rid of HAVE_PWM
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34601
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 10/04/2012 08:06 AM, Thierry Reding wrote:
> [...]
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 331d574..b38f23d 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -219,7 +219,8 @@ config MACH_JZ4740
>  	select GENERIC_GPIO
>  	select ARCH_REQUIRE_GPIOLIB
>  	select SYS_HAS_EARLY_PRINTK
> -	select HAVE_PWM
> +	select PWM
> +	select PWM_JZ4740
>  	select HAVE_CLK
>  	select GENERIC_IRQ_CHIP

I'm not sure if this is such a good idea, not all jz4740 based board
necessarily require PWM.

- Lars
