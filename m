Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2018 19:57:10 +0200 (CEST)
Received: from mail-it0-f65.google.com ([209.85.214.65]:51515 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993514AbeGTR5Fnlztm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2018 19:57:05 +0200
Received: by mail-it0-f65.google.com with SMTP id h2-v6so15835535itj.1
        for <linux-mips@linux-mips.org>; Fri, 20 Jul 2018 10:57:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hASqk2pPzUMAl0o1TChs0N9JdyAkF9e6O9TkEJq0Lkk=;
        b=n5+LTB63V4KVqSxjDLqrwhUZv1ErQ4Y3CVaOuuMGcsRo4jXbF0EeSIGjyhVcWC2VGm
         Slot5bhnvp04/IjlClA8Y1xzDxwtIkynAxflzpBDNk4lZMGt7TIkoRi6hWOkhyCHQhj6
         o4zv98jS6xVJ8Jov0KUK5zF8O/vyr5lASryWdkrS4ovsWHj+dg71gF/V1Byr5tlpcBXU
         RNlcqIdy507XlGtNxgjnr3/WegN2yPlz86ksguS4ni+fGw6cQqsD50a8A6wunark9p/K
         NlnnurI1OpQha+/m6N0fC8VKflib3tdfjF8Ppt8H44Yx+twv7RijUHec/C9iEF4hNMZn
         C9Ug==
X-Gm-Message-State: AOUpUlG5Uh3AEULdeSCp3a/0irAllyzZrPv842s8hRuk9MYw3QjFmojA
        9qWeum4sEQMOJpo+8zfl0Q==
X-Google-Smtp-Source: AAOMgpeqNhRiqrMuEYu6TiERWpgWlXdCQqTElRigOz7TBLjuB6TZduD+vw7Tso+dns5t/yo/92I2cA==
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr2653930itc.16.1532109419583;
        Fri, 20 Jul 2018 10:56:59 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b129-v6sm1543763ioa.75.2018.07.20.10.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 10:56:58 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:56:58 -0600
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
Subject: Re: [PATCH 3/5] i2c: designware: add MSCC Ocelot support
Message-ID: <20180720175658.GA2930@rob-hp-laptop>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
 <20180717114837.21839-4-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717114837.21839-4-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64995
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

On Tue, Jul 17, 2018 at 01:48:35PM +0200, Alexandre Belloni wrote:
> The Microsemi Ocelot I2C controller is a designware IP. It also has a
> second set of registers to allow tweaking SDA hold time and spike
> filtering.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../bindings/i2c/i2c-designware.txt           |  5 ++++-
>  drivers/i2c/busses/i2c-designware-core.h      |  1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c   | 20 +++++++++++++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fbb0a6d8b964..7af4176da4af 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -2,7 +2,7 @@
>  
>  Required properties :
>  
> - - compatible : should be "snps,designware-i2c"
> + - compatible : should be "snps,designware-i2c" or "mscc,ocelot-i2c"

Sounds like the registers are optional (or could be initialized by 
firmware), so shouldn't 'snps,designware-i2c' be a fallback compatible?

>   - reg : Offset and length of the register set for the device
>   - interrupts : <IRQ> where IRQ is the interrupt number.
>  
> @@ -11,6 +11,9 @@ Recommended properties :
>   - clock-frequency : desired I2C bus clock frequency in Hz.
>  
>  Optional properties :
> + - reg : for "mscc,ocelot-i2c", a second register set to configure the SDA hold
> +   time, named ICPU_CFG:TWI_DELAY in the datasheet.
> +
>   - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
>     This option is only supported in hardware blocks version 1.11a or newer.

Perhaps this needs an update too? It sounds like Microsemi fixed this 
problem on their own before version 1.11a of the IP block.

Rob
