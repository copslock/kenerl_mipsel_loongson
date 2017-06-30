Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 14:19:31 +0200 (CEST)
Received: from mail-qt0-x230.google.com ([IPv6:2607:f8b0:400d:c0d::230]:33687
        "EHLO mail-qt0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992160AbdF3MTXawz4M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jun 2017 14:19:23 +0200
Received: by mail-qt0-x230.google.com with SMTP id r30so97076935qtc.0;
        Fri, 30 Jun 2017 05:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ctT/aIxF/XB67tNOIK8KWZl7vfe0m2vJk0ndajbThGY=;
        b=repymkIHhd4/ZGy0SGFJ+3g3AcWeJSvoa9HHk/QT8FptErdHFWT18+uSvOASnSKS02
         I0oIYjvGRR7Q9nDy4h9bEdHAOKwkc/z0pnJ8P5rvppwiQfsNX3SkBtHuW54/MAOF9IAK
         PQJ/Em+r5Od/jm2OyqYvZwFQzpBRdriuPTL+KsE+N5DMvzfhFS8ovxPxMf7phD7TnQoW
         CwjJgRDGPmvZZlpgF82xXpY+Us7JOc3XtKt5Ld1/Vz7+kyvhJjrOMmYDjfr8p0hDIPeG
         i52c9qzo3QoA+hBqErHosLTzYbrQ75+iWdn5iUT7wDgyQwbr/MoH70QJU8w6penKPHx4
         hTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ctT/aIxF/XB67tNOIK8KWZl7vfe0m2vJk0ndajbThGY=;
        b=EDOCHGuSkwuN8QFvDzEN8WPwiKmi9y8DePeSk814bxP9B95AtoapPfYJ3tEHvvKdKe
         ZTAkfoHKSacsZvSb4lhi3eAX2Q95B1LK8kulBOR6uZQoLBlRTHP6CLfndsH+H9SBi6qF
         +InFzg16KJlopMxSmlklQ6bGR5/SdDYs0UxX/vIva3WQm+lmrKJrCNZAzNm0C4BYP4YY
         O5ENnTRUsQwhKVmf28UsTZtFExQn9gml14A6CDYkKNMNa3Stj2+sSsjiPb+aDYrID2tf
         BLP19x210KRxu1oOqDib2aKHg8QR8Oj3hCaHP/RwArnsx31K0TvviOcEtGsXIMo6HiQ4
         X7pg==
X-Gm-Message-State: AKS2vOxm2ssLFtpyb44X5nhSlpeNPMnE2IdgVfWd0uOFqxP6fSMCGKT8
        5FVaJt+G2uAN8LpYKpa3IVt7X9ed8A==
X-Received: by 10.237.33.134 with SMTP id l6mr25577962qtc.165.1498825156800;
 Fri, 30 Jun 2017 05:19:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.137 with HTTP; Fri, 30 Jun 2017 05:19:16 -0700 (PDT)
In-Reply-To: <20170629213951.31176-9-hauke@hauke-m.de>
References: <20170629213951.31176-1-hauke@hauke-m.de> <20170629213951.31176-9-hauke@hauke-m.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Jun 2017 15:19:16 +0300
Message-ID: <CAHp75VeQ=i6LgTaMZeDWdiK-60C9=crBXoGWqQDfP4bsRWd-zA@mail.gmail.com>
Subject: Re: [PATCH v6 08/16] MIPS: lantiq: Convert the fpi bus driver to a platform_driver
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
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

On Fri, Jun 30, 2017 at 12:39 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> Instead of hacking the configuration of the FPI bus into the arch code
> add an own bus driver for this internal bus. The FPI bus is the main
> bus of the SoC. This bus driver makes sure the bus is configured
> correctly before the child drivers are getting initialized. This driver
> will probably also be used on different SoC later.

> +       /* RCU configuration is optional */
> +       rcu_regmap = syscon_regmap_lookup_by_phandle(np, "lantiq,rcu");
> +       if (!IS_ERR_OR_NULL(rcu_regmap)) {

It's still concerning me.

If the API is correctly designed then it should look something like

if (IS_ERR(...))
 return PTR_ERR(...);

if (!...) {
 ...stuff for optional case...
}

> +               ret = device_property_read_u32(dev, "lantiq,offset-endianness",
> +                                          &rcu_ahb_endianness_reg_offset);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "Failed to get RCU reg offset\n");
> +                       return -EINVAL;
> +               }
> +
> +               if (regmap_update_bits(rcu_regmap,
> +                                       rcu_ahb_endianness_reg_offset,
> +                                       RCU_VR9_BE_AHB1S,
> +                                       RCU_VR9_BE_AHB1S))
> +                       dev_warn(&pdev->dev,
> +                               "Failed to configure RCU AHB endianness\n");
> +       }
> +
> +       /* disable fpi burst */
> +       ltq_w32_mask(XBAR_FPI_BURST_EN, 0, xbar_membase + XBAR_ALWAYS_LAST);
> +
> +       return of_platform_populate(dev->of_node, NULL, NULL, dev);
> +}

-- 
With Best Regards,
Andy Shevchenko
