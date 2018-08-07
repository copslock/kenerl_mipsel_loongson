Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2018 19:42:34 +0200 (CEST)
Received: from mail-it0-f67.google.com ([209.85.214.67]:35151 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994711AbeHGRmaWYaQ0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Aug 2018 19:42:30 +0200
Received: by mail-it0-f67.google.com with SMTP id 139-v6so17287232itf.0
        for <linux-mips@linux-mips.org>; Tue, 07 Aug 2018 10:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KeKJnzQOffQOfRtAMyjQsTpNA5n7hdyzcdzP6bVZfls=;
        b=YBz8tde+2N1dnazJk03UlrZ5BTJormO/hm8/IC6IZYSnNz0n42M3rXa5Ac1kZXWkN6
         6tml6XaYAPFG7SpbYkUCt/HsLbB9z+mcFk9t316UAuGzbaVjiccvIOK7APNvgATDE6oJ
         Waru7+0keHgGxRapDU089Y5eMlp5anLN8YcYbOWWnoyKgSLaFLw/kGx3Ff4CG5fSwqY4
         ecvgp0urqdjegP9+YM+7gIs16xyHOorf8Kr8OvJY+LcUxT0Wo4iD2FFRgL23OoK537oy
         ncTrv2nfTvBh6w9/O/F4yIg9nINcj6Dq/ZEnabzn67wNEniZJqfmj4lUFaAcHTqv+gPH
         jcPg==
X-Gm-Message-State: AOUpUlFS5OIQ/r6Mvr7+/I5s3YBtq63+nYX7W3ZcJa3A//+MyUdXJfnp
        +Kl6qGo1ppa3mYx0zbXRRw==
X-Google-Smtp-Source: AA+uWPySPENDMX6MHA4PVFFsHcyOjIXrwPOgxWyDwSHWjEa1qLYLRzL6sFUjx8v7/2qBeJ7rAR7r8Q==
X-Received: by 2002:a24:534c:: with SMTP id n73-v6mr2818748itb.25.1533663744257;
        Tue, 07 Aug 2018 10:42:24 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id c71-v6sm727703ioe.69.2018.08.07.10.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 10:42:23 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:42:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v3 4/6] i2c: designware: add MSCC Ocelot support
Message-ID: <20180807174222.GA5720@rob-hp-laptop>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
 <20180806185412.7210-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806185412.7210-5-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65469
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

On Mon, Aug 06, 2018 at 08:54:10PM +0200, Alexandre Belloni wrote:
> The Microsemi Ocelot I2C controller is a designware IP. It also has a
> second set of registers to allow tweaking SDA hold time and spike
> filtering.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../bindings/i2c/i2c-designware.txt           |  9 ++++-

Please split binding patches.

>  drivers/i2c/busses/i2c-designware-core.h      |  3 ++
>  drivers/i2c/busses/i2c-designware-platdrv.c   | 40 +++++++++++++++++++
>  3 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fbb0a6d8b964..7886f2dc6675 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -2,7 +2,8 @@
>  
>  Required properties :
>  
> - - compatible : should be "snps,designware-i2c"
> + - compatible : should be "snps,designware-i2c" or "mscc,ocelot-i2c" followed by
> +   "snps,designware-i2c" for fallback

Please reformat to one valid combination per line.

>   - reg : Offset and length of the register set for the device
>   - interrupts : <IRQ> where IRQ is the interrupt number.
>  
> @@ -11,8 +12,12 @@ Recommended properties :
>   - clock-frequency : desired I2C bus clock frequency in Hz.
>  
>  Optional properties :
> + - reg : for "mscc,ocelot-i2c", a second register set to configure the SDA hold
> +   time, named ICPU_CFG:TWI_DELAY in the datasheet.
> +
>   - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
> -   This option is only supported in hardware blocks version 1.11a or newer.
> +   This option is only supported in hardware blocks version 1.11a or newer and
> +   on Microsemi SoCs ("mscc,ocelot-i2c" compatible).
>  
>   - i2c-scl-falling-time-ns : should contain the SCL falling time in nanoseconds.
>     This value which is by default 300ns is used to compute the tLOW period.
