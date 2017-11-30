Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 08:12:28 +0100 (CET)
Received: from mail-vk0-x242.google.com ([IPv6:2607:f8b0:400c:c05::242]:45471
        "EHLO mail-vk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990590AbdK3HMVI3JwI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Nov 2017 08:12:21 +0100
Received: by mail-vk0-x242.google.com with SMTP id s141so2806970vkb.12;
        Wed, 29 Nov 2017 23:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S7rXfow10OCouyJ/pHpaed0eyGfCvTUIjkiJCVg33U4=;
        b=OGrofrVrYKhDoJ65daS8z4zENdjjZBXiqnHzcsjT+7yLhbNJ/oHU/SMHTuL/xBQTom
         24ZV0cCSR8BjdZgu4LxFVZ1N1YHFPzveiTomxlb20ukett1RtdD89FpoqPIhJYzZDcRV
         8mRQsh1M4j3Ikv01PJb3uqjH1qdOlMd1LSDghrAt5G4j6Q+ueTX7T26N+zsnr7eX9yF8
         oseA1D612zUEw7lZv7idOAMoFuv7LYM3GSGZ5I3/SzNLeFH4zyivbCDYoU9FNVDqVUy7
         f8Gqu6EEk+dBGkHGlxvmcMfVA2LaaOHs7WCrVLyA9IqzAMdB0Re/eHxLbQkaXlGRc6jU
         60cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S7rXfow10OCouyJ/pHpaed0eyGfCvTUIjkiJCVg33U4=;
        b=WVNeWyOlIBNE4JAE9bKFVhuNMerjRJWJi81uKVT+HgCT++jJQ2drzY+ud36gD8ztf6
         w3eOIamp7cRN4xxyNkjKCe/d9pxcO/g5RBlRS2vK51i8/I0/Abfum3QGtmAzUrRbgHBr
         cUVYIgKuU9LuoRmdn6XoDDrPYwW4wDe/u1+PfttHf/xnOOxTm66yaSoX/CXV2+rK/RU5
         xG3wQUgR8Ahyb/z2/Icf1xWFnhDX6zyV86jW9wba2UOwz5bLWTbFcfMdZ3pqh8Gb70IF
         ezwdg6tcgr0IBjtgSQ+mtFmCuDuyx++vRrWmzueZkB2OZkC91+3/9LjBXv5CSHVb6rXm
         KOQA==
X-Gm-Message-State: AKGB3mLoOoQ6c7uMlt5UfFh/kZNFStDE/xG+u+yHxHceKBYQnW5tik9y
        7FgjR0jZYKQLT8sMEBZteBSheO7/aqKpjQv+ZLw=
X-Google-Smtp-Source: AGs4zMa1ZUylMXA7dkxrjSN1jDGxlhXy0irOdtP/bl96ajLm6I2s8kr8Y5iezpLTP+tfKkZMp4CKMhenw7zSREwFWIE=
X-Received: by 10.31.2.144 with SMTP id 138mr1095553vkc.185.1512025934595;
 Wed, 29 Nov 2017 23:12:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.170.13 with HTTP; Wed, 29 Nov 2017 23:12:13 -0800 (PST)
In-Reply-To: <cef2bbe0-cb06-6938-f665-9840eb67172d@caviumnetworks.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-8-david.daney@cavium.com> <CAFqt6zabdQhyjUc4WsjzJ6CxMr70H3V_JdipJVwRi8LuOG54tA@mail.gmail.com>
 <CAFqt6zZAPxKm663yEHD0Rx2SPye9Nvoax0RMroDQuF8BpZchsA@mail.gmail.com> <cef2bbe0-cb06-6938-f665-9840eb67172d@caviumnetworks.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 30 Nov 2017 12:42:13 +0530
Message-ID: <CAFqt6za-ccO8zXNL6zgt_ZtPyRFpVEGHKWsnipWCiuQkUgYi_Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] netdev: octeon-ethernet: Add Cavium Octeon III support.
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, James Hogan <james.hogan@mips.com>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Carlos Munoz <cmunoz@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jrdr.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jrdr.linux@gmail.com
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

Hi David, Dan,


