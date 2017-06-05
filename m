Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Jun 2017 20:55:11 +0200 (CEST)
Received: from vps0.lunn.ch ([178.209.37.122]:55947 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992078AbdFESzBDKho7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Jun 2017 20:55:01 +0200
Received: from andrew by vps0.lunn.ch with local (Exim 4.80)
        (envelope-from <andrew@lunn.ch>)
        id 1dHx9P-00024K-9N; Mon, 05 Jun 2017 20:54:51 +0200
Date:   Mon, 5 Jun 2017 20:54:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        linux-mips@linux-mips.org, Eric Dumazet <edumazet@google.com>,
        Jarod Wilson <jarod@redhat.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v4 4/7] net: pch_gbe: Add device tree support
Message-ID: <20170605185451.GE5235@lunn.ch>
References: <20170602234042.22782-1-paul.burton@imgtec.com>
 <20170605173136.10795-1-paul.burton@imgtec.com>
 <20170605173136.10795-5-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170605173136.10795-5-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <andrew@lunn.ch>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58230
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrew@lunn.ch
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

> +static struct pch_gbe_privdata *
> +pch_gbe_get_priv(struct pci_dev *pdev, const struct pci_device_id *pci_id)
> +{
> +	struct pch_gbe_privdata *pdata;
> +	struct gpio_desc *gpio;
> +
> +	if (!IS_ENABLED(CONFIG_OF))
> +		return (struct pch_gbe_privdata *)pci_id->driver_data;

It is possible to enable CONFIG_OF on all architectures, including x86
used by Minnow. If somebody was to do this, i think Minnow breaks. What
i think you really want is:

  	if pci_id->driver_data;
		  return (struct pch_gbe_privdata *)pci_id->driver_data;

> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	gpio = devm_gpiod_get(&pdev->dev, "phy-reset", GPIOD_ASIS);
> +	if (!IS_ERR(gpio))
> +		pdata->phy_reset_gpio = gpio;
> +	else if (PTR_ERR(gpio) != -ENOENT)
> +		return ERR_CAST(gpio);
> +
> +	return pdata;
> +}

There should not be a need to protect for !CONFIG_OF, and
devm_gpiod_get() knows how to look in ACPI tables, if an intel or
ARM64 platform it using that to list its GPIOs.

      Andrew
