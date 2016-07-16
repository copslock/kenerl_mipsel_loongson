Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Jul 2016 23:36:19 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35769 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992183AbcGPVgMErjbc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Jul 2016 23:36:12 +0200
Received: by mail-oi0-f65.google.com with SMTP id w143so12510917oiw.2;
        Sat, 16 Jul 2016 14:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hReR2T5cu4Cz6rE8jx/jo1WH/A2vpsPsVpxysnLp4sM=;
        b=huFwy3G0MipxatKq+XimiDPTCUOKoCR646YteO2Zm/8t30aJrrHa2D6AKpXgcMQL0C
         8gZtfjnusRMIvbaR6oSrNEhHRSTpTTkE6rvTv6yDuf/Se8HBdqFB7tk5IvXielh5m+2s
         z7tHkcFs+GEJeEOZKUxACPrQ8DV20D0fqzPFJAKkBaIbx7AzupzLam1FkkmzjryFGiY2
         8TL/xNriVyLG+/x1HxpMP0Xklr22IXGrLmq/sPQ4oOt7Xchwe7UtHGkrIZ9dCidKltwn
         3uyRUo1eoymZd/FswF4UwRyS3QtTefk+G9eFBAF15DodOmtzG49r4FlyL/bcd3fz6Bmf
         az8Q==
X-Gm-Message-State: ALyK8tJXS7wpoh7MDjsxAbs22+aXXj4K0PvASEmN381dt7+mXfC9HABBLdtkiPXgLMfuJw==
X-Received: by 10.202.206.198 with SMTP id e189mr11696487oig.160.1468704966249;
        Sat, 16 Jul 2016 14:36:06 -0700 (PDT)
Received: from localhost (c-73-166-181-108.hsd1.tx.comcast.net. [73.166.181.108])
        by smtp.gmail.com with ESMTPSA id d82sm5688391oia.14.2016.07.16.14.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jul 2016 14:36:05 -0700 (PDT)
Date:   Sat, 16 Jul 2016 16:36:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH V8 1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC
 controller.
Message-ID: <20160716213603.GA11441@rob-hp-laptop>
References: <57853472.2050404@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57853472.2050404@cavium.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54340
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

On Tue, Jul 12, 2016 at 01:18:26PM -0500, Steven J. Hill wrote:
> Add Device Tree binding document for Octeon MMC controller. The driver
> is in a following patch. The OCTEON's MMC controller can be connected
> to up to 4 "slots" which may be eMMC, MMC or SD card devices. As there
> is a single controller, each available slot is represented as a child
> node of the controller.
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>
> 
> ---
> v8:
> - Properly documented deprecated device tree properties.
> 
> v7:
> - Rewrote a lot of the document for better readability
> 
> v6:
> - Split up patch
> - Moved device tree fixup to platform code
> ---
> 
> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
> ---
>  .../devicetree/bindings/mmc/octeon-mmc.txt         | 72 ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt

Acked-by: Rob Herring <robh@kernel.org>
