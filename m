Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 02:29:13 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35849 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010061AbcAGB3MZOlIw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 02:29:12 +0100
Received: by mail-pa0-f54.google.com with SMTP id yy13so152349624pab.3
        for <linux-mips@linux-mips.org>; Wed, 06 Jan 2016 17:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4akNFMNwTg6jH4K6vVfY3lT2G35rzkwoOZ52xvvxS9o=;
        b=DllwYGLAc9heSPGiDsbGISs/mr7QwdR73PB16kAnRw+x42GxGqMItHr0hhfFoE3jc1
         BZvx6K8uIC1YVIW4is/3pKp2MKiXtqvxApZoirO0VAYgpeBde/3WqD9WFAvxeR9Xh4SO
         083O0VnWxeTl4fbup1vyB2lRpXAR6PkOrSJF/XwXLwJ/injX+Nt+oL8I2EFLAq7k3ddN
         nJDtydTzQ7/HGCO/2v0n7VCcPRdzTeiHfydUH5HOMpyRbZPG8113kxxpamv3fo06Lide
         fJydjPjhcz6YQX7I6zL666sQZGREcW3tolfbtbEyNBBOrfeaKpx8gUmfehmZJa1pKZ3Q
         j3Uw==
X-Received: by 10.66.155.8 with SMTP id vs8mr146988619pab.18.1452130146288;
        Wed, 06 Jan 2016 17:29:06 -0800 (PST)
Received: from google.com ([2620:0:1000:1301:a0c7:6a2c:8427:c983])
        by smtp.gmail.com with ESMTPSA id yl1sm144841699pac.35.2016.01.06.17.29.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 06 Jan 2016 17:29:05 -0800 (PST)
Date:   Wed, 6 Jan 2016 17:29:03 -0800
From:   Brian Norris <computersforpeace@gmail.com>
To:     Harvey Hunt <harvey.hunt@imgtec.com>
Cc:     linux-mtd@lists.infradead.org, boris.brezillon@free-electrons.com,
        alex@alex-smith.me.uk, Alex Smith <alex.smith@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Burton <paul.burton@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, robh@kernel.org
Subject: Re: [PATCH v11 3/3] MIPS: dts: jz4780/ci20: Add NEMC, BCH and NAND
 device tree nodes
Message-ID: <20160107012903.GX109450@google.com>
References: <1451910884-18710-1-git-send-email-harvey.hunt@imgtec.com>
 <1451910884-18710-4-git-send-email-harvey.hunt@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1451910884-18710-4-git-send-email-harvey.hunt@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Mon, Jan 04, 2016 at 12:34:44PM +0000, Harvey Hunt wrote:
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
> index 9fcb9e7..782258c 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts

As I noted on patch 1, you need to send this to linux-mips + Ralf.

> @@ -42,3 +42,66 @@
>  &uart4 {
>  	status = "okay";
>  };
> +
> +&nemc {
> +	status = "okay";
> +
> +	nandc: nand-controller@1 {
> +		compatible = "ingenic,jz4780-nand";
> +		reg = <1 0 0x1000000>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ingenic,bch-controller = <&bch>;
> +
> +		ingenic,nemc-tAS = <10>;
> +		ingenic,nemc-tAH = <5>;
> +		ingenic,nemc-tBP = <10>;
> +		ingenic,nemc-tAW = <15>;
> +		ingenic,nemc-tSTRV = <100>;
> +
> +		nand@1 {
> +			reg = <1>;
> +
> +			nand-ecc-step-size = <1024>;
> +			nand-ecc-strength = <24>;
> +			nand-ecc-mode = "hw";
> +			nand-on-flash-bbt;
> +
> +			partitions {
> +				#address-cells = <2>;
> +				#size-cells = <2>;

This binding was updated, so you need:

				compatible = "fixed-partitions";

Brian

> +
> +				partition@0 {
> +					label = "u-boot-spl";
> +					reg = <0x0 0x0 0x0 0x800000>;
> +				};
> +
> +				partition@0x800000 {
> +					label = "u-boot";
> +					reg = <0x0 0x800000 0x0 0x200000>;
> +				};
> +
> +				partition@0xa00000 {
> +					label = "u-boot-env";
> +					reg = <0x0 0xa00000 0x0 0x200000>;
> +				};
> +
> +				partition@0xc00000 {
> +					label = "boot";
> +					reg = <0x0 0xc00000 0x0 0x4000000>;
> +				};
> +
> +				partition@0x8c00000 {
> +					label = "system";
> +					reg = <0x0 0x4c00000 0x1 0xfb400000>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&bch {
> +	status = "okay";
> +};

Brian
