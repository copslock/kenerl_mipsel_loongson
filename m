Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 12:24:51 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.9]:52362 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011647AbcBILXjUEVJf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 12:23:39 +0100
Received: from mail.nefkom.net (unknown [192.168.8.184])
        by mail-out.m-online.net (Postfix) with ESMTP id 3q020V5Bmgz3hj77;
        Tue,  9 Feb 2016 12:23:38 +0100 (CET)
X-Auth-Info: oRhuqclZy14eK3e48CVRhQmDnEK2APICgiqRAl2bw7U=
Received: from chi.localnet (unknown [195.140.253.167])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3q020V3mRWzvdWV;
        Tue,  9 Feb 2016 12:23:38 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Subject: Re: [RFC v5 06/15] MIPS: ath79: add initial support for TP-LINK MR3020
Date:   Tue, 9 Feb 2016 12:13:33 +0100
User-Agent: KMail/1.13.7 (Linux/3.14-2-amd64; KDE/4.13.1; x86_64; ; )
Cc:     linux-mips@linux-mips.org, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, Gabor Juhos <juhosg@openwrt.org>,
        devicetree@vger.kernel.org
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com> <1455005641-7079-7-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1455005641-7079-7-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201602091213.33787.marex@denx.de>
Return-Path: <marex@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marex@denx.de
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

On Tuesday, February 09, 2016 at 09:13:52 AM, Antony Pavlov wrote:
> The following features are supported:
> 
>   * UART;
>   * SPI-flash;
>   * GPIO keys and LEDs.
> 
> Links:
> 
>   * http://www.tp-link.com/en/products/details/?model=TL-MR3020
>   * http://wiki.openwrt.org/toh/tp-link/tl-mr3020
>   * https://wikidevi.com/wiki/TP-LINK_TL-MR3020
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Gabor Juhos <juhosg@openwrt.org>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
>  arch/mips/boot/dts/qca/Makefile      |  1 +
>  arch/mips/boot/dts/qca/tl_mr3020.dts | 99
> ++++++++++++++++++++++++++++++++++++ 2 files changed, 100 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/qca/Makefile
> b/arch/mips/boot/dts/qca/Makefile index 14bd225..504c4b1 100644
> --- a/arch/mips/boot/dts/qca/Makefile
> +++ b/arch/mips/boot/dts/qca/Makefile
> @@ -1,5 +1,6 @@
>  # All DTBs
>  dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
> +dtb-$(CONFIG_ATH79)			+= tl_mr3020.dtb

You might want to stay consistent and call it ar9331_tl_mr3020.dtb .

[...]

Best regards,
Marek Vasut
