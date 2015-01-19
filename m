Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 20:00:11 +0100 (CET)
Received: from mail-we0-f171.google.com ([74.125.82.171]:50936 "EHLO
        mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011712AbbASTAJM0-n1 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jan 2015 20:00:09 +0100
Received: by mail-we0-f171.google.com with SMTP id u56so33094065wes.2
        for <linux-mips@linux-mips.org>; Mon, 19 Jan 2015 11:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:mime-version:content-type:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=TCORzMDqXzr/zYER+tIHbxwB1VAQy2Y7FpOK/IQSxoc=;
        b=ljL5MdI9QdxBMJiS7tdNcyrJ5gBhcGfxC2GJtFExGNDWQE407RNR9g42xgp9wlOErp
         ll1skfIDPsbsRbeKeDakvGxgf9njjx12thsqjKrnI7crWfXBKNQUbQL9VMCjw0QKdg4U
         64X3T9/GzF1vQ620Uqb0wZ3U1z0Bqife5RfE1GmKICODdklNanRzokft96K5uMMT1FYC
         5iVZcLz9j08GBzrAamN0AA39TiogpoC+XET2IV3NZmpHg2FpDLcGNABS0JO9m20GmtYl
         Tf9yUWi42aZ0ORfc43aMmbDmtbQ9wIEExitzwVAd1E4eAZA14M/nYfGOl6vYR0tuXv+L
         X3uw==
X-Gm-Message-State: ALoCoQlu/+St0R2IQefrki4d9WOVFrbvOyepBe6+utryJlhOc3bX2RPqYSIG9bXwx9JrCiao5YtK
X-Received: by 10.181.8.193 with SMTP id dm1mr37579273wid.55.1421694003982;
        Mon, 19 Jan 2015 11:00:03 -0800 (PST)
Received: from [192.168.2.2] ([195.97.110.117])
        by mx.google.com with ESMTPSA id hl1sm18331557wjc.18.2015.01.19.11.00.01
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 Jan 2015 11:00:03 -0800 (PST)
Subject: Re: [PATCH] i2c: drop ancient protection against sysfs refcounting issues
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
From:   Pantelis Antoniou <pantelis.antoniou@konsulko.com>
In-Reply-To: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
Date:   Mon, 19 Jan 2015 20:59:59 +0200
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean Delvare <jdelvare@suse.de>,
        Julia Lawall <julia.lawall@lip6.fr>
Content-Transfer-Encoding: 8BIT
Message-Id: <FDF8BE77-015A-41AD-A5FA-8FFB40AFDAE2@konsulko.com>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
To:     Wolfram Sang <wsa@the-dreams.de>
X-Mailer: Apple Mail (2.1993)
Return-Path: <pantelis.antoniou@konsulko.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pantelis.antoniou@konsulko.com
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

Hi Wolfram,

> On Jan 19, 2015, at 20:55 , Wolfram Sang <wsa@the-dreams.de> wrote:
> 
> Back in the days, sysfs seemed to have refcounting issues and subsystems
> needed a completion to be safe. This is not the case anymore, so I2C can
> get rid of this code. There is noone else besides I2C doing something
> like this currently (checked with the attached coccinelle script which
> checks if a release function exists and if it contains a completion).
> 
> I have been digging through the history of linux.git and
> linux-history.git and found that e.g. w1 used to have such a mechanism
> and also simply removed it later.
> 
> Some more info from Greg Kroah-Hartman:
> "Having that call "wait" for the other release call to happen is really
> old, as Jean points out, from 2003.  We have "fixed" sysfs since then to
> detach the files from the devices easier, we used to have some nasy
> reference count issues in that area."
> 
> And some testing from Jean Delvare which matches my results:
> "However I just tested unloading an i2c bus driver while its adapter's
> new_device attribute was opened and rmmod returned immediately. So it
> doesn't look like accessing sysfs attributes actually takes a reference
> to the underlying i2c_adapter."
> 
> Let's get rid of this code before really nobody knows/understands
> anymore what this was for and if it has a subtle use.
> 

Hehe, rather obliquely tested by me too :)

