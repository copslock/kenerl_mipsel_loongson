Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Apr 2017 17:42:38 +0200 (CEST)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36342 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993910AbdDTPmawmCeQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Apr 2017 17:42:30 +0200
Received: by mail-oi0-f66.google.com with SMTP id a3so5569959oii.3;
        Thu, 20 Apr 2017 08:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MDA+tHKaHJ057+CxI0sNIlJaLoxqrBW0A+hFuSf9e2w=;
        b=XobsYLfydBD2bpxkYyIjmKOIe0sg04j871SpHJOnux1c3/kGhph5KzK3YBaFehHRwL
         C6qqbbZ5Uq9HSPnC1jxLB2upp1IBKDte6wXHWl2PMGLvgKHb/F4zUX09A7auXUfAxeKr
         Hal2hdykLEWD8jTnjA8S5l2OyT4xdulCBNSlz3PxsGEBRrYPZy7IECbjPYp7WdElOZ1p
         cq9GWzC5AoaHSF4yhpyfm0C8aGf/kWED4CICPFGODAhtRXXfLWYGGnSWJmYsIkIHdAlU
         rjOhYsvU5HlRAOR3254w1fna9pLgZ/7xQTLLoaYrQ09xu1HNka1/eZRytXijQOWDEW3K
         cWOw==
X-Gm-Message-State: AN3rC/5QdMTaQcCWqgfEyldlb0Jc59NMIlDWynnAVgKU985qJp3wE6sv
        TDR6HVVf3PVIZT+LvblERw==
X-Received: by 10.157.6.195 with SMTP id 61mr4459367otx.119.1492702945024;
        Thu, 20 Apr 2017 08:42:25 -0700 (PDT)
Received: from localhost (66-90-148-125.dyn.grandenetworks.net. [66.90.148.125])
        by smtp.gmail.com with ESMTPSA id y74sm2561688oie.23.2017.04.20.08.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Apr 2017 08:42:23 -0700 (PDT)
Date:   Thu, 20 Apr 2017 10:42:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com
Subject: Re: [PATCH 12/13] Documentation: DT: MIPS: lantiq: Add docs for the
 RCU bindings
Message-ID: <20170420154222.wr6njt4kpfmkibh6@rob-hp-laptop>
References: <20170417192942.32219-1-hauke@hauke-m.de>
 <20170417192942.32219-13-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417192942.32219-13-hauke@hauke-m.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57749
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

On Mon, Apr 17, 2017 at 09:29:41PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> This adds the initial documentation for the RCU module (a MFD device
> which provides USB PHYs, reset controllers and more).

This should come before the other patches.

> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 82 ++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> new file mode 100644
> index 000000000000..9e5b1e7493e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> @@ -0,0 +1,82 @@
> +Lantiq XWAY SoC RCU binding
> +===========================
> +
> +This binding describes the RCU (reset controller unit) multifunction device,
> +where each sub-device has it's own set of registers.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: The first and second values must be: "simple-mfd", "syscon"
> +- reg		: The address and length of the system control registers
> +
> +
> +-------------------------------------------------------------------------------
> +Example of the RCU bindings on a xRX200 SoC:
> +	rcu0: rcu@203000 {
> +		compatible = "simple-mfd", "syscon";

Needs an SoC specific compatible string here.

> +		reg = <0x203000 0x100>;
> +		big-endian;
> +
> +		gphy0: rcu_gphy@0 {
> +			compatible = "lantiq,xrx200a2x-rcu-gphy";
> +			lantiq,rcu-syscon = <&rcu0 0x20>;

So these are already child nodes. You can get rid of this and use 
reg/ranges instead.

> +			resets = <&rcu_reset0 31>;
> +			reset-names = "gphy";
> +			lantiq,gphy-mode = <GPHY_MODE_GE>;
> +			clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
> +			clock-names = "gphy";
> +		};
> +
> +		gphy1: rcu_gphy@1 {
> +			compatible = "lantiq,xrx200a2x-rcu-gphy";
> +			lantiq,rcu-syscon = <&rcu0 0x68>;
> +			resets = <&rcu_reset0 29>;
> +			reset-names = "gphy";
> +			lantiq,gphy-mode = <GPHY_MODE_FE>;
> +			clocks = <&pmu0 XRX200_PMU_GATE_GPHY>;
> +			clock-names = "gphy";
> +		};
> +
> +		rcu_reset0: rcu_reset@0 {
> +			compatible = "lantiq,rcu-reset";
> +			lantiq,rcu-syscon = <&rcu0 0x10 0x14>;
> +			#reset-cells = <1>;
> +			reset-request = <31>, <29>, <21>, <19>, <16>, <12>;
> +			reset-status  = <30>, <28>, <16>, <25>, <5>,  <24>;
> +		};
> +
> +		rcu_reset1: rcu_reset@1 {
> +			compatible = "lantiq,rcu-reset";
> +			lantiq,rcu-syscon = <&rcu0 0x48 0x24>;
> +			#reset-cells = <1>;
> +		};
> +
> +		usb_phys0: rcu-usb2-phy@0 {
> +			compatible = "lantiq,xrx200-rcu-usb2-phy";
> +
> +			lantiq,rcu-syscon = <&rcu0 0x18 0x38>;
> +			resets = <&rcu_reset1 4>, <&rcu_reset0 4>;
> +			reset-names = "phy", "ctrl";
> +			#phy-cells = <0>;
> +		};
> +
> +		usb_phys1: rcu-usb2-phy@1 {
> +			compatible = "lantiq,xrx200-rcu-usb2-phy";
> +
> +			lantiq,rcu-syscon = <&rcu0 0x34 0x3C>;
> +			resets = <&rcu_reset1 5>, <&rcu_reset0 4>;
> +			reset-names = "phy", "ctrl";
> +			#phy-cells = <0>;
> +		};
> +
> +		reboot {
> +			compatible = "syscon-reboot";
> +			regmap = <&rcu0>;
> +			offset = <0x10>;
> +			mask = <0x40000000>;
> +		};
> +
> +		/* more sub-device nodes (USB PHY, etc.) */
> +	};
> +
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
