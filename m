Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2016 16:13:53 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33756 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992991AbcJRONopI70z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Oct 2016 16:13:44 +0200
Received: by mail-oi0-f65.google.com with SMTP id i127so14464319oia.0;
        Tue, 18 Oct 2016 07:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HhBBf4RLWxWrSFbmg88PdePO9cFdmlOhe7zpSpIKTfs=;
        b=DvKc4EXSr+aq85Rn+5mCLrud0pu/I7wtkGb+xO/1F+5KgT0Tk63h6arJ5L2Yxz6QcE
         RmytqRpP5RuXuxGaCMgZFN7OxEs+HNz+jNfCymKAMVoZLrZH6gVYiHwnIGyzKOHCq7KB
         bZWXK6hzRsrXdflZLeTrFVI5s16UsI6a19xeQ3AjOHtWEXRw80nmoFiWK0hz58HLGAeK
         s4aRqnS3FcxZxaT4h9KBRexwivm1y3tJkJL8d37kRMGmtwqR3rdJ4WSKhit0tBXOoT4+
         tT0Bcn2iXWzRpzJC+OgbshUQ1yojxUvWHbLeVV44PzY3jPp19mTEsUOu7N8co/jH72Yl
         rF3g==
X-Gm-Message-State: AA6/9RkVn3dbu/IXdRDAVEH3m2jRUS01vOqUplBCNjLeei+YrzhmvtvwLch0c2zpFDS3xQ==
X-Received: by 10.202.53.68 with SMTP id c65mr552833oia.57.1476800018882;
        Tue, 18 Oct 2016 07:13:38 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id f68sm7544062oic.10.2016.10.18.07.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Oct 2016 07:13:38 -0700 (PDT)
Date:   Tue, 18 Oct 2016 09:13:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rahul Bedarkar <rahul.bedarkar@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Hartley <james.hartley@imgtec.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MIPS: DTS: img: add device tree for Marduk board
Message-ID: <20161018141337.3lardgah2qprqtdx@rob-hp-laptop>
References: <1476424555-22629-1-git-send-email-rahul.bedarkar@imgtec.com>
 <1476424555-22629-2-git-send-email-rahul.bedarkar@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476424555-22629-2-git-send-email-rahul.bedarkar@imgtec.com>
User-Agent: Mutt/1.6.2-neo (2016-08-21)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55489
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

On Fri, Oct 14, 2016 at 11:25:55AM +0530, Rahul Bedarkar wrote:
> Add support for Imagination Technologies' Marduk board which is based
> on Pistachio SoC. It is also known as Creator Ci40. Marduk is legacy
> name and will be there for decades.
> 
> Documentation for this board can be found on
> https://docs.creatordev.io/ci40/
> 
> This patch adds initial support for board with following peripherals:
> 
> * PWM based heartbeat LED
> * GPIO based buttons
> * SPI NOR flash on SPI1
> * UART0 and UART1
> * SD card
> * Ethernet
> * USB
> * PWM
> * ADC
> * I2C
> 
> Signed-off-by: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
> ---
> Changes in v2:
>   - Correct RAM size. It is 256MB instead of 128MB.
>   - Rename nodes pwm_leds -> leds and gpio_keys -> keys (Suggested by Rob Herring)
>   - Don't use '_' in node name for internal_dac_supply (Suggested by Rob Herring)
>   - Add part name in compatible string for spi-nor (Suggested by Rob Herring)
> ---
>  .../bindings/mips/img/pistachio-marduk.txt         |  10 ++
>  MAINTAINERS                                        |   6 +
>  arch/mips/boot/dts/img/Makefile                    |   9 ++
>  arch/mips/boot/dts/img/pistachio_marduk.dts        | 163 +++++++++++++++++++++
>  4 files changed, 188 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/img/pistachio-marduk.txt
>  create mode 100644 arch/mips/boot/dts/img/Makefile
>  create mode 100644 arch/mips/boot/dts/img/pistachio_marduk.dts

Acked-by: Rob Herring <robh@kernel.org>
