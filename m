Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 21:58:06 +0100 (CET)
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36761 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013928AbcBXU6EA03rf convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2016 21:58:04 +0100
Received: by mail-pf0-f178.google.com with SMTP id e127so19315459pfe.3
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 12:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=content-type:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=507FrzPVQQyWb9zQ+Sfxys7T7Jk2SnncfsmXibWLgmQ=;
        b=BFRlBhqsOqyym2eXBp2KX2hkvEwEyYRiJAjR8MkFN6a/etscYPH/UJmifiGjsgfule
         yMYAMCNcv/82ysEcNeVJPHUpAnqJ3DlhORV/uGlbqCEo+ImB0FsA0G/7SihO1IZT+AOH
         UMKh6CwnKlMlYMYPzGcOuD14xkNA+uLdcQkLwIDfh/5gMyB/mTQYJcxBizyI2UsuPU+s
         Oh5wJpFXx58gNY5bTKBd/GvE7ZDgLjNtIy39Q/9IbhP6bH4dVzGk1fnIZ0boP81NtAAR
         h9FctX6SNYrPztIl7yZw3Ut9qwreTL2FuXPrajK6CJZHH5Z1B6HHGT05GyyI6JTUwvna
         Fthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version
         :content-transfer-encoding:to:from:in-reply-to:cc:references
         :message-id:user-agent:subject:date;
        bh=507FrzPVQQyWb9zQ+Sfxys7T7Jk2SnncfsmXibWLgmQ=;
        b=QqF5+V+R+SGKN0Tmv+EgrzcbXUj6YNSe+ZUWWcU9eIC1uLEv7kOwkmrW44Fg6xZ1GI
         LHuGCBOQeDWCehbTB9tmBskhZxf3SbqFwAqPS72Cwturwx9gB7cn65wXLziD2Oe8I7iC
         ZDAEdGGPgq8qQevy1Ab4R6kGRd5PsTLRvtNyk5Z8P1aPYqvOvpAogBU0ldBZdN4joafL
         XYrNw0ogB68Dz+e3ORJOTWHN1j8F/BSyfuVC/+dMuTrFcnro5tMd44XRdhMVaEhS/2nl
         8C2BM6d7FeVNoJum2uqZNXlSu8784vG/uxoI93q+PoS00Q3jKNQC7y9Rfit28j6Vhwc2
         /A2A==
X-Gm-Message-State: AG10YOR392GAncVeNcr+kXj9/t/y5iSSgo9UnkyoskdfrNmxdILUZHWJSb6mma8Jd5TqJEst
X-Received: by 10.98.80.150 with SMTP id g22mr57953333pfj.132.1456347478318;
        Wed, 24 Feb 2016 12:57:58 -0800 (PST)
Received: from localhost (cpe-172-248-200-249.socal.res.rr.com. [172.248.200.249])
        by smtp.gmail.com with ESMTPSA id c68sm7049986pfj.41.2016.02.24.12.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Feb 2016 12:57:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Joshua Henderson <joshua.henderson@microchip.com>,
        linux-kernel@vger.kernel.org
From:   Michael Turquette <mturquette@baylibre.com>
In-Reply-To: <1456330090-27226-2-git-send-email-joshua.henderson@microchip.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        "Purna Chandra Mandal" <purna.mandal@microchip.com>,
        "Joshua Henderson" <joshua.henderson@microchip.com>,
        "Stephen Boyd" <sboyd@codeaurora.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Pawel Moll" <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Ian Campbell" <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>, devicetree@vger.kernel.org
References: <1456330090-27226-1-git-send-email-joshua.henderson@microchip.com>
 <1456330090-27226-2-git-send-email-joshua.henderson@microchip.com>
Message-ID: <20160224205758.2278.85870@quark.deferred.io>
User-Agent: alot/0.3.6
Subject: Re: [PATCH v8 1/3] dt/bindings: Add PIC32 clock binding documentation
Date:   Wed, 24 Feb 2016 12:57:58 -0800
Return-Path: <mturquette@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mturquette@baylibre.com
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

