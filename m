Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Oct 2018 11:15:44 +0200 (CEST)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49686 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992747AbeJAJPkfkA6D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Oct 2018 11:15:40 +0200
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61AD37A9;
        Mon,  1 Oct 2018 02:15:33 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E3E33F5B3;
        Mon,  1 Oct 2018 02:15:31 -0700 (PDT)
Subject: Re: [RFC 5/5] MIPS: Add Realtek RTL8186 SoC support
To:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180930141510.2690-1-yasha.che3@gmail.com>
 <20180930141510.2690-6-yasha.che3@gmail.com>
 <a7bba9bd-dab3-4f92-465f-e05beee2b9e3@arm.com>
 <ceced0d550bc30d4f3e66d2c7f569c39ca890ce4.camel@gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <351da67a-b1e6-7972-5c91-0f204690080f@arm.com>
Date:   Mon, 1 Oct 2018 10:15:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ceced0d550bc30d4f3e66d2c7f569c39ca890ce4.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Return-Path: <marc.zyngier@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marc.zyngier@arm.com
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

On 01/10/18 09:48, Yasha Cherikovsky wrote:
> Hi Marc,
> 
> On Mon, 2018-10-01 at 09:19 +0100, Marc Zyngier wrote:
>> Hi Yasha,
>>
>> On 30/09/18 15:15, Yasha Cherikovsky wrote:
>>> The Realtek RTL8186 SoC is a MIPS based SoC
>>> used in some home routers [1][2].
>>>
>>> The hardware includes Lexra LX5280 CPU with a TLB,
>>> two Ethernet controllers, a WLAN controller and more.
>>>
>>> With this patch, it is possible to successfully boot
>>> the kernel and load userspace on the Edimax BR-6204Wg
>>> router.
>>> Network drivers support will come in future patches.
>>>
>>> This patch includes:
>>> - New MIPS rtl8186 platform
>>>       - Core platform setup code (mostly DT based)
>>>       - New Kconfig option
>>>       - defconfig file
>>>       - MIPS zboot UART support
>>> - RTL8186 interrupt controller driver
>>> - RTL8186 timer driver
>>> - Device tree files for the RTL8186 SoC and Edimax BR-6204Wg
>>>     router
>>>
>>> [1] https://www.linux-mips.org/wiki/Realtek_SOC#Realtek_RTL8186
>>> [2] https://wikidevi.com/wiki/Realtek_RTL8186
>>>
>>> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> Cc: Paul Burton <paul.burton@mips.com>
>>> Cc: James Hogan <jhogan@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: linux-mips@linux-mips.org
>>> Cc: devicetree@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>    arch/mips/Kbuild.platforms                    |   1 +
>>>    arch/mips/Kconfig                             |  17 ++
>>>    arch/mips/boot/compressed/uart-16550.c        |   5 +
>>>    arch/mips/boot/dts/Makefile                   |   1 +
>>>    arch/mips/boot/dts/realtek/Makefile           |   4 +
>>>    arch/mips/boot/dts/realtek/rtl8186.dtsi       |  86 +++++++
>>>    .../dts/realtek/rtl8186_edimax_br_6204wg.dts  |  45 ++++
>>>    arch/mips/configs/rtl8186_defconfig           | 112 +++++++++
>>>    arch/mips/include/asm/mach-rtl8186/rtl8186.h  |  37 +++
>>>    arch/mips/rtl8186/Makefile                    |   2 +
>>>    arch/mips/rtl8186/Platform                    |   7 +
>>>    arch/mips/rtl8186/irq.c                       |   8 +
>>>    arch/mips/rtl8186/prom.c                      |  15 ++
>>>    arch/mips/rtl8186/setup.c                     |  80 +++++++
>>>    arch/mips/rtl8186/time.c                      |  10 +
>>>    drivers/clocksource/Kconfig                   |   9 +
>>>    drivers/clocksource/Makefile                  |   1 +
>>>    drivers/clocksource/timer-rtl8186.c           | 220
>>> ++++++++++++++++++
>>>    drivers/irqchip/Kconfig                       |   5 +
>>>    drivers/irqchip/Makefile                      |   1 +
>>>    drivers/irqchip/irq-rtl8186.c                 | 107 +++++++++
>>
>> Could you please split this into at least three patches (arch code,
>> clocksource, irqchip) to ease the review?
>>
>> Thanks,
>>
>> 	M.
> 
> Currently the RTL8186_IRQ and the RTL8186_TIMER Kconfig entries depend on
> MACH_RTL8186 (which is added in the MIPS portion of the same patch).
> Also, MACH_RTL8186 in MIPS selects these two options.
> 
> What is the best way to split that?

It is absolutely fine to have something depending on a non-selectable 
config option, which would allow you to split things up as finely as you 
want. Just have the patch enabling the config option last.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
