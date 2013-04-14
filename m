Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Apr 2013 11:43:47 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:39088 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822995Ab3DNJnoZNXj6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 14 Apr 2013 11:43:44 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xJOnEO-6R1UP; Sun, 14 Apr 2013 11:42:55 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id D4EFB281080;
        Sun, 14 Apr 2013 11:42:55 +0200 (CEST)
Message-ID: <516A7A78.7060502@openwrt.org>
Date:   Sun, 14 Apr 2013 11:44:24 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 2/6] DT: add documentation for the Ralink MIPS SoCs
References: <1365843026-11015-1-git-send-email-blogic@openwrt.org> <1365843026-11015-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365843026-11015-2-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.04.13. 10:50 keltezéssel, John Crispin írta:
> From: Gabor Juhos <juhosg@openwrt.org>
> 
> This patch adds binding documentation for the
> compatible values of the Ralink MIPS SoCs.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
>  Documentation/devicetree/bindings/mips/ralink.txt |   17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/ralink.txt
> 
> diff --git a/Documentation/devicetree/bindings/mips/ralink.txt b/Documentation/devicetree/bindings/mips/ralink.txt
> new file mode 100644
> index 0000000..43fc03c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/ralink.txt
> @@ -0,0 +1,17 @@
> +Ralink MIPS SoC device tree bindings
> +
> +1. SoCs
> +
> +Each device tree must specify a compatible value for the Ralink SoC
> +it uses in the compatible property of the root node. The compatible
> +value must be one of the following values:
> +
> +  ralink,rt2880-soc
> +  ralink,rt3050-soc
> +  ralink,rt3052-soc
> +  ralink,rt3350-soc
> +  ralink,rt3352-soc
> +  ralink,rt3883-soc
> +  ralink,rt5350-soc
> +  ralink,mt7620-soc

It seems that I was wrong here. We should have separate entries for the MT7620A
and for the MT7620N varians.

-Gabor