On Thu, Nov 30, 2017 at 12:50 AM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 11/29/2017 08:07 AM, Souptick Joarder wrote:
>>
>> On Wed, Nov 29, 2017 at 4:00 PM, Souptick Joarder <jrdr.linux@gmail.com>
>> wrote:
>>>
>>> On Wed, Nov 29, 2017 at 6:25 AM, David Daney <david.daney@cavium.com>
>>> wrote:
>>>>
>>>> From: Carlos Munoz <cmunoz@cavium.com>
>>>>
>>>> The Cavium OCTEON cn78xx and cn73xx SoCs have network packet I/O
>>>> hardware that is significantly different from previous generations of
>>>> the family.
>>
>>
>>>> diff --git a/drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
>>>> b/drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
>>>> new file mode 100644
>>>> index 000000000000..4dad35fa4270
>>>> --- /dev/null
>>>> +++ b/drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
>>>> @@ -0,0 +1,2033 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/* Copyright (c) 2017 Cavium, Inc.
>>>> + *
>>>> + * This file is subject to the terms and conditions of the GNU General
>>>> Public
>>>> + * License.  See the file "COPYING" in the main directory of this
>>>> archive
>>>> + * for more details.
>>>> + */
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/netdevice.h>
>>>> +#include <linux/etherdevice.h>
>>>> +#include <linux/of_platform.h>
>>>> +#include <linux/of_address.h>
>>>> +#include <linux/of_mdio.h>
>>>> +#include <linux/of_net.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/slab.h>
>>>> +#include <linux/list.h>
>>>> +
>>
>>
>>>> +static void bgx_port_sgmii_set_link_down(struct bgx_port_priv *priv)
>>>> +{
>>>> +       u64     data;
>>
>>
>>>> +       data = oct_csr_read(BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx,
>>>> priv->index));
>>>> +       data |= BIT(11);
>>>> +       oct_csr_write(data, BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx,
>>>> priv->index));
>>>> +       data = oct_csr_read(BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx,
>>>> priv->index));
>>>
>>>
>>> Any particular reason to read immediately after write ?
>>
>>
>
> Yes, to ensure the write is committed to hardware before the next step.
>
>>
>>
>>>> +static int bgx_port_sgmii_set_link_speed(struct bgx_port_priv *priv,
>>>> struct port_status status)
>>>> +{
>>>> +       u64     data;
>>>> +       u64     prtx;
>>>> +       u64     miscx;
>>>> +       int     timeout;
>>>> +
>>
>>
>>>> +
>>>> +       switch (status.speed) {
>>>> +       case 10:
>>>
>>>
>>> In my opinion, instead of hard coding the value, is it fine to use ENUM ?
>>
>>     Similar comments applicable in other places where hard coded values
>> are used.
>>
>
> There is nothing to be gained by interposing an extra layer of abstraction
> in this case.  The code is more clear with the raw numbers in this
> particular case.

   As mentioned by Andrew,  macros defined in uapi/linux/ethtool.h may
be useful here.
   Otherwise it's fine to me :)
>
>
>>
>>
>>>> +static int bgx_port_gser_27882(struct bgx_port_priv *priv)
>>>> +{
>>>> +       u64     data;
>>>> +       u64     addr;
>>>
>>>
>>>> +       int     timeout = 200;
>>>> +
>>>> +   //    timeout = 200;
>>
>> Better to initialize the timeout value

>
>
> What are you talking about?  It is properly initialized using valid C code.

      I mean, instead of writing

       int     timeout;
       timeout = 200;

      write,

       int timeout = 200;

Anyway both are correct and there is nothing wrong in your code.
Please ignore my comment here.

>
>
>>
>>
>>>> +static int bgx_port_qlm_rx_equalization(struct bgx_port_priv *priv, int
>>>> qlm, int lane)
>>>> +{
>>>> +       lmode = oct_csr_read(GSER_LANE_MODE(priv->node, qlm));
>>>> +       lmode &= 0xf;
>>>> +       addr = GSER_LANE_P_MODE_1(priv->node, qlm, lmode);
>>>> +       data = oct_csr_read(addr);
>>>> +       /* Don't complete rx equalization if in VMA manual mode */
>>>> +       if (data & BIT(14))
>>>> +               return 0;
>>>> +
>>>> +       /* Apply rx equalization for speed > 6250 */
>>>> +       if (bgx_port_get_qlm_speed(priv, qlm) < 6250)
>>>> +               return 0;
>>>> +
>>>> +       /* Wait until rx data is valid (CDRLOCK) */
>>>> +       timeout = 500;
>>>
>>>
>>> 500 us is the min required value or it can be further reduced ?
>>
>>
>
>
> 500 uS works well and is shorter than the 2000 uS from the hardware manual.
>
> If you would like to verify shorter timeout values, we could consider
> merging such a patch.  But really, this doesn't matter as it is a very short
> one-off action when the link is brought up.

   Ok.
>
>>
>>>> +static int bgx_port_init_xaui_link(struct bgx_port_priv *priv)
>>>> +{
>>
>>
>>>> +
>>>> +               if (use_ber) {
>>>> +                       timeout = 10000;
>>>> +                       do {
>>>> +                               data =
>>>> +
>>>> oct_csr_read(BGX_SPU_BR_STATUS1(priv->node, priv->bgx, priv->index));
>>>> +                               if (data & BIT(0))
>>>> +                                       break;
>>>> +                               timeout--;
>>>> +                               udelay(1);
>>>> +                       } while (timeout);
>>>
>>>
>>> In my opinion, it's better to implement similar kind of loops inside
>>> macros.
>
>
> Ok, duly noted.  I think we are in disagreement with respect to this point.


As similar type loops are implemented in many places, so I suggested
to implement those in macros
in header file and include it here.
Anyway if you don't agree with me, I am fine with it :)

>
>
>>>
>>>> +                       if (!timeout) {
>>>> +                               pr_debug("BGX%d:%d:%d: BLK_LOCK
>>>> timeout\n",
>>>> +                                        priv->bgx, priv->index,
>>>> priv->node);
>>>> +                               return -1;
>>>> +                       }
>>>> +               } else {
>>>> +                       timeout = 10000;
>>>> +                       do {
>>>> +                               data =
>>>> +
>>>> oct_csr_read(BGX_SPU_BX_STATUS(priv->node, priv->bgx, priv->index));
>>>> +                               if (data & BIT(12))
>>>> +                                       break;
>>>> +                               timeout--;
>>>> +                               udelay(1);
>>>> +                       } while (timeout);
>>>
>>> same here
>
>
