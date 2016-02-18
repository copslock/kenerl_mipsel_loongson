Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2016 19:31:31 +0100 (CET)
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36277 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012963AbcBRSb3OaN-u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Feb 2016 19:31:29 +0100
Received: by mail-lf0-f47.google.com with SMTP id 78so38531938lfy.3
        for <linux-mips@linux-mips.org>; Thu, 18 Feb 2016 10:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Gp2BozNAfqnvaKOOc7STX/ScyCjMVDWhw2FrWFuvuE8=;
        b=0vBlwaYKZVtp2PqiCuO7+9iTk4bO083cHN7RSJ2I4cwQnccxDj8jQ7ImB+pHbjUs62
         hay7ZkwwFqMbdmBVoryDAPo6CLnLj9YPg8pRudxwwpMeS+18tjbtk8sOkptJTFEXDnUw
         DJcP11Mqf17tdhWtFfyZSLHvYfzhPdxgdUjXF472XsQshel38Vg8fgsk2QmcDvHMS9P/
         4/Z/bWousLusmRyhDd9UGDGQ9UV8RlGmEB0wG2Wej2qJi1WjiDszNmmJishXXK2y80Kw
         o8P2hlrsPd2zur70EO3R55lzMeSdl9qkNtLWhrvTaR9Y0QX1C4GvokdoU4hQQW5gidsO
         tI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Gp2BozNAfqnvaKOOc7STX/ScyCjMVDWhw2FrWFuvuE8=;
        b=HugOiZb5/EquKCxZHnrRXCjHA0c2+6D6wpJzgv5PvlM4RkYHSJiAqclS6p7LIJNJBB
         ZHKROxWOtUkvkD2K+erE0tYiQYynEvrLFbpk+EID84UdkwG3lMe168mO0Wl4PopR5J0y
         pd01NR79f39vDWrbpf4mzohlFFdbchcHJhH9shU8lUkoIYX1f2QduPts63zmhPgXr7or
         DCQh70NYNqILkJytwVowl55vCXEWywgI/owiRaxj0tisBbWjjf9ob3grpHlYwmYdnTnb
         IVGsRInvX6pU8PEkOIR+v7hOkLNXm3oWprQwVhvoNUrhhd4QXJ64AhUzJrHjvFD9DPV3
         152Q==
X-Gm-Message-State: AG10YOT0Mkj6dDPCiY+AFXLgIx9q+TXXBA5CV+E2xRQBOuWXN8LVeOgDDYwnfdN2wnI0Dg==
X-Received: by 10.25.167.18 with SMTP id q18mr3243092lfe.27.1455820283770;
        Thu, 18 Feb 2016 10:31:23 -0800 (PST)
Received: from wasted.cogentembedded.com ([195.16.111.145])
        by smtp.gmail.com with ESMTPSA id l129sm1086231lfl.18.2016.02.18.10.31.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Feb 2016 10:31:22 -0800 (PST)
Subject: Re: [RFC v5 07/15] usb: ehci: add vbus-gpio parameter
To:     Antony Pavlov <antonynpavlov@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marek Vasut <marex@denx.de>
References: <1455005641-7079-8-git-send-email-antonynpavlov@gmail.com>
 <Pine.LNX.4.44L0.1602181111350.1280-100000@iolanthe.rowland.org>
 <20160218210652.68ae464eed8ddbffd33e7a02@gmail.com>
Cc:     linux-mips@linux-mips.org, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <56C60DF8.1060809@cogentembedded.com>
Date:   Thu, 18 Feb 2016 21:31:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160218210652.68ae464eed8ddbffd33e7a02@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52120
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 02/18/2016 09:06 PM, Antony Pavlov wrote:

>>> This patch retrieves and configures the vbus control gpio via
>>> the device tree.
>>>
>>> This patch is based on a ehci-s5p.c commit fd81d59c90d38661
>>> ("USB: ehci-s5p: Add vbus setup function to the s5p ehci glue layer").
>>>
>>> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
>>> Cc: Alan Stern <stern@rowland.harvard.edu>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: linux-usb@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>   drivers/usb/host/ehci-platform.c | 22 ++++++++++++++++++++++
>>>   1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
>>> index bd7082f2..0d95ced 100644
>>> --- a/drivers/usb/host/ehci-platform.c
>>> +++ b/drivers/usb/host/ehci-platform.c
>>> @@ -28,6 +28,7 @@
>>>   #include <linux/io.h>
>>>   #include <linux/module.h>
>>>   #include <linux/of.h>
>>> +#include <linux/of_gpio.h>
>>>   #include <linux/phy/phy.h>
>>>   #include <linux/platform_device.h>
>>>   #include <linux/reset.h>
>>> @@ -142,6 +143,25 @@ static struct usb_ehci_pdata ehci_platform_defaults = {
>>>   	.power_off =		ehci_platform_power_off,
>>>   };
>>>
>>> +static void setup_vbus_gpio(struct device *dev)
>>> +{
>>> +	int err;
>>> +	int gpio;
>>> +
>>> +	if (!dev->of_node)
>>> +		return;
>>> +
>>> +	gpio = of_get_named_gpio(dev->of_node, "vbus-gpio", 0);
>>> +	if (!gpio_is_valid(gpio))
>>> +		return;
>>> +
>>> +	err = devm_gpio_request_one(dev, gpio,
>>> +				GPIOF_OUT_INIT_HIGH | GPIOF_EXPORT_DIR_FIXED,
>>> +				"ehci_vbus_gpio");
>>> +	if (err)
>>> +		dev_err(dev, "can't request ehci vbus gpio %d", gpio);
>>
>>
>> I don't understand this.  If you get an error here, what's the point of
>> allowing the probe to continue?  Shouldn't you return an error code so
>> the probe will fail?
>
> Please ignore the 'usb: ehci: add vbus-gpio parameter' patch!
>
> In the new AR9331 patchseries I use chipidea USB driver (thanks to Marek for the suggestion)
> in the AR9331 dtsi-file:
>
>          usb: usb@1b000100 {
>                  compatible = "chipidea,usb2";
>                  reg = <0x1b000000 0x200>;
>
>                  interrupt-parent = <&cpuintc>;
>                  interrupts = <3>;
>                  resets = <&rst 5>;
>
>                  phy-names = "usb-phy";
>                  phys = <&usb_phy>;
>
>                  status = "disabled";
>          };
>
>
> so I use regulator in the TL-MR3020 board dts file:
>
>          reg_usb_vbus: reg_usb_vbus {
>                  compatible = "regulator-fixed";
>                  regulator-name = "usb_vbus";
>                  regulator-min-microvolt = <5000000>;

    Not 0?

>                  regulator-max-microvolt = <5000000>;
>                  gpio = <&gpio 8 GPIO_ACTIVE_HIGH>;

    Where's the switch if both voltages are equal?

>                  enable-active-high;
>          };
>
> &usb {
>          dr_mode = "host";
>          vbus-supply = <&reg_usb_vbus>;
>          status = "okay";
> };
>
> As a result there is no need in adding vbus-gpio parameter to ehci anymore!
[...]

MBR, Sergei
