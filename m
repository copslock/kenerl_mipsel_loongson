Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Aug 2016 19:44:55 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:33161 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992483AbcHZRosQArOJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Aug 2016 19:44:48 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1DCAB61524; Fri, 26 Aug 2016 17:44:47 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 930766034D;
        Fri, 26 Aug 2016 17:44:46 +0000 (UTC)
Date:   Fri, 26 Aug 2016 10:44:46 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org
Subject: Re: [PATCH 24/26] dt-bindings: Document img,boston-clock binding
Message-ID: <20160826174446.GX19826@codeaurora.org>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
 <20160826153725.11629-25-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160826153725.11629-25-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

On 08/26, Paul Burton wrote:
> diff --git a/Documentation/devicetree/bindings/clock/img,boston-clock.txt b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
> new file mode 100644
> index 0000000..c01ea60
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/img,boston-clock.txt
> @@ -0,0 +1,27 @@
> +Binding for Imagination Technologies MIPS Boston clock sources.
> +
> +This binding uses the common clock binding[1].
> +
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible : Should be "img,boston-clock".
> +- #clock-cells : Should be set to 1.
> +  Values available for clock consumers can be found in the header file:
> +    <dt-bindings/clock/boston-clock.h>
> +- regmap : Phandle to the Boston platform register system controller.
> +  This should contain a phandle to the system controller node covering the
> +  platform registers provided by the Boston board.
> +
> +Example:
> +
> +	clk_boston: clock {
> +		compatible = "img,boston-clock";
> +		#clock-cells = <1>;
> +		regmap = <&plat_regs>;

Isn't syscon more standard than regmap as the property name? Is
there a binding for the plat_regs device? Is there any reason the
clks can't be populated in that syscon driver?

> +	};
> +
> +	uart0: uart@17ffe000 {
> +		/* ... */
> +		clocks = <&clk_boston BOSTON_CLK_SYS>;
> +	};

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
