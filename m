Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 15:49:21 +0100 (CET)
Received: from mail-wi0-f170.google.com ([209.85.212.170]:61240 "EHLO
        mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014015AbaKSOtTxCEXp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 15:49:19 +0100
Received: by mail-wi0-f170.google.com with SMTP id bs8so9716570wib.1
        for <linux-mips@linux-mips.org>; Wed, 19 Nov 2014 06:49:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:subject:to:cc:in-reply-to:references
         :date:message-id;
        bh=jBqG+LvPOC/NeBeise788idCdzYmauqNqolhH/xzpgw=;
        b=SzqTCB1iQEV8iFTxApG0aC0h7b8aLfqGVAuZ/Qd/inuHnmNkw0s56LQQrH7fMcZ/fm
         AO5F1AjtmYipm/V5Lh67h1K6h3AXxZ/TvNb0I9akz7mQ1teHpy0M193I6dp7UfcRxpTa
         8qqLRYfHfp4DkwH3NVMhiuAUDncAM5GvL0RUl3FGPtZCs0Zq9mb1xapAf4iXeIaFp+2l
         QOE6Z6vVZi5iHi6PIS35M6EjiYTfcM/vdW0HC43GYql4tFUvkKcyKxrRhEL3fTYqf3de
         VXbL1lTxf14ZNDUeTS9V1XtxLAXOOXR9xvEJ7b1PuRKOx4QFVVqvYmEjwKS3tNDLiYr0
         j/WA==
X-Gm-Message-State: ALoCoQnrYEa3enY/aXfZiXNeJzDERZTjxInU4fci01+3W5HtfRLYa48J1/JgdpUC9s1ChJCCcwq8
X-Received: by 10.180.8.34 with SMTP id o2mr6212737wia.23.1416408554631;
        Wed, 19 Nov 2014 06:49:14 -0800 (PST)
Received: from trevor.secretlab.ca (host86-166-84-117.range86-166.btcentralplus.com. [86.166.84.117])
        by mx.google.com with ESMTPSA id hk9sm2558432wjb.46.2014.11.19.06.49.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Nov 2014 06:49:13 -0800 (PST)
Received: by trevor.secretlab.ca (Postfix, from userid 1000)
        id 9CA5FC40D73; Wed, 19 Nov 2014 14:49:11 +0000 (GMT)
From:   Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V2 06/10] serial: pxa: Add fifo-size and
 {big,native}-endian properties
To:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        jslaby@suse.cz, robh@kernel.org
Cc:     arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <1415825647-6024-7-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
        <1415825647-6024-7-git-send-email-cernekee@gmail.com>
Date:   Wed, 19 Nov 2014 14:49:11 +0000
Message-Id: <20141119144911.9CA5FC40D73@trevor.secretlab.ca>
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@linaro.org
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

On Wed, 12 Nov 2014 12:54:03 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
> With a few tweaks, the PXA serial driver can handle other 16550A clones.
> Add a fifo-size DT property to override the FIFO depth (BCM7xxx uses 32),
> and {native,big}-endian properties similar to regmap to support SoCs that
> have BE or "automagic endian" registers.

Hold the phone, if these are 16550A clone ports, then why is the pxa
driver being adapted to drive them? I would expect the of_serial.c
driver to be used. It's already got support for multiple variants of the
16550.

g.

> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/tty/serial/pxa.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index 21b7d8b..21406dc 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -60,13 +60,19 @@ struct uart_pxa_port {
>  static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
>  {
>  	offset <<= 2;
> -	return readl(up->port.membase + offset);
> +	if (up->port.iotype == UPIO_MEM32BE)
> +		return ioread32be(up->port.membase + offset);
> +	else
> +		return readl(up->port.membase + offset);
>  }
>  
>  static inline void serial_out(struct uart_pxa_port *up, int offset, int value)
>  {
>  	offset <<= 2;
> -	writel(value, up->port.membase + offset);
> +	if (up->port.iotype == UPIO_MEM32BE)
> +		iowrite32be(value, up->port.membase + offset);
> +	else
> +		writel(value, up->port.membase + offset);
>  }
>  
>  static void serial_pxa_enable_ms(struct uart_port *port)
> @@ -833,6 +839,7 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	int ret;
> +	u32 val;
>  
>  	if (!np)
>  		return 1;
> @@ -843,6 +850,13 @@ static int serial_pxa_probe_dt(struct platform_device *pdev,
>  		return ret;
>  	}
>  	sport->port.line = ret;
> +
> +	if (of_property_read_u32(np, "fifo-size", &val) == 0)
> +		sport->port.fifosize = val;
> +
> +	sport->port.iotype =
> +		of_device_is_big_endian(np) ? UPIO_MEM32BE : UPIO_MEM32;
> +
>  	return 0;
>  }
>  
> -- 
> 2.1.1
> 
