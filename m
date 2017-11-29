Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 17:07:34 +0100 (CET)
Received: from mail-ua0-x244.google.com ([IPv6:2607:f8b0:400c:c08::244]:39984
        "EHLO mail-ua0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbdK2QHXH-tfY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 17:07:23 +0100
Received: by mail-ua0-x244.google.com with SMTP id i92so3722446uad.7;
        Wed, 29 Nov 2017 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=15Qufq6l2XnLA5B+4ZUlPGO3wShWyov5YEsbBLi0Ljc=;
        b=eM/YsrSsjvCtXnZ9+abJTwHeILToMjCsFYjhDtQ6i38TYdl4HzbuJ8GaEsYQuB3mUW
         V0V1hqu1CtUnITZWNmEACAuV27bPL5epsueJnhgM9tsR2Bn6umr4OevPn8e1vGoADA7H
         vA2bnFC2ibkqJz1HMKfVCF030Riq/2J06K8B0A9Q6sgzG12PVJETNj7TMqkBMwTXZGBT
         l6EGkSQpmoLv97X7p/wwEBpWddXy55Ou8BeBA06JwWzL+E/JdLDr49nHEttPcidpEXJ6
         zuVWY4Wg6ncLsm6HFna7h7jbba3cBF1Fq+qbhrNJp+XpX1eLJ1XjxfOZbNRWisfUvTDj
         mMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=15Qufq6l2XnLA5B+4ZUlPGO3wShWyov5YEsbBLi0Ljc=;
        b=GhzH+jCPA9tkyIqNKWa8k4PlImoyRE06XcdyEPIdI2p7STMTaPKJYdR5TlSXVjv9Fn
         MYNSAxE4exbUfg1JjEWYXmHuInFuEK33D6dY8UJrY1gO1vcVGMWYcapycYAfCaYVkL35
         NPnyRvpgFMRvGpsoryaTR7udqgEpAoWFXDUWsvrbsLTUCbNvJ7+uin28CAIlnrwKnOrs
         ZE5s4CpLwunLPrlypdpPwPeBOWWnm8A/kBBQy2DZp8BPLxK2NdLa6IuJe6nMNP+Dw5ra
         hWt6qD2ZPPlJnhqv/bcuxu9mH1F3hnosGowUlLEnOOyDyePXpNAc8p0tJwBhsqUNW9Pq
         AoEQ==
X-Gm-Message-State: AJaThX7NBdODQWb6M19KGJZlvKKqumCqkdCBwBO9KBLfeVhIVLLK/ic+
        oOAas2adlq2lLsle8j+FixH3HtZlZlh7cO/OgPg=
X-Google-Smtp-Source: AGs4zMaUNKo8L23w1B1x+n3L5GoGLsHDtc+XEjYQsKEhnjGXe2pFGs6JI8n1U6+FIFD9/KWaNb165bUydZWiFsRAbqo=
X-Received: by 10.176.9.93 with SMTP id c29mr2360213uah.68.1511971635870; Wed,
 29 Nov 2017 08:07:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.170.13 with HTTP; Wed, 29 Nov 2017 08:07:15 -0800 (PST)
In-Reply-To: <CAFqt6zabdQhyjUc4WsjzJ6CxMr70H3V_JdipJVwRi8LuOG54tA@mail.gmail.com>
References: <20171129005540.28829-1-david.daney@cavium.com>
 <20171129005540.28829-8-david.daney@cavium.com> <CAFqt6zabdQhyjUc4WsjzJ6CxMr70H3V_JdipJVwRi8LuOG54tA@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 29 Nov 2017 21:37:15 +0530
Message-ID: <CAFqt6zZAPxKm663yEHD0Rx2SPye9Nvoax0RMroDQuF8BpZchsA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] netdev: octeon-ethernet: Add Cavium Octeon III support.
To:     David Daney <david.daney@cavium.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
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
X-archive-position: 61191
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