Please save the reference counter hackers sanity and merge this :)

> Reported-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jean Delvare <jdelvare@suse.de>
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> —
> 
Regards

— Pantelis
From ddaney.cavm@gmail.com Mon Jan 19 20:02:00 2015
Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 20:02:01 +0100 (CET)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:45253 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011718AbbASTCAT8tH3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 20:02:00 +0100
Received: by mail-ie0-f170.google.com with SMTP id y20so7356017ier.1
        for <linux-mips@linux-mips.org>; Mon, 19 Jan 2015 11:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8+DuWpoKpdEQFYL7pj7Ho0q8oDLJ1V9jksyJjH8p6q4=;
        b=B8Or6ijcXsIhhlYfQSo72Ojf1WnXL8jfsgZspkB88V1QFRUIXR5N5BC3ySFUQ3gRF5
         c3y/vvxU9p92TIS0yJIAjBRWZK6afDs8v8USXd7fsniR9xn9Ekjlm18K4Ax7BJmyY1xD
         7fo738qGfoa/fAF77JeRG7/h3EC4OhBz87fU2Isnjola7cEhgxY+oZm8CmbnWAOwF5k6
         lZbtMwTVByq45mrjXt44owujMfso0i+2Z6GpMGn81kOKmrCz62P5h7KBF64R3ZCGlNKZ
         T/OgjarBR886lq8Ob9CgbT17jwft3F2Vp+5TPegCyLqL21x5Avr1MZCyEfYhHXarc5YZ
         +pNg==
X-Received: by 10.50.43.229 with SMTP id z5mr20765967igl.33.1421694114384;
        Mon, 19 Jan 2015 11:01:54 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id e3sm71052igg.16.2015.01.19.11.01.52
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 Jan 2015 11:01:53 -0800 (PST)
Message-ID: <54BD549F.1060309@gmail.com>
Date:   Mon, 19 Jan 2015 11:01:51 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Mark Rutland <mark.rutland@arm.com>,
        Aleksey Makarov <aleksey.makarov@auriga.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Leonid Rosenboim <lrosenboim@caviumnetworks.com>,
        Aaron Williams <aaron.williams@cavium.com>,
        Chandrakala Chavva <cchavva@caviumnetworks.com>,
        Peter Swain <pswain@cavium.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <Pawel.Moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Chris Ball <chris@printf.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] mmc: OCTEON: Add host driver for OCTEON MMC controller
References: <1421675198-30213-1-git-send-email-aleksey.makarov@auriga.com> <20150119142805.GE21553@leverpostej>
In-Reply-To: <20150119142805.GE21553@leverpostej>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Content-Length: 12826
Lines: 362

On 01/19/2015 06:28 AM, Mark Rutland wrote:
> Hi,
>
> On Mon, Jan 19, 2015 at 01:46:36PM +0000, Aleksey Makarov wrote:
>> The OCTEON MMC controller is currently found on cn61XX and cnf71XX
>> devices.  Device parameters are configured from device tree data.
>>
>> Currenly supported are eMMC, MMC and SD devices.
>
> Does that mean there are other devices that this could support in
> future, or that this supports everything it possibly can already?

It is software, so obviously there are some changes that could be made 
to support other devices.  However, the bus host hardware is designed 
such that it can run only certain fixed sequences of the MMC and SD 
protocols.  Therefore it is probable that support for some types of 
devices would be impossible...

