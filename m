Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jan 2013 14:11:39 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:60539 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823555Ab3AaNLiTFMbh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 Jan 2013 14:11:38 +0100
Message-ID: <510A6CEB.4090009@phrozen.org>
Date:   Thu, 31 Jan 2013 14:08:59 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH V3 08/10] MIPS: ralink: adds support for RT305x SoC family
References: <1359633561-4980-1-git-send-email-blogic@openwrt.org> <1359633561-4980-9-git-send-email-blogic@openwrt.org> <510A6C55.5080004@openwrt.org>
In-Reply-To: <510A6C55.5080004@openwrt.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 31/01/13 14:06, Florian Fainelli wrote:
> Hello John,
>
> On 01/31/2013 12:59 PM, John Crispin wrote:
> [snip]
>
>> +
>> +struct ralink_pinmux gpio_pinmux = {
>> + .mode = mode_mux,
>> + .uart = uart_mux,
>> + .uart_shift = RT305X_GPIO_MODE_UART0_SHIFT,
>> + .wdt_reset = rt305x_wdt_reset,
>> +};
>
> It seems to me like the new convention for pinctrl/pinmux etc .. is to
> actually create drivers/pinctrl/pinctrl-ralink.c and
> drivers/pinctrl/pinctrl-rt305x.c, I guess this can be done later when
> you come up with support for the other Ralink SoCs.
> --
> Florian
>
>

Hi,

pinctrl is bloat in this context. the pinmux breaks down to a single 32 
bit register. i did not send the patch yet as i am wanting to make sure 
it works on the new MTK7620 aswell.

	John
