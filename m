Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 16:12:10 +0200 (CEST)
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33062 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993941AbdGGOMDH-PSC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2017 16:12:03 +0200
Received: by mail-yb0-f194.google.com with SMTP id 84so1455242ybe.0;
        Fri, 07 Jul 2017 07:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u3t01Ur1O/WSWBuZyeVzKmFfzCUgdSYv94cxMHTEykU=;
        b=PZj7JLDeTDnAu0TNG7aeGdlozGTr/hjN2VmGNBr+tQ46GAZCSkCIRxSCmvOYQ/WGAC
         ovo3OjA+uF4eW3e2ITVFJdVSyDIM4YJR57AIHNSnWaZ1g2L2tfECfBqqLK0xqVL3/37C
         wC3s+yClYsj31oX/5kB1tiq2dIUzZmOi6InXRm6ZoP5gK44H/jHyjURMc1qyowNW2ZDZ
         nqsF4Wqnttkou75xh5ZK23eSeNTr7StFuOPqm9qb4PpsgesIr2gejIC3lqXr2OSxYAzw
         Bi6AiqDceibdkdqFfgtSpZ8hXP2Ar+yju0o860W07r0kGirWxXviTh8s5+wT48T13r+4
         2BEA==
X-Gm-Message-State: AIVw112zcBVOD9RbfnVLPLsfGXYmFwIdE2Pk47UH8v5RCnTYVZtfjVj4
        jj+g+02jOk5wiE3a/0s=
X-Received: by 10.37.4.208 with SMTP id 199mr4545476ybe.133.1499436717287;
        Fri, 07 Jul 2017 07:11:57 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id d139sm1348674ywe.40.2017.07.07.07.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jul 2017 07:11:56 -0700 (PDT)
Date:   Fri, 7 Jul 2017 09:11:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v7 08/16] MIPS: lantiq: Convert the fpi bus driver to a
 platform_driver
Message-ID: <20170707141155.tcwhiortc2dqnnwa@rob-hp-laptop>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-9-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170702224051.15109-9-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59048
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

On Mon, Jul 03, 2017 at 12:40:43AM +0200, Hauke Mehrtens wrote:
> Instead of hacking the configuration of the FPI bus into the arch code
> add an own bus driver for this internal bus. The FPI bus is the main
> bus of the SoC. This bus driver makes sure the bus is configured
> correctly before the child drivers are getting initialized. This driver
> will probably also be used on different SoC later.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/mips/lantiq/fpi-bus.txt    | 31 ++++++++

Acked-by: Rob Herring <robh@kernel.org>

>  MAINTAINERS                                        |  1 +
>  arch/mips/lantiq/xway/reset.c                      |  4 -
>  arch/mips/lantiq/xway/sysctrl.c                    | 41 ----------
>  drivers/soc/Makefile                               |  1 +
>  drivers/soc/lantiq/Makefile                        |  1 +
>  drivers/soc/lantiq/fpi-bus.c                       | 87 ++++++++++++++++++++++
>  7 files changed, 121 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/fpi-bus.c
