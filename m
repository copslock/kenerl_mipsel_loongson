Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Sep 2017 13:01:04 +0200 (CEST)
Received: from mail-vk0-x242.google.com ([IPv6:2607:f8b0:400c:c05::242]:36237
        "EHLO mail-vk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992121AbdIFLAxQ-pXq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Sep 2017 13:00:53 +0200
Received: by mail-vk0-x242.google.com with SMTP id x85so1786374vkx.3;
        Wed, 06 Sep 2017 04:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jQQkrgmbXGjM7MY4xtmgRxVffHK6Vx4A3J6xg3MatWc=;
        b=slfCXZf2oTJS+7bW1tVo+9JPQZZ+eCj/uusJy/6PVwL7e+Ocwl8CFxFcr38ZhCNY77
         YWF1eJoxwWyOYG3SHfjwPmU3Ojo2jQviJ0JauXi18Ki3PrhjTJ/b5BCBzdvFvGlIckvb
         FOW2rDQ0rJr+fhwdMo/S87IhbE8YIkjOR4fwkZK8EAoXxJ1ckziEzpONYZLkas0eaDsI
         SSFlMXk+P8nrHQtEU5a/SrMN59MYH3HiboB4Buzti28ngtS0eHg+0JRUZh5m8Y1DoilH
         kyPVy5H/XRoFsGPJbN8100XkPDz4bKC4B0GX+B0jw9IMCD7AxcFC0yk5XMZHmZMhNxna
         nh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jQQkrgmbXGjM7MY4xtmgRxVffHK6Vx4A3J6xg3MatWc=;
        b=ugYQcAqqSoSq4174Hlo54FT30gdzPWpJT9DERFUo0Cio3FqwAIvrSf3zTJxg70XM46
         cFRwOuMnGFd49dflYs+FJkCu90stS6dPn42X4gcO0Nzn+kI4SeZvgQhbitSGVsOnZ2s9
         tM2znLrUFgWdvK6lVISWTwgfNWNMG+6Dhvw6XfedbPOcnpgGkNXKDY8JY49U/s8qrkvV
         pokUiHq1hv8IAFq6obL6WD0dOVs2ZAsDUAX2wVr6XaqqW3P7oQ+lz5iY28Z+W57GhsUe
         bCPMDPM27/VehtqUHVwic+kVtU7nk1kbiaOCLblppNcdTIwm9cvdQd/0k6dhQKN0ML/8
         4mCA==
X-Gm-Message-State: AHPjjUggnIHDySq1vafL/Wtcleq8O65mWpF9cB1FCc/ZEG44ZB5G+l2I
        drAtBOBH98LolZju6CLRS+7oD/1s8A==
X-Google-Smtp-Source: ADKCNb5+A2LjlLsK85zH88oX1kK/aOItCXOD1iRLgJvfMsYIckqKJYnsAXjXwIvkUUCFrXvwbppaQfpP2zbduOpn9XQ=
X-Received: by 10.31.4.201 with SMTP id 192mr1254990vke.88.1504695646879; Wed,
 06 Sep 2017 04:00:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.28.81 with HTTP; Wed, 6 Sep 2017 04:00:26 -0700 (PDT)
In-Reply-To: <20170802093429.12572-7-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com> <20170802093429.12572-7-jonas.gorski@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 6 Sep 2017 13:00:26 +0200
Message-ID: <CAOiHx=nvzGybbsTy+y54TetDAQ5zZBLZ3pJh7EVAZM_VbzVS9A@mail.gmail.com>
Subject: Re: [PATCH 6/8] bcm63xx_enet: just use "enet" as the clock name
To:     MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Hi David,

On 2 August 2017 at 11:34, Jonas Gorski <jonas.gorski@gmail.com> wrote:
> Now that we have the individual clocks available as "enet" we
> don't need to rely on the device id for them anymore.
>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Could I please get a (N)Ack so Ralf can add this patch to his tree?


Regards
Jonas

> ---
>  drivers/net/ethernet/broadcom/bcm63xx_enet.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
> index 61a88b64bd39..d6844923a1c0 100644
> --- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
> +++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
> @@ -1718,7 +1718,6 @@ static int bcm_enet_probe(struct platform_device *pdev)
>         struct bcm63xx_enet_platform_data *pd;
>         struct resource *res_mem, *res_irq, *res_irq_rx, *res_irq_tx;
>         struct mii_bus *bus;
> -       const char *clk_name;
>         int i, ret;
>
>         /* stop if shared driver failed, assume driver->probe will be
> @@ -1761,14 +1760,12 @@ static int bcm_enet_probe(struct platform_device *pdev)
>         if (priv->mac_id == 0) {
>                 priv->rx_chan = 0;
>                 priv->tx_chan = 1;
> -               clk_name = "enet0";
>         } else {
>                 priv->rx_chan = 2;
>                 priv->tx_chan = 3;
> -               clk_name = "enet1";
>         }
>
> -       priv->mac_clk = clk_get(&pdev->dev, clk_name);
> +       priv->mac_clk = clk_get(&pdev->dev, "enet");
>         if (IS_ERR(priv->mac_clk)) {
>                 ret = PTR_ERR(priv->mac_clk);
>                 goto out;
> --
> 2.13.2
>