On Wed, Nov 29, 2017 at 4:00 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> On Wed, Nov 29, 2017 at 6:25 AM, David Daney <david.daney@cavium.com> wrote:
>> From: Carlos Munoz <cmunoz@cavium.com>
>>
>> The Cavium OCTEON cn78xx and cn73xx SoCs have network packet I/O
>> hardware that is significantly different from previous generations of
>> the family.

>> diff --git a/drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c b/drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
>> new file mode 100644
>> index 000000000000..4dad35fa4270
>> --- /dev/null
>> +++ b/drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
>> @@ -0,0 +1,2033 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2017 Cavium, Inc.
>> + *
>> + * This file is subject to the terms and conditions of the GNU General Public
>> + * License.  See the file "COPYING" in the main directory of this archive
>> + * for more details.
>> + */
>> +#include <linux/platform_device.h>
>> +#include <linux/netdevice.h>
>> +#include <linux/etherdevice.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_mdio.h>
>> +#include <linux/of_net.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/list.h>
>> +

>> +static void bgx_port_sgmii_set_link_down(struct bgx_port_priv *priv)
>> +{
>> +       u64     data;

>> +       data = oct_csr_read(BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
>> +       data |= BIT(11);
>> +       oct_csr_write(data, BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
>> +       data = oct_csr_read(BGX_GMP_PCS_MISC_CTL(priv->node, priv->bgx, priv->index));
>
> Any particular reason to read immediately after write ?



>> +static int bgx_port_sgmii_set_link_speed(struct bgx_port_priv *priv, struct port_status status)
>> +{
>> +       u64     data;
>> +       u64     prtx;
>> +       u64     miscx;
>> +       int     timeout;
>> +

>> +
>> +       switch (status.speed) {
>> +       case 10:
>
> In my opinion, instead of hard coding the value, is it fine to use ENUM ?
   Similar comments applicable in other places where hard coded values are used.



>> +static int bgx_port_gser_27882(struct bgx_port_priv *priv)
>> +{
>> +       u64     data;
>> +       u64     addr;
>
>> +       int     timeout = 200;
>> +
>> +   //    timeout = 200;
Better to initialize the timeout value


>> +static int bgx_port_qlm_rx_equalization(struct bgx_port_priv *priv, int qlm, int lane)
>> +{
>> +       lmode = oct_csr_read(GSER_LANE_MODE(priv->node, qlm));
>> +       lmode &= 0xf;
>> +       addr = GSER_LANE_P_MODE_1(priv->node, qlm, lmode);
>> +       data = oct_csr_read(addr);
>> +       /* Don't complete rx equalization if in VMA manual mode */
>> +       if (data & BIT(14))
>> +               return 0;
>> +
>> +       /* Apply rx equalization for speed > 6250 */
>> +       if (bgx_port_get_qlm_speed(priv, qlm) < 6250)
>> +               return 0;
>> +
>> +       /* Wait until rx data is valid (CDRLOCK) */
>> +       timeout = 500;
>
> 500 us is the min required value or it can be further reduced ?


>> +static int bgx_port_init_xaui_link(struct bgx_port_priv *priv)
>> +{

>> +
>> +               if (use_ber) {
>> +                       timeout = 10000;
>> +                       do {
>> +                               data =
>> +                               oct_csr_read(BGX_SPU_BR_STATUS1(priv->node, priv->bgx, priv->index));
>> +                               if (data & BIT(0))
>> +                                       break;
>> +                               timeout--;
>> +                               udelay(1);
>> +                       } while (timeout);
>
> In my opinion, it's better to implement similar kind of loops inside macros.
>
>> +                       if (!timeout) {
>> +                               pr_debug("BGX%d:%d:%d: BLK_LOCK timeout\n",
>> +                                        priv->bgx, priv->index, priv->node);
>> +                               return -1;
>> +                       }
>> +               } else {
>> +                       timeout = 10000;
>> +                       do {
>> +                               data =
>> +                               oct_csr_read(BGX_SPU_BX_STATUS(priv->node, priv->bgx, priv->index));
>> +                               if (data & BIT(12))
>> +                                       break;
>> +                               timeout--;
>> +                               udelay(1);
>> +                       } while (timeout);
> same here