Quoting Joshua Henderson (2016-02-24 08:07:15)
> From: Purna Chandra Mandal <purna.mandal@microchip.com>
> 
> Document the devicetree bindings for the clock driver found on Microchip
> PIC32 class devices.
> 
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Michael Turquette <mturquette@baylibre.com>

> ---
> Note: Please pull this complete series through the MIPS tree.
> 
> Changes since v7: None
> Changes since v6:
>         - Update Microchip PIC32 clock binding document based on review
>         - Add header defining clocks
> Changes since v5: None
> Changes since v4: None
> Changes since v3: None
> Changes since v2:
>         - Force lowercase in PIC32 clock binding documentation
> Changes since v1: None
> ---
>  .../devicetree/bindings/clock/microchip,pic32.txt  |   39 ++++++++++++++++++
>  include/dt-bindings/clock/microchip,pic32-clock.h  |   42 ++++++++++++++++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/microchip,pic32.txt
>  create mode 100644 include/dt-bindings/clock/microchip,pic32-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/microchip,pic32.txt b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
> new file mode 100644
> index 0000000..5352718
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/microchip,pic32.txt
> @@ -0,0 +1,39 @@
> +Microchip PIC32 Clock Controller Binding
> +----------------------------------------
> +Microchip clock controller is consists of few oscillators, PLL, multiplexer
> +and few divider modules.
> +
> +This binding uses common clock bindings.
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible: shall be "microchip,pic32mzda-clk".
> +- reg: shall contain base address and length of clock registers.
> +- #clock-cells: shall be 1.
> +
> +Optional properties:
> +- microchip,pic32mzda-sosc: shall be added only if platform has
> +  secondary oscillator connected.
> +
> +Example:
> +       rootclk: clock-controller@1f801200 {
> +               compatible = "microchip,pic32mzda-clk";
> +               reg = <0x1f801200 0x200>;
> +               #clock-cells = <1>;
> +               /* optional */
> +               microchip,pic32mzda-sosc;
> +       };
> +
> +
> +The clock consumer shall specify the desired clock-output of the clock
> +controller (as defined in [2]) by specifying output-id in its "clock"
> +phandle cell.
> +[2] include/dt-bindings/clock/microchip,pic32-clock.h
> +
> +For example for UART2:
> +uart2: serial@2 {
> +       compatible = "microchip,pic32mzda-uart";
> +        reg = <>;
> +       interrupts = <>;
> +       clocks = <&rootclk PB2CLK>;
> +};
> diff --git a/include/dt-bindings/clock/microchip,pic32-clock.h b/include/dt-bindings/clock/microchip,pic32-clock.h
> new file mode 100644
> index 0000000..184647a6
> --- /dev/null
> +++ b/include/dt-bindings/clock/microchip,pic32-clock.h
> @@ -0,0 +1,42 @@
> +/*
> + * Purna Chandra Mandal,<purna.mandal@microchip.com>
> + * Copyright (C) 2015 Microchip Technology Inc.  All rights reserved.
> + *
> + * This program is free software; you can distribute it and/or modify it
> + * under the terms of the GNU General Public License (Version 2) as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + * for more details.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_MICROCHIP_PIC32_H_
> +#define _DT_BINDINGS_CLK_MICROCHIP_PIC32_H_
> +
> +/* clock output indices */
> +#define POSCCLK                0
> +#define FRCCLK         1
> +#define BFRCCLK                2
> +#define LPRCCLK                3
> +#define SOSCCLK                4
> +#define FRCDIVCLK      5
> +#define PLLCLK         6
> +#define SCLK           7
> +#define PB1CLK         8
> +#define PB2CLK         9
> +#define PB3CLK         10
> +#define PB4CLK         11
> +#define PB5CLK         12
> +#define PB6CLK         13
> +#define PB7CLK         14
> +#define REF1CLK                15
> +#define REF2CLK                16
> +#define REF3CLK                17
> +#define REF4CLK                18
> +#define REF5CLK                19
> +#define UPLLCLK                20
> +#define MAXCLKS                21
> +
> +#endif /* _DT_BINDINGS_CLK_MICROCHIP_PIC32_H_ */
> -- 
> 1.7.9.5
> 
