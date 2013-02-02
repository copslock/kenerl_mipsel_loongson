Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Feb 2013 15:20:34 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:60005 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823088Ab3BBOUdtxVfF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Feb 2013 15:20:33 +0100
Message-ID: <510D2012.8070408@phrozen.org>
Date:   Sat, 02 Feb 2013 15:17:54 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/5] MIPS: pci-ar724x: convert into a platform driver
References: <1359808846-23083-1-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1359808846-23083-1-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 02/02/13 13:40, Gabor Juhos wrote:
> +static int ar724x_pci_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int irq;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl_base");
> +	if (!res)
> +		return -EINVAL;
> +
> +	ar724x_pci_ctrl_base = devm_request_and_ioremap(&pdev->dev, res);
> +	if (ar724x_pci_ctrl_base == NULL)
> +		return -EBUSY;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg_base");
> +	if (!res)
> +		return -EINVAL;


Hi,

maybe better use platform_get_resource(pdev, IORESOURCE_MEM, 0/1) ... 
you will otherwise have to patch this again when you convert to OF

	John
