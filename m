Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Aug 2017 17:10:17 +0200 (CEST)
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38733 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994867AbdHQPKDpdwtI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Aug 2017 17:10:03 +0200
Received: by mail-pg0-f68.google.com with SMTP id 123so10306462pga.5;
        Thu, 17 Aug 2017 08:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CR7o+X0ODou5a9ff6xF47T144MD8j+hwU+QFL1x5tWI=;
        b=qXUI/NIKGqz4BxW4mmuqAgA4gQJBT2faUNCFrdbL5KbSO3FokHp6mJbbaobw/KnuIF
         wkrVzwVfGLiuq0kBPHD/+z9HGRFol8c754BBvyTM4OWTrTWsGGbPVlgaQcAWChMJadyg
         h/E2DIh3zhN6UBbWnKsjXwWioXrLP059DDfsHyyMA1x4lhG2R0jwZBcuCWjHETk/dIW3
         0e7Ls0JwlgNYk3I4kWre6nJHPOd6lq6cdMl8Dy4lgKrDBHUybOrkHS4cshQ9sjqUSJmR
         3FDECYDWL6yUw5w9xu2bftxKxBdyX3dfnVBxG5pfu4tlJIBn4cbGMdsBV6r1XDXOUFHI
         GUmg==
X-Gm-Message-State: AHYfb5iQjPxPFx30qu21qZOK0QtK+nzoEOMyKmBe8ZfisSkeX+JJkE+U
        SoD6a4Dhh4V6FA==
X-Received: by 10.99.171.13 with SMTP id p13mr5392134pgf.109.1502982597775;
        Thu, 17 Aug 2017 08:09:57 -0700 (PDT)
Received: from localhost (mobile-166-170-50-41.mycingular.net. [166.170.50.41])
        by smtp.gmail.com with ESMTPSA id t80sm7917668pfk.151.2017.08.17.08.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2017 08:09:57 -0700 (PDT)
Date:   Thu, 17 Aug 2017 10:09:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de, kishon@ti.com, mark.rutland@arm.com
Subject: Re: [PATCH v9 05/16] watchdog: lantiq: add device tree binding
 documentation
Message-ID: <20170817133936.omz4s3t36fha3bxe@rob-hp-laptop>
References: <20170808225247.32266-1-hauke@hauke-m.de>
 <20170808225247.32266-6-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808225247.32266-6-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59623
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

On Wed, Aug 09, 2017 at 12:52:36AM +0200, Hauke Mehrtens wrote:
> The binding was not documented before, add the documentation now.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt

Acked-by: Rob Herring <robh@kernel.org>
