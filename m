Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 22:07:51 +0200 (CEST)
Received: from mail-ua0-x243.google.com ([IPv6:2607:f8b0:400c:c08::243]:45365
        "EHLO mail-ua0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992925AbeG0UHqfSD0u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2018 22:07:46 +0200
Received: by mail-ua0-x243.google.com with SMTP id k8-v6so4118076uaq.12
        for <linux-mips@linux-mips.org>; Fri, 27 Jul 2018 13:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0MgcRcAP3mUa8gnoINN0nmzHrwVW9XBnl67fLELCXeY=;
        b=Q0cUPzN3pb4fcumqalFbZ2Db0u47MyRWffmyaZ2oHwuQXj/xkje6aRPeuzE4a8EpVN
         iNoVMSPR4ySHFtwxe1+Vg3pPn+iDLY+bHLZj7ZY+4oy2qkLReaUwVHwd6F2ghnrQFCxj
         SrSGZi5qzTgLGd3A//X4TwA+vr0naD8ov3ZtHBHf+750OY7HbOggopTuFoplc/PQ2pFY
         48j53bCj6UiQEoDFRJKzJcKgQIjf9qS84QmlDEIE5NrO7xgnArDRabQGcbSoUGFfH+nq
         O0/5f4RvgC1sTv4br3fJcQVraADmoNRMcfzFOzw00lcaOjZUU4qgUN3+3RVp94YDGulB
         FdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0MgcRcAP3mUa8gnoINN0nmzHrwVW9XBnl67fLELCXeY=;
        b=JgYRXEHyvqb3M83JzpLo4tLTz3FUXX3O0NmndVcvrBjW1W+UWZ6RG/iFmcmL2lMDLb
         kKPkW+osuXA5vpvlezxRRNSavXFSOPoWsfV0BmsDBkFEutiLLgXnam5AVq7ZvJJpmlVt
         qeaMbp3auuGKndCxP6TWXuezLz1MwQvf5GNVnntSivxPbEzHtWkwcqqw+972NlXOcwkZ
         i2mWD7/6FyZlfNRdYrNJD5p6yAaVTEHlCEJX1K3cfBwRbIkzk0r0tKnmtH9lmrdXPW9z
         pbguVX3+Xumjr+kvxT2aJeeW4646cFaaHSbsUxLE1FZBi+1Kwgsc4N8Y+v6O8foN9ZNY
         Nk+w==
X-Gm-Message-State: AOUpUlHkY4i0c2nQxmHn/2S0oNrduJ45f/XJUf1MnEYRBcYWVZ4Wnd1G
        pBhJTlY9hFVAU5O3BN3ryAImGprZItmqbQuFk9g=
X-Google-Smtp-Source: AAOMgpcCGDjjbhUyzxqlSmcWi7zNmfIar339PBUkgDqYv8bOH69/k+cU49uLf8b5LdLgU5Qhj/JgO/CfBNGTOJ60GFw=
X-Received: by 2002:a9f:2187:: with SMTP id 7-v6mr5867249uac.49.1532722060371;
 Fri, 27 Jul 2018 13:07:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 13:07:38
 -0700 (PDT)
In-Reply-To: <20180727195358.23336-2-alexandre.belloni@bootlin.com>
References: <20180727195358.23336-1-alexandre.belloni@bootlin.com> <20180727195358.23336-2-alexandre.belloni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Jul 2018 23:07:38 +0300
Message-ID: <CAHp75VeC+3A02eErFmfWix87Zx8Wd6dbAQsmQhoT0VF30do7=Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] spi: dw: export dw_spi_set_cs
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65214
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

On Fri, Jul 27, 2018 at 10:53 PM, Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> Export dw_spi_set_cs so it can be used from the various IP integration
> modules.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/spi/spi-dw.c | 3 ++-
>  drivers/spi/spi-dw.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index f76e31faf694..ac2eb89ef7a5 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -133,7 +133,7 @@ static inline void dw_spi_debugfs_remove(struct dw_spi *dws)
>  }
>  #endif /* CONFIG_DEBUG_FS */
>
> -static void dw_spi_set_cs(struct spi_device *spi, bool enable)
> +void dw_spi_set_cs(struct spi_device *spi, bool enable)
>  {
>         struct dw_spi *dws = spi_controller_get_devdata(spi->controller);
>         struct chip_data *chip = spi_get_ctldata(spi);
> @@ -145,6 +145,7 @@ static void dw_spi_set_cs(struct spi_device *spi, bool enable)
>         if (!enable)
>                 dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
>  }
> +EXPORT_SYMBOL_GPL(dw_spi_set_cs);
>
>  /* Return the max entries we can fill into tx fifo */
>  static inline u32 tx_max(struct dw_spi *dws)
> diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
> index 446013022849..0168b08364d5 100644
> --- a/drivers/spi/spi-dw.h
> +++ b/drivers/spi/spi-dw.h
> @@ -245,6 +245,7 @@ struct dw_spi_chip {
>         void (*cs_control)(u32 command);
>  };
>
> +extern void dw_spi_set_cs(struct spi_device *spi, bool enable);
>  extern int dw_spi_add_host(struct device *dev, struct dw_spi *dws);
>  extern void dw_spi_remove_host(struct dw_spi *dws);
>  extern int dw_spi_suspend_host(struct dw_spi *dws);
> --
> 2.18.0
>



-- 
With Best Regards,
Andy Shevchenko
