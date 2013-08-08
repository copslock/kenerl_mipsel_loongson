Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 16:43:14 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.11.231]:35923 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822292Ab3HHOnKaKZk0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Aug 2013 16:43:10 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0CFAC13EF89;
        Thu,  8 Aug 2013 14:43:03 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 009F813F21B; Thu,  8 Aug 2013 14:43:02 +0000 (UTC)
Received: from [192.168.1.103] (99-51-185-173.lightspeed.austtx.sbcglobal.net [99.51.185.173])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: galak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0021113EF89;
        Thu,  8 Aug 2013 14:43:01 +0000 (UTC)
Subject: Re: [PATCH 1/2] DT: Add documentation for gpio-falcon
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Kumar Gala <galak@codeaurora.org>
In-Reply-To: <1375971555-24128-1-git-send-email-blogic@openwrt.org>
Date:   Thu, 8 Aug 2013 09:43:01 -0500
Cc:     Grant Likely <grant.likely@linaro.org>,
        Rob Herring <rob.herring@calxeda.com>,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3A609810-9F8E-4682-A1EC-D98FCEB41E55@codeaurora.org>
References: <1375971555-24128-1-git-send-email-blogic@openwrt.org>
To:     John Crispin <blogic@openwrt.org>
X-Mailer: Apple Mail (2.1283)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <galak@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37478
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


On Aug 8, 2013, at 9:19 AM, John Crispin wrote:

> Describe gpio-falcon binding.

Would be good to have a little more description in the commit message about which SoC this is associated with.

> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> ---
> .../devicetree/bindings/gpio/gpio-falcon.txt       |   25 ++++++++++++++++++++
> 1 file changed, 25 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/gpio/gpio-falcon.txt
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-falcon.txt b/Documentation/devicetree/bindings/gpio/gpio-falcon.txt
> new file mode 100644
> index 0000000..60bc6cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-falcon.txt
> @@ -0,0 +1,25 @@
> +Lantiq Falon SoC GPIO controller bindings
> +
> +Required properties:
> +- compatible:
> +  - "lantiq,falcon-gpio" for Falcon SoC controllers
> +- #gpio-cells : Should be two.
> +  - first cell is the pin number
> +  - second cell is used to specify optional parameters (unused)
> +- gpio-controller : Marks the device node as a GPIO controller
> +- reg : Physical base address and length of the controller's registers
> +- interrupt-parent: phandle to the IM device node that the irq is routed via
> +- interrupts : Specify the IM interrupt number
> +- lantiq,bank : The physical GPIO bank that this block is assiciated with

spelling w/assiciated

> +
> +Example:
> +
> +	gpio0: gpio@810000 {
> +		compatible = "lantiq,falcon-gpio";
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		reg = <0x810000 0x80>;
> +		interrupt-parent = <&icu0>;
> +		interrupts = <44>;
> +		lantiq,bank = <0>;
> +	};

- k

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
