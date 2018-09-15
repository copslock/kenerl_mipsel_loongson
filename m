Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Sep 2018 23:11:43 +0200 (CEST)
Received: from mail-pg1-x544.google.com ([IPv6:2607:f8b0:4864:20::544]:34646
        "EHLO mail-pg1-x544.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992482AbeIOVLj4yCop (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Sep 2018 23:11:39 +0200
Received: by mail-pg1-x544.google.com with SMTP id d19-v6so5935361pgv.1;
        Sat, 15 Sep 2018 14:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bxLvxNoMwHtw6YwJx5GM95sJxHjRjNhted+5Ej+nXq4=;
        b=fR5mcEs6PzwpyZAx5/fnf+CMz1k9X8crYJ1laic0NDuHFxfTpdBLAtkOk/+J7OiMFh
         j+JFoXEacFjHGsHjVSF4EQfvZXGjINbl6BXWuZJ2NQPWxrLfkUEI3K3QSWiDxt0h4wHz
         iqIiId/SANeULkgUNZRw/b9U1EN3IfqjhYh129B7Z5j6KNDRk4q1sK973UrVy2fbuF2I
         JGamQPA2KkHoMoRfgbf4i9WbS8IiFiqvjByGb4H8ZLf82+YWpHPPPUeRxFeGOgp8Q3wP
         Ep7zCSJW3U6syK/txHM/iY8D5saE1GIGD1fSzaBtz9L2yos9M48qq6F1oYYWA2ZJqSw0
         V41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bxLvxNoMwHtw6YwJx5GM95sJxHjRjNhted+5Ej+nXq4=;
        b=XllFhTBnNCaveYrE72bxT+gSsPioTUk8NNBJLGq+5GSlzOnKzV/c2dh+op9zH0BTgH
         YjDIfn6nBTIUcVqebQ+UUtQ/hMUV7lhVv5zNyEKdWowxQYeXIU83VlhpKTIGKmMNBOkY
         AeZaWQGAUYxFQt2DWeaY59LjU/v3kLUo+wO/j8Dn/LMRw7OhgnywkCwSGdHHFnuisn8V
         BqrTqAIoa5upbgUhRfcNhAL1Ek9gtCna6lXkQO8n1lvMVyLdUQgjTkUBZxXihhZw/Ydi
         T8tNuCfStz4aa4D2sSNtcA1kvCofZqyPzAM0MtD6L3+ugg4PQzT+7peTwSwyURmG7U37
         uCzQ==
X-Gm-Message-State: APzg51Ad/JBweDgGRuOsQj4Wr83t1X3r+cLy0ayPTwPVz7HQ/3yMCYes
        bY60ThiC8HIYChoz1GDldex4wcGD
X-Google-Smtp-Source: ANB0VdZPGq6AaGiwAKJIzK5al6qo06INpDbK1Wd/VxmrGUlsnO+niYbIcu0DIH7IuaQ8jD59hbA0TA==
X-Received: by 2002:a62:6781:: with SMTP id t1-v6mr18783357pfj.200.1537045893698;
        Sat, 15 Sep 2018 14:11:33 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id q25-v6sm13920461pfh.113.2018.09.15.14.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:11:32 -0700 (PDT)
Subject: Re: [PATCH net-next v3 09/11] dt-bindings: add constants for
 Microsemi Ocelot SerDes driver
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <73113ea4b3d8d34c05d88413b3d15cc1733cf25e.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ec72decd-6ce9-6a4c-b5c3-7af4d7146551@gmail.com>
Date:   Fri, 14 Sep 2018 19:31:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <73113ea4b3d8d34c05d88413b3d15cc1733cf25e.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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



On 09/14/18 01:16, Quentin Schulz wrote:
> The Microsemi Ocelot has multiple SerDes and requires that the SerDes be
> muxed accordingly to the hardware representation.
> 
> Let's add a constant for each SerDes available in the Microsemi Ocelot.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  include/dt-bindings/phy/phy-ocelot-serdes.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy-ocelot-serdes.h
> 
> diff --git a/include/dt-bindings/phy/phy-ocelot-serdes.h b/include/dt-bindings/phy/phy-ocelot-serdes.h
> new file mode 100644
> index 0000000..cf111ba
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-ocelot-serdes.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/* Copyright (c) 2018 Microsemi Corporation */
> +#ifndef __PHY_OCELOT_SERDES_H__
> +#define __PHY_OCELOT_SERDES_H__
> +
> +#define SERDES1G_0	0
> +#define SERDES1G_1	1
> +#define SERDES1G_2	2
> +#define SERDES1G_3	3
> +#define SERDES1G_4	4
> +#define SERDES1G_5	5
> +#define SERDES1G_MAX	6

Given you use the C preprocessor you could have done something like:

#define SERDES1G(x)	(x)
#define SERDES1G_MAX	5
#define SERDES6G(x)	((x) + SERDES1G_MAX)

etc. but this works for me as well.

> +#define SERDES6G_0	SERDES1G_MAX
> +#define SERDES6G_1	(SERDES1G_MAX + 1)
> +#define SERDES6G_2	(SERDES1G_MAX + 2)
> +#define SERDES6G_MAX	(SERDES1G_MAX + 3)
> +#define SERDES_MAX	(SERDES1G_MAX + SERDES6G_MAX)
> +
> +#endif
> 

-- 
Florian
