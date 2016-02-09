Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 12:25:46 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.10]:58408 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011768AbcBILXkKU8D9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 12:23:40 +0100
Received: from mail.nefkom.net (unknown [192.168.8.184])
        by mail-out.m-online.net (Postfix) with ESMTP id 3q020V3Hrgz3hjZR;
        Tue,  9 Feb 2016 12:23:38 +0100 (CET)
X-Auth-Info: oRhuqclZy14eK3e48CVRhQmDnEK2APICgiqRAl2bw7U=
Received: from chi.localnet (unknown [195.140.253.167])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3q020V1ghrzvhTg;
        Tue,  9 Feb 2016 12:23:38 +0100 (CET)
From:   Marek Vasut <marex@denx.de>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Subject: Re: [RFC v5 05/15] MIPS: dts: qca: introduce AR9331 devicetree
Date:   Tue, 9 Feb 2016 12:12:12 +0100
User-Agent: KMail/1.13.7 (Linux/3.14-2-amd64; KDE/4.13.1; x86_64; ; )
Cc:     linux-mips@linux-mips.org, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>, Gabor Juhos <juhosg@openwrt.org>,
        devicetree@vger.kernel.org
References: <1455005641-7079-1-git-send-email-antonynpavlov@gmail.com> <1455005641-7079-6-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1455005641-7079-6-git-send-email-antonynpavlov@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201602091212.12258.marex@denx.de>
Return-Path: <marex@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51899
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

On Tuesday, February 09, 2016 at 09:13:51 AM, Antony Pavlov wrote:
> This patch introduces devicetree for Atheros AR9331 SoC (AKA Hornet).
> The AR9331 chip is a Wi-Fi System-On-Chip (WiSOC),
> typically used in very cheap Access Points and Routers.
> 
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> Cc: Gabor Juhos <juhosg@openwrt.org>
> Cc: Alban Bedel <albeu@free.fr>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---

[...]

> +			usb: usb@1b000100 {
> +				compatible = "qca,ar7100-ehci", "generic-ehci";
> +				reg = <0x1b000100 0x100>;

It's actually chipidea HDRC , you should bind that driver with it instead.
See for example this:
http://patchwork.linux-mips.org/patch/4968/

> +				interrupt-parent = <&cpuintc>;
> +				interrupts = <3>;
> +				resets = <&rst 5>;
> +
> +				has-transaction-translator;
> +
> +				phy-names = "usb";
> +				phys = <&usb_phy>;
> +
> +				status = "disabled";
> +			};

[...]

Best regards,
Marek Vasut
