Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2014 13:29:28 +0200 (CEST)
Received: from smtp-out-136.synserver.de ([212.40.185.136]:1141 "EHLO
        smtp-out-136.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817165AbaFIL31A0daC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jun 2014 13:29:27 +0200
Received: (qmail 10595 invoked by uid 0); 9 Jun 2014 11:29:26 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@metafoo.de
X-SynServer-PPID: 10469
Received: from ppp-188-174-15-59.dynamic.mnet-online.de (HELO ?192.168.178.23?) [188.174.15.59]
  by 217.119.54.77 with AES256-SHA encrypted SMTP; 9 Jun 2014 11:29:25 -0000
Message-ID: <53959A93.7080308@metafoo.de>
Date:   Mon, 09 Jun 2014 13:29:23 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
MIME-Version: 1.0
To:     Ben Dooks <ben@trinity.fluff.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        abdoulaye berthe <berthe.ab@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>, m@bues.ch,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        patches@opensource.wolfsonmicro.com,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-samsungsoc@vger.kernel.org, spear-devel@list.st.com,
        platform-driver-x86@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>
Subject: Re: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
References: <20140530094025.3b78301e@canb.auug.org.au> <1401449454-30895-1-git-send-email-berthe.ab@gmail.com> <1401449454-30895-2-git-send-email-berthe.ab@gmail.com> <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com> <5388C0F1.90503@gmail.com> <5388CB1B.3090802@metafoo.de> <20140608231823.GB10112@trinity.fluff.org>
In-Reply-To: <20140608231823.GB10112@trinity.fluff.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40455
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

On 06/09/2014 01:18 AM, Ben Dooks wrote:
> On Fri, May 30, 2014 at 08:16:59PM +0200, Lars-Peter Clausen wrote:
>> On 05/30/2014 07:33 PM, David Daney wrote:
>>> On 05/30/2014 04:39 AM, Geert Uytterhoeven wrote:
>>>> On Fri, May 30, 2014 at 1:30 PM, abdoulaye berthe <berthe.ab@gmail.com>
>>>> wrote:
>>>>> --- a/drivers/gpio/gpiolib.c
>>>>> +++ b/drivers/gpio/gpiolib.c
>>>>> @@ -1263,10 +1263,9 @@ static void gpiochip_irqchip_remove(struct
>>>>> gpio_chip *gpiochip);
>>>>>    *
>>>>>    * A gpio_chip with any GPIOs still requested may not be removed.
>>>>>    */
>>>>> -int gpiochip_remove(struct gpio_chip *chip)
>>>>> +void gpiochip_remove(struct gpio_chip *chip)
>>>>>   {
>>>>>          unsigned long   flags;
>>>>> -       int             status = 0;
>>>>>          unsigned        id;
>>>>>
>>>>>          acpi_gpiochip_remove(chip);
>>>>> @@ -1278,24 +1277,15 @@ int gpiochip_remove(struct gpio_chip *chip)
>>>>>          of_gpiochip_remove(chip);
>>>>>
>>>>>          for (id = 0; id < chip->ngpio; id++) {
>>>>> -               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags)) {
>>>>> -                       status = -EBUSY;
>>>>> -                       break;
>>>>> -               }
>>>>> -       }
>>>>> -       if (status == 0) {
>>>>> -               for (id = 0; id < chip->ngpio; id++)
>>>>> -                       chip->desc[id].chip = NULL;
>>>>> -
>>>>> -               list_del(&chip->list);
>>>>> +               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags))
>>>>> +                       panic("gpio: removing gpiochip with gpios still
>>>>> requested\n");
>>>>
>>>> panic?
>>>
>>> NACK to the patch for this reason.  The strongest thing you should do here
>>> is WARN.
>>>
>>> That said, I am not sure why we need this whole patch set in the first place.
>>
>> Well, what currently happens when you remove a device that is a
>> provider of a gpio_chip which is still in use, is that the kernel
>> crashes. Probably with a rather cryptic error message. So this patch
>> doesn't really change the behavior, but makes it more explicit what
>> is actually wrong. And even if you replace the panic() by a WARN()
>> it will again just crash slightly later.
>>
>> This is a design flaw in the GPIO subsystem that needs to be fixed.
>
> Surely then the best way is to error out to the module unload and
> stop the driver being unloaded?
>

You can't error out on module unload, although that's not really relevant 
here. gpiochip_remove() is typically called when the device that registered 
the GPIO chip is unbound. And despite some remove() callbacks having a 
return type of int you can not abort the removal of a device.

- Lars
