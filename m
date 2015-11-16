Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2015 00:18:38 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:41105 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012587AbbKPXSeF3Gwc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Nov 2015 00:18:34 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 74C83205E1;
        Mon, 16 Nov 2015 23:18:29 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBEA4204D1;
        Mon, 16 Nov 2015 23:18:27 +0000 (UTC)
Date:   Mon, 16 Nov 2015 17:18:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] devicetree: Add bindings for the ATH79 USB phy
Message-ID: <20151116231825.GA18204@rob-hp-laptop>
References: <1447708924-15076-1-git-send-email-albeu@free.fr>
 <1447708924-15076-3-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1447708924-15076-3-git-send-email-albeu@free.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49956
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

On Mon, Nov 16, 2015 at 10:22:01PM +0100, Alban Bedel wrote:
> Signed-off-by: Alban Bedel <albeu@free.fr>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/phy/phy-ath79-usb.txt          | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-ath79-usb.txt b/Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
> new file mode 100644
> index 0000000..cafe219
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
> @@ -0,0 +1,18 @@
> +* Atheros AR71XX/9XXX USB PHY
> +
> +Required properties:
> +- compatible: "qca,ar7100-usb-phy"
> +- #phys-cells: should be 0
> +- reset-names: "usb-phy"[, "usb-suspend-override"]
> +- resets: references to the reset controllers
> +
> +Example:
> +
> +	usb-phy {
> +		compatible = "qca,ar7100-usb-phy";
> +
> +		reset-names = "usb-phy", "usb-suspend-override";
> +		resets = <&rst 4>, <&rst 3>;
> +
> +		#phy-cells = <0>;
> +	};
> -- 
> 2.0.0
> 
