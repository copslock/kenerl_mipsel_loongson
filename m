Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 12:25:09 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.9]:55278 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011697AbcBILXjeqRpw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 12:23:39 +0100
Received: from mail.nefkom.net (unknown [192.168.8.184])
        by mail-out.m-online.net (Postfix) with ESMTP id 3q020W3GbWz3hj8L;
        Tue,  9 Feb 2016 12:23:39 +0100 (CET)
X-Auth-Info: oX7+3uB9LjSJeSGWh3Wa6BaDslnCP12abuIzqTR1iTQ=
Received: from chi.localnet (unknown [195.140.253.167])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3q020W1tpgzvdWV;
        Tue,  9 Feb 2016 12:23:39 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Subject: Re: [RFC v5 10/15] MIPS: ath79: add initial support for Dragino MS14 (Dragino 2)
Date:   Tue, 9 Feb 2016 12:16:38 +0100
User-Agent: KMail/1.13.7 (Linux/3.14-2-amd64; KDE/4.13.1; x86_64; ; )
Cc:     linux-mips@linux-mips.org, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, Gabor Juhos <juhosg@openwrt.org>,
        devicetree@vger.kernel.org
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com> <1455005641-7079-11-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1455005641-7079-11-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201602091216.38470.marex@denx.de>
Return-Path: <marex@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51897
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

On Tuesday, February 09, 2016 at 09:13:56 AM, Antony Pavlov wrote:
> The following features are supported:
> 
>   * UART;
>   * SPI-flash;
>   * USB host;
>   * GPIO keys and LEDs.
> 
> Links:
> 
>     * http://www.dragino.com/products/mother-board/item/71-ms14-p.html
>     * https://wiki.openwrt.org/toh/dragino/ms14
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Gabor Juhos <juhosg@openwrt.org>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
>  arch/mips/boot/dts/qca/Makefile         |   1 +
>  arch/mips/boot/dts/qca/dragino_ms14.dts | 101
> ++++++++++++++++++++++++++++++++ 2 files changed, 102 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/qca/Makefile
> b/arch/mips/boot/dts/qca/Makefile index 504c4b1..e949cff 100644
> --- a/arch/mips/boot/dts/qca/Makefile
> +++ b/arch/mips/boot/dts/qca/Makefile
> @@ -1,5 +1,6 @@
>  # All DTBs
>  dtb-$(CONFIG_ATH79)			+= ar9132_tl_wr1043nd_v1.dtb
> +dtb-$(CONFIG_ATH79)			+= dragino_ms14.dtb

ar9331_dragino_ms14.dtb ?

>  dtb-$(CONFIG_ATH79)			+= tl_mr3020.dtb
> 

You should re-order the board additions at the end of the patchset, so you
can then squash the USB DT patch for the mr3020 board into it.

Best regards,
Marek Vasut
