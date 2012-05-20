Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 May 2012 15:21:43 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:35147 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903546Ab2ETNVh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 20 May 2012 15:21:37 +0200
Message-ID: <4FB8EFD2.3080603@openwrt.org>
Date:   Sun, 20 May 2012 15:21:22 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Thomas Langer <thomas.langer@lantiq.com>,
        spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH V4 16/17] SPI: MIPS: lantiq: add FALCON spi driver
References: <1337520014-28787-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1337520014-28787-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 20/05/12 15:20, John Crispin wrote:
> +	master->mode_bits = SPI_MODE_3;
> +	master->num_chipselect = 1;
> +	master->bus_num = -1;
once
> +	master->setup = falcon_sflash_setup;
> +	master->prepare_transfer_hardware = falcon_sflash_prepare_xfer;
> +	master->transfer_one_message = falcon_sflash_xfer_one;
> +	master->unprepare_transfer_hardware = falcon_sflash_unprepare_xfer;
> +	master->dev.of_node = pdev->dev.of_node;
> +	master->bus_num = -1;
twice :-)

sorry ....
