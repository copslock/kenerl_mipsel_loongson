Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Aug 2013 01:35:50 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.11.231]:53613 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6865316Ab3HIXfpqWRg6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Aug 2013 01:35:45 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D46C213EF6E;
        Fri,  9 Aug 2013 23:35:37 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id C59F313F02A; Fri,  9 Aug 2013 23:35:37 +0000 (UTC)
Received: from [192.168.1.103] (99-51-185-173.lightspeed.austtx.sbcglobal.net [99.51.185.173])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: galak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8DD313EF6E;
        Fri,  9 Aug 2013 23:35:36 +0000 (UTC)
Subject: Re: [PATCH 1/2] DT: Add documentation for spi-rt2880
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Kumar Gala <galak@codeaurora.org>
In-Reply-To: <1376074288-29302-1-git-send-email-blogic@openwrt.org>
Date:   Fri, 9 Aug 2013 18:35:33 -0500
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mips@linux-mips.org
Content-Transfer-Encoding: 8BIT
Message-Id: <45FBC491-AAAE-4001-8AAB-160D38F29E52@codeaurora.org>
References: <1376074288-29302-1-git-send-email-blogic@openwrt.org>
To:     John Crispin <blogic@openwrt.org>
X-Mailer: Apple Mail (2.1283)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <galak@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: galak@codeaurora.org
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


On Aug 9, 2013, at 1:51 PM, John Crispin wrote:

> Describe the SPI master found on the MIPS based Ralink SoC.

Ralink RT2880 SoC

> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
> .../devicetree/bindings/spi/spi-rt2880.txt         |   26 ++++++++++++++++++++
> 1 file changed, 26 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/spi/spi-rt2880.txt
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-rt2880.txt b/Documentation/devicetree/bindings/spi/spi-rt2880.txt
> new file mode 100644
> index 0000000..d946626
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-rt2880.txt
> @@ -0,0 +1,26 @@
> +Ralink SoC RT2880 and famile SPI master controller.

famile? was that suppose to be family?

> +
> +Required properties:
> +- compatible : "ralink,rt2880-spi"
> +- reg : The register base for the controller.
> +- #address-cells : <1>, as required by generic SPI binding.
> +- #size-cells : <0>, also as required by generic SPI binding.
> +
> +Child nodes as per the generic SPI binding.
> +
> +Example:
> +
> +	spi@b00 {
> +		compatible = "ralink,rt2880-spi";
> +		reg = <0xb00 0x100>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		m25p80@0 {
> +			compatible = "m25p80";
> +			reg = <0>;
> +			spi-max-frequency = <10000000>;
> +		};
> +	};
> +
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