>
> [...]
>
>> diff --git a/Documentation/devicetree/bindings/mmc/octeon-mmc.txt b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
>> new file mode 100644
>> index 0000000..ce373cf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
>> @@ -0,0 +1,51 @@
>> +* OCTEON SD/MMC Host Controller
>> +
>> +This controller is present on some members of the Cavium OCTEON SoC
>> +family, provide an interface for eMMC, MMC and SD devices.  There is a
>> +single controller that may have several "slots" connected.  These
>> +slots appear as children of the main controller node.
>> +
>> +Required properties:
>> +- compatible : Should be "cavium,octeon-6130-mmc" or "cavium,octeon-7890-mmc"
>> +- reg : Two entries:
>> +       1) The base address of the MMC controller register bank.
>> +       2) The base address of the MMC DMA engine register bank.
>> +- interrupts : Two entries:
>> +       1) The MMC controller interrupt line.
>> +       2) The MMC DMA engine interrupt line.
>
> Is the DMA engine part of the MMC controller block, or is it a
> separate/generic component that happens to be used in combination with
> the MMC controller?

The DMA engine is an integral part of the MMC bus controller block.

>
>> +- #address-cells : Must be <1>
>> +- #size-cells : Must be <0>
>> +
>> +Required properties of child nodes:
>> +- compatible : Should be "cavium,octeon-6130-mmc-slot".
>> +- reg : The slot number.
>> +- cavium,bus-max-width : The number of data lines present in the slot.
>> +- spi-max-frequency : The maximum operating frequency of the slot.
>> +
>> +Optional properties of child nodes:
>> +- cd-gpios : Specify GPIOs for card detection
>> +- wp-gpios : Specify GPIOs for write protection
>> +- power-gpios : Specify GPIOs for power control
>
> No clocks in the DT?

No.  The reference clock rates can be probed at runtime, so they are not 
specified in the DT.

>
>> +
>> +Example:
>> +       mmc@1180000002000 {
>> +               compatible = "cavium,octeon-6130-mmc";
>> +               reg = <0x11800 0x00002000 0x0 0x100>,
>> +                     <0x11800 0x00000168 0x0 0x20>;
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               /* EMM irq, DMA irq */
>> +               interrupts = <1 19>, <0 63>;
>> +
>> +               /* The board only has a single MMC slot */
>> +               mmc-slot@0 {
>> +                       compatible = "cavium,octeon-6130-mmc-slot";
>> +                       reg = <0>;
>> +                       spi-max-frequency = <20000000>;
>> +                       /* bus width can be 1, 4 or 8 */
>> +                       cavium,bus-max-width = <8>;
>> +                       cd-gpios = <&gpio 9 0>;
>> +                       wp-gpios = <&gpio 10 0>;
>> +                       power-gpios = <&gpio 8 0>;
>> +               };
>> +       };
>
[...]
>> +
>> +/**
>> + * Unlock a single line in the L2 cache.
>> + *
>> + * @addr       Physical address to unlock
>> + *
>> + * Return Zero on success
>> + */
>> +static void l2c_unlock_line(u64 addr)
>> +{
>> +       char *addr_ptr = phys_to_ptr(addr);
>> +       asm volatile (
>> +               "cache 23, %[line]"     /* Unlock the line */
>> +               :: [line] "m" (*addr_ptr));
>> +}
>> +
>> +/**
>> + * Unlock a memory region in the L2 cache
>> + *
>> + * @start - start address to unlock
>> + * @len - length to unlock in bytes
>> + */
>> +static void l2c_unlock_mem_region(u64 start, u64 len)
>> +{
>> +       u64 end;
>> +
>> +       /* Round start/end to cache line boundaries */
>> +       end = ALIGN(start + len - 1, CVMX_CACHE_LINE_SIZE);
>> +       start = ALIGN(start, CVMX_CACHE_LINE_SIZE);
>> +
>> +       while (start <= end) {
>> +               l2c_unlock_line(start);
>> +               start += CVMX_CACHE_LINE_SIZE;
>> +       }
>> +}
>
> Why do you need to mess with the cache in this way within an MMC driver?

