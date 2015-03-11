Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 18:49:48 +0100 (CET)
Received: from ns.iliad.fr ([212.27.33.1]:54348 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008511AbbCKRtqt-mqW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Mar 2015 18:49:46 +0100
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id B3C5E20206;
        Wed, 11 Mar 2015 18:49:46 +0100 (CET)
Received: from [192.168.108.32] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id A43561FF49;
        Wed, 11 Mar 2015 18:49:46 +0100 (CET)
Message-ID: <5500803A.7080409@freebox.fr>
Date:   Wed, 11 Mar 2015 18:49:46 +0100
From:   Nicolas Schichan <nschichan@freebox.fr>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Alexandre Courbot <acourbot@nvidia.com>, linux-mips@linux-mips.org
CC:     Maxime Bizon <mbizon@freebox.fr>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: bcm63xx gpio issue on 3.19
References: <54FDDE00.7030100@freebox.fr> <54FFD15E.3040202@nvidia.com>
In-Reply-To: <54FFD15E.3040202@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Wed Mar 11 18:49:46 2015 +0100 (CET)
Return-Path: <nschichan@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nschichan@freebox.fr
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

On 03/11/2015 06:23 AM, Alexandre Courbot wrote:
>> Could you please advise on how to fix/workaround that ? (ideally while keeping
>> the possibility to invoke the gpiolib code from the setup/prom code).
> 
> The only allocation performed by gpiochip_add() is the array of gpio_descs.
> Having this array pre-allocated in your early code (maybe by using a static
> array variable) and passing it to a gpiochip_add_early() function would do the
> trick.
> 
> However, it is not that simple since gpio_desc is a private structure which
> details (including its size) are not visible outside of drivers/gpio.
> 
> Another solution I could see would be to have a kernel config option that
> would make gpiolib "pre-allocate" a number of gpio descriptors as a static
> array for such cases - similar to the global GPIO array, but not as big.
> 
> Finally, we can also restore the global GPIO array as a config option for the
> few architectures that need it.
> 
> Of course, I would prefer a solution based on dynamic allocation - is there a
> kind a primitive memory allocator that we can use at this early stage of boot?
> I.e. would alloc_pages() maybe work?
> 
> How do other subsystems that rely on dynamic allocation for registering their
> resources handle this? I guess regulator must fall in the same use-case,
> doesn't it?

Hi Alexandre,

Moving the bcm63xx_gpio_init() call from board_prom_init() to
bcm63xx_register_devices() (an arch_initcall) is enough to get called when
kmalloc is working. If code poking GPIOs is invoked earlier by a board code,
it will have to move in the board_register_devices() function though there
doesn't seem to any problems with the mainline bcm63xx board code in that regard.

I can produce a patch for that if it is an accepted solution. It has the
advantage of not requiring changes to the gpiolib code.

Regards,

-- 
Nicolas Schichan
Freebox SAS
