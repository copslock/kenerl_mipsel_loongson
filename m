Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Mar 2015 06:23:55 +0100 (CET)
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6189 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006515AbbCKFXybH0RG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Mar 2015 06:23:54 +0100
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com
        id <B54ffd18c0000>; Tue, 10 Mar 2015 22:24:28 -0700
Received: from HQMAIL101.nvidia.com ([172.20.187.10])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Tue, 10 Mar 2015 22:21:45 -0700
X-PGP-Universal: processed;
        by hqnvupgp08.nvidia.com on Tue, 10 Mar 2015 22:21:45 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 11 Mar
 2015 05:23:48 +0000
Received: from [10.19.57.128] (10.19.57.128) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 11 Mar
 2015 05:23:43 +0000
Message-ID: <54FFD15E.3040202@nvidia.com>
Date:   Wed, 11 Mar 2015 14:23:42 +0900
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
References: <54FDDE00.7030100@freebox.fr>
In-Reply-To: <54FDDE00.7030100@freebox.fr>
X-NVConfidentiality: public
X-Originating-IP: [10.19.57.128]
X-ClientProxiedBy: DRBGMAIL103.nvidia.com (10.18.16.22) To
 HKMAIL103.nvidia.com (10.18.16.12)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <acourbot@nvidia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46313
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

Hi Nicolas,

(adding the linux-gpio mailing-list and Linus W.)

On 03/10/2015 02:53 AM, Nicolas Schichan wrote:
>
> Hello Alexandre,
>
> Using the latest 3.19 kernel, the bcm63xx GPIO code under
> arch/mips/bcm63xx/gpio.c is unable to register the gpio chip via
> gpiochip_add(), as it returns -ENOMEM. The kcalloc call for the gpio_desc
> array fails, as during prom code, it is too early for the kmalloc to work.
>
> It looks like the issue is caused by your patch: "gpio: remove gpio_descs
> global array"

Indeed. This happens because we removed the global GPIO array and 
replaced it with a more flexible per-chip array of GPIOs. We were hoping 
that issues like this one would have been caught in -next, but sadly the 
problem with bcm63xx went unnoticed until now. :(

>
> Could you please advise on how to fix/workaround that ? (ideally while keeping
> the possibility to invoke the gpiolib code from the setup/prom code).

The only allocation performed by gpiochip_add() is the array of 
gpio_descs. Having this array pre-allocated in your early code (maybe by 
using a static array variable) and passing it to a gpiochip_add_early() 
function would do the trick.

However, it is not that simple since gpio_desc is a private structure 
which details (including its size) are not visible outside of drivers/gpio.

Another solution I could see would be to have a kernel config option 
that would make gpiolib "pre-allocate" a number of gpio descriptors as a 
static array for such cases - similar to the global GPIO array, but not 
as big.

Finally, we can also restore the global GPIO array as a config option 
for the few architectures that need it.

Of course, I would prefer a solution based on dynamic allocation - is 
there a kind a primitive memory allocator that we can use at this early 
stage of boot? I.e. would alloc_pages() maybe work?

How do other subsystems that rely on dynamic allocation for registering 
their resources handle this? I guess regulator must fall in the same 
use-case, doesn't it?