Due to an imperfection in the design of the MMC bus hardware, The 2nd. 
to last cache block of a DMA read must be locked into the L2 Cache. 
Otherwise, data corruption may occur.  Please note that this MMC bus 
hardware block is only ever encountered on SoCs where the L2 Cache is 
resident on the same piece of silicon.

> To me it seems somewhat surprising that you need to do that,

Your surprise was shared by many.

> and again
> surprising that you have custom functions within the MMC driver.
>

It is only used by this file, so we decided to put it here to keep 
everything in one place.

> [...]
>
>> +static int octeon_mmc_probe(struct platform_device *pdev)
>> +{
>> +       union cvmx_mio_emm_cfg emm_cfg;
>> +       struct octeon_mmc_host *host;
>> +       struct resource *res;
>> +       void __iomem *base;
>> +       int mmc_irq[9];
>> +       int i;
>> +       int ret = 0;
>> +       struct device_node *node = pdev->dev.of_node;
>> +       int found = 0;
>> +       bool cn78xx_style;
>> +       u64 t;
>> +       enum of_gpio_flags f;
>> +
>> +       host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
>> +       if (!host)
>> +               return -ENOMEM;
>> +
>> +       spin_lock_init(&host->irq_handler_lock);
>> +       sema_init(&host->mmc_serializer, 1);
>> +
>> +       cn78xx_style = of_device_is_compatible(node, "cavium,octeon-7890-mmc");
>> +       if (cn78xx_style) {
>> +               host->need_bootbus_lock = false;
>> +               host->big_dma_addr = true;
>> +               host->need_irq_handler_lock = true;
>> +               /*
>> +                * First seven are the EMM_INT bits 0..6, then two for
>> +                * the EMM_DMA_INT bits
>> +                */
>> +               for (i = 0; i < 9; i++) {
>> +                       mmc_irq[i] = platform_get_irq(pdev, i);
>> +                       if (mmc_irq[i] < 0)
>> +                               return mmc_irq[i];
>
> The documentation describes two interrupts,

The documentation is incorrect for the case of cn78xx_style.  The 
documentation should be (and will be) corrected to reflect what each of 
these lines is used for.

> yet here you try to acquire
> nine. Please document which interrupts you expect (i.e. in what order
> and what the logical function of each is), and when you expect them.
>
> If some interrupts might not always be present, use interrupt-names.
>
[...]
>> +       base = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(base))
>> +               return PTR_ERR(base);
>> +       host->base = (u64)base;
>
> I take it this can only be used on a 64-bit platform?

Yes.

>
[...]
>> +
>> +       platform_set_drvdata(pdev, host);
>> +
>> +       node = of_get_next_child(pdev->dev.of_node, NULL);
>> +       while (node) {
>
> You should use for_each_child_of_node here.
>
> Also, you'll want to skip nodes that aren't compatible with
> "cavium,octeon-6130-mmc-slot", and you'll probably want to log a warning
> in that case.

OK, I think those functions did not exist when the code was originally 
written.  We will try to improve it here.


>
>> +               int r;
>> +               u32 slot;
>> +
>> +               found = 0;
>> +
>> +               r = of_property_read_u32(node, "reg", &slot);
>> +               if (!r) {
>
> If you use for_each_child_of_node, you can just skip ahead in this case,
> rather than having 90% of this block conditional.
>
> e.g.
>
> for_each_child_of_node(pdev->dev.of_node, node) {
> 	
> 	if (!of_device_is_compatible(node, "cavium,octeon-6130-mmc-slot") {
> 		pr_warn("sub node isn't slot: %s\n", of_node_full_name(node));
> 		continue;
> 	}
>
> 	if (of_property_read_u32(node, "reg", &slot) != 0) {
> 		pr_warn("Missing or invalid reg property on %s\n",
> 			of_node_full_name(node));
> 		continue;
> 	}
>
> 	other_stuff();
> 	not_indented();
>
> }
>
>> +                       int ro_gpio, cd_gpio, pwr_gpio;
>> +                       bool ro_low, cd_low, pwr_low;
>> +                       u32 bus_width, max_freq, cmd_skew, dat_skew;
>> +
>> +                       r = of_property_read_u32(node, "cavium,bus-max-width",
>> +                                                &bus_width);
>> +                       if (r) {
>> +                               pr_info("Bus width not found for slot %d\n",
>> +                                       slot);
>> +                               bus_width = 8;
>
> If the default assumption is 8 lanes, document that in the binding.
> Otherwise, make this mandatory and skip the slot if this is missing from
> the DT.
>
>> +                       } else {
>> +                               switch (bus_width) {
>> +                               case 1:
>> +                               case 4:
>> +                               case 8:
>> +                                       break;
>> +                               default:
>> +                                       bus_width = 8;
>> +                                       break;
>> +                               }
>> +                       }
>
> Silently modifying this value is not a good idea. If you get an invalid
> value, warn and skip the node. If the DT was wrong then you have no
> chance of guessing better anyway.
>
>> +
>> +                       r = of_property_read_u32(node, "cavium,cmd-clk-skew",
>> +                                                &cmd_skew);
>> +                       if (r)
>> +                               cmd_skew = 0;
>> +
>> +                       r = of_property_read_u32(node, "cavium,dat-clk-skew",
>> +                                                &dat_skew);
>> +                       if (r)
>> +                               dat_skew = 0;
>> +
>
> These weren't in the binding. They need to be documented.
>
>
>> +                       r = of_property_read_u32(node, "spi-max-frequency",
>> +                                                &max_freq);
>> +                       if (r) {
>> +                               max_freq = 52000000;
>> +                               pr_info("no spi-max-frequency for slot %d, defautling to %d\n",
>
> s/defautling/defaulting/
>
>> +                                       slot, max_freq);
>> +                       }
>> +
>> +                       ro_gpio = of_get_named_gpio_flags(node, "wp-gpios",
>> +                                                         0, &f);
>> +                       ro_low = (ro_gpio >= 0 && f == OF_GPIO_ACTIVE_LOW);
>> +                       cd_gpio = of_get_named_gpio_flags(node, "cd-gpios",
>> +                                                         0, &f);
>> +                       cd_low = (cd_gpio >= 0 && f == OF_GPIO_ACTIVE_LOW);
>> +                       pwr_gpio = of_get_named_gpio_flags(node, "power-gpios",
>> +                                                          0, &f);
>> +                       pwr_low = (pwr_gpio >= 0 && f == OF_GPIO_ACTIVE_LOW);
>> +
>> +                       ret = octeon_init_slot(host, slot, bus_width, max_freq,
>> +                                              ro_gpio, cd_gpio, pwr_gpio,
>> +                                              ro_low, cd_low, pwr_low,
>> +                                              cmd_skew, dat_skew);
>> +                       octeon_mmc_dbg("init slot %d, ret = %d\n", slot, ret);
>> +                       if (ret)
>> +                               goto err;
>> +               }
>> +               node = of_get_next_child(pdev->dev.of_node, node);
>> +       }
>> +
>> +       return ret;
>> +
>> +err:
>> +       /* Disable MMC controller */
>> +       emm_cfg.s.bus_ena = 0;
>> +       cvmx_write_csr(host->base + OCT_MIO_EMM_CFG, emm_cfg.u64);
>> +
>> +       if (host->global_pwr_gpio >= 0) {
>> +               dev_dbg(&pdev->dev, "Global power off\n");
>> +               gpio_set_value_cansleep(host->global_pwr_gpio,
>> +                                       host->global_pwr_gpio_low);
>> +               gpio_free(host->global_pwr_gpio);
>> +       }
>> +
>> +       return ret;
>> +}
>
> It's probably worth having some logging in this error path.
>
> Thanks,
> Mark.
>
>
