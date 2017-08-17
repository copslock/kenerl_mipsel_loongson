Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 17:11:18 +0200 (CEST)
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34216 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994880AbdHQPKZzqIwI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 17:10:25 +0200
Received: by mail-pg0-f65.google.com with SMTP id y192so10337144pgd.1;
        Thu, 17 Aug 2017 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RZjCvUywRiwa3KceJwPq6/dJ6sRoqGb9TSjkwKDg5GA=;
        b=pzO+WkcfEzwnQD6iIwG4gXyBGjmSGi7qqWE18a8SN1qk3ftIJd2kjprYiXytL7OxfS
         VypLNXWOu34STm8g/SevWuwkS7a8bQRucS9b2t9CLUMjbVVfXZxhbKTny5OEhLz8rjoN
         rPYp2tZ8rwYDr5tc4Y2oYgXGL/zmYeeRO//uWrRBHZJNqx9aAhdF6Ouze2YVrRSEnb37
         YOBuaEUMEXzhTounE3k82FlDILV6X5qOsDCjOr8fYh6zSK7o9QqEV7iJatmR0W3PPJrp
         WogfMIf3YS4GjpK50YFel/nfXfSg9n8svEqiZE7J5kyNg1+9kckZOYJDMcxhlx2bJjow
         J/qQ==
X-Gm-Message-State: AHYfb5jMrUa4dHtcTxE0TqwGLkoEDeOIvF/MNx9NMFNuGT1sqbGQ3Mof
        q/akqPjZiw0XQA==
X-Received: by 10.99.3.140 with SMTP id 134mr5350774pgd.159.1502982620144;
        Thu, 17 Aug 2017 08:10:20 -0700 (PDT)
Received: from localhost (mobile-166-170-50-41.mycingular.net. [166.170.50.41])
        by smtp.gmail.com with ESMTPSA id j63sm6341553pge.88.2017.08.17.08.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2017 08:10:19 -0700 (PDT)
Date:   Thu, 17 Aug 2017 10:10:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de, kishon@ti.com, mark.rutland@arm.com
Subject: Re: [PATCH v9 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
Message-ID: <20170817151016.2ujg6v4n7dstydo2@rob-hp-laptop>
References: <20170808225247.32266-1-hauke@hauke-m.de>
 <20170808225247.32266-15-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808225247.32266-15-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Aug 09, 2017 at 12:52:45AM +0200, Hauke Mehrtens wrote:
> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
> the PHY interfaces for each core. The phy instances can be passed to the
> dwc2 driver, which already supports the generic phy interface.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  40 ++++
>  arch/mips/lantiq/xway/sysctrl.c                    |  36 +--
>  drivers/phy/Kconfig                                |   1 +
>  drivers/phy/Makefile                               |   2 +-
>  drivers/phy/lantiq/Kconfig                         |   9 +
>  drivers/phy/lantiq/Makefile                        |   1 +
>  drivers/phy/lantiq/phy-lantiq-rcu-usb2.c           | 254 +++++++++++++++++++++
>  7 files changed, 324 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
>  create mode 100644 drivers/phy/lantiq/Kconfig
>  create mode 100644 drivers/phy/lantiq/Makefile
>  create mode 100644 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> new file mode 100644
> index 000000000000..d8d25063dd5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-lantiq-rcu-usb2.txt
> @@ -0,0 +1,40 @@
> +Lantiq XWAY SoC RCU USB 1.1/2.0 PHY binding
> +===========================================
> +
> +This binding describes the USB PHY hardware provided by the RCU module on the
> +Lantiq XWAY SoCs.
> +
> +This driver has to be a sub node of the Lantiq RCU block.

s/driver/node/

With that,

Acked-by: Rob Herring <robh@kernel.org>
