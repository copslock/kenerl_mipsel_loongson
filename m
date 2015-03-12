Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2015 05:04:11 +0100 (CET)
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18031 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006539AbbCLEEJzLPKa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Mar 2015 05:04:09 +0100
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com
        id <B550110540000>; Wed, 11 Mar 2015 21:04:36 -0700
Received: from hqemhub02.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Wed, 11 Mar 2015 21:02:30 -0700
X-PGP-Universal: processed;
        by hqnvupgp07.nvidia.com on Wed, 11 Mar 2015 21:02:30 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by hqemhub02.nvidia.com
 (172.20.150.31) with Microsoft SMTP Server (TLS) id 8.3.342.0; Wed, 11 Mar
 2015 21:04:03 -0700
Received: from [10.19.57.128] (10.19.57.128) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 12 Mar
 2015 04:03:42 +0000
Message-ID: <5501101B.1010708@nvidia.com>
Date:   Thu, 12 Mar 2015 13:03:39 +0900
From:   Alexandre Courbot <acourbot@nvidia.com>
Organization: NVIDIA
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Nicolas Schichan <nschichan@freebox.fr>,
        <linux-mips@linux-mips.org>
CC:     Maxime Bizon <mbizon@freebox.fr>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: bcm63xx gpio issue on 3.19
References: <54FDDE00.7030100@freebox.fr> <54FFD15E.3040202@nvidia.com> <5500803A.7080409@freebox.fr>
In-Reply-To: <5500803A.7080409@freebox.fr>
X-NVConfidentiality: public
X-Originating-IP: [10.19.57.128]
X-ClientProxiedBy: HKMAIL103.nvidia.com (10.18.16.12) To
 HKMAIL103.nvidia.com (10.18.16.12)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <acourbot@nvidia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: acourbot@nvidia.com
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

On 03/12/2015 02:49 AM, Nicolas Schichan wrote:
> On 03/11/2015 06:23 AM, Alexandre Courbot wrote:
>>> Could you please advise on how to fix/workaround that ? (ideally while keeping
>>> the possibility to invoke the gpiolib code from the setup/prom code).
>>
>> The only allocation performed by gpiochip_add() is the array of gpio_descs.
>> Having this array pre-allocated in your early code (maybe by using a static
>> array variable) and passing it to a gpiochip_add_early() function would do the
>> trick.
>>
>> However, it is not that simple since gpio_desc is a private structure which
>> details (including its size) are not visible outside of drivers/gpio.
>>
>> Another solution I could see would be to have a kernel config option that
>> would make gpiolib "pre-allocate" a number of gpio descriptors as a static
>> array for such cases - similar to the global GPIO array, but not as big.
>>
>> Finally, we can also restore the global GPIO array as a config option for the
>> few architectures that need it.
>>
>> Of course, I would prefer a solution based on dynamic allocation - is there a
>> kind a primitive memory allocator that we can use at this early stage of boot?
>> I.e. would alloc_pages() maybe work?
>>
>> How do other subsystems that rely on dynamic allocation for registering their
>> resources handle this? I guess regulator must fall in the same use-case,
>> doesn't it?
>
> Hi Alexandre,
>
> Moving the bcm63xx_gpio_init() call from board_prom_init() to
> bcm63xx_register_devices() (an arch_initcall) is enough to get called when
> kmalloc is working. If code poking GPIOs is invoked earlier by a board code,
> it will have to move in the board_register_devices() function though there
> doesn't seem to any problems with the mainline bcm63xx board code in that regard.
>
> I can produce a patch for that if it is an accepted solution. It has the
> advantage of not requiring changes to the gpiolib code.

If that works for you and doesn't break bcm63xx, then yes that would be 
great. GPIO chips are indeed devices, so moving their registration to 
bcm63xx_register_devices() seems to make sense.

The GPIO subsystem might require more dynamic allocations in the near 
future (including maybe when requesting GPIOs), but hopefully all 
consumers will be safe with that. We'll find a solution for early GPIO 
support if they aren't.
