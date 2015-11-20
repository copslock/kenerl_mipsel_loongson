Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2015 15:26:59 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011571AbbKTO0zxCtMF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Nov 2015 15:26:55 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 212692041A;
        Fri, 20 Nov 2015 14:26:49 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78719203AE;
        Fri, 20 Nov 2015 14:26:42 +0000 (UTC)
Date:   Fri, 20 Nov 2015 08:26:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Schiller <mschiller@tdt.de>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linus.walleij@linaro.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        ralf@linux-mips.org, blogic@openwrt.org, hauke@hauke-m.de,
        jogo@openwrt.org
Subject: Re: [PATCH 1/4] pinctrl/lantiq: update devicetree bindings
 Documentation
Message-ID: <20151120142640.GA3348@rob-hp-laptop>
References: <1447995151-3857-1-git-send-email-mschiller@tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1447995151-3857-1-git-send-email-mschiller@tdt.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Fri, Nov 20, 2015 at 05:52:28AM +0100, Martin Schiller wrote:
> This patch adds the new dedicated "lantiq,pinctrl-<chip>" compatible strings
> to the devicetree bindings Documentation, where <chip> is one of "ase",
> "danube", "xrx100", "xrx200" or "xrx300" and marks the "lantiq,pinctrl-xway"
> and "lantiq,pinctrl-xr9" compatible strings as DEPRECATED.

This could use a better subject. Every change to bindings are "updating 
binding description."

> 
> Signed-off-by: Martin Schiller <mschiller@tdt.de>
> ---
>  .../bindings/pinctrl/lantiq,pinctrl-xway.txt       | 108 +++++++++++++++++++--
>  1 file changed, 100 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt b/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt
> index e89b467..16daa12 100644
> --- a/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/lantiq,pinctrl-xway.txt
> @@ -1,7 +1,14 @@
>  Lantiq XWAY pinmux controller
>  
>  Required properties:
> -- compatible: "lantiq,pinctrl-xway" or "lantiq,pinctrl-xr9"
> +- compatible: "lantiq,pinctrl-xway", (DEPRECATED: Use XWAY DANUBE Family)
> +	      "lantiq,pinctrl-xr9", (DEPRECATED: Use XWAY xRX100/xRX200 Family)
> +	      "lantiq,pinctrl-<chip>", where <chip> is:

<chip> first is preferred: lantiq,<chip>-pinctrl

> +		"ase" (XWAY AMAZON Family)
> +		"danube" (XWAY DANUBE Family)
> +		"xrx100" (XWAY xRX100 Family)
> +		"xrx200" (XWAY xRX200 Family)
> +		"xrx300" (XWAY xRX300 Family)
