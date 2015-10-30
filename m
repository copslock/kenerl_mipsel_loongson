Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2015 14:52:59 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33719 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010999AbbJ3Nw5s-Rc0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Oct 2015 14:52:57 +0100
Received: by padhy1 with SMTP id hy1so69403306pad.0;
        Fri, 30 Oct 2015 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QX3E/ObJH/JFHsRsqdTJfQnb7rIJ4sFnVeNOUXWJG2Q=;
        b=rlUo/CfjeCrY7xe0vAK9xaJMghS8qwllFxkCoAV0KQA2m5+HOHT/2MELQ2MCpGZnoh
         jEt/47rPTBWiYFHU31Rc0+TixKag34pievZT/h7zTppgoODLnO0T/s2fmUq82Cu6Jexa
         l6Kn/xKFYSPMF94dfh6cCPkZp39aXD7x0fY19Si+MRwwSgTfuKQ//pACvdjd/0W3NONX
         cINhz0HChZgkBPecT8QMmDkoxwAcklF64bapojXoUXQSw4PjF+WsAg3zUQVurxl4oGGx
         PVYj9gyX4t21xc5A6NdNMudC4e8GZfR9sLuuEi27dDBR9WkJtBrKUpxm1QXBoNwFHUpj
         WE2A==
X-Received: by 10.68.68.205 with SMTP id y13mr9073741pbt.46.1446213171764;
        Fri, 30 Oct 2015 06:52:51 -0700 (PDT)
Received: from [192.168.0.105] ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id xm9sm8443194pbc.32.2015.10.30.06.52.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 Oct 2015 06:52:51 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [v3 08/10] MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7425
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <1446212339-1210-9-git-send-email-jaedon.shin@gmail.com>
Date:   Fri, 30 Oct 2015 22:52:46 +0900
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A997D184-1774-4720-A3A9-B34C1E2F6365@gmail.com>
References: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com> <1446212339-1210-9-git-send-email-jaedon.shin@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>
X-Mailer: Apple Mail (2.3096.5)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

> On Oct 30, 2015, at 10:38 PM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> 
> Add AHCI and PHY device nodes to MIPS-based BCM7425 set-top box
> platform.
> 
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
> ---
> arch/mips/boot/dts/brcm/bcm7425.dtsi | 42 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 42 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
> index 5b660b617ead..e24d41ab4e30 100644
> --- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
> @@ -221,5 +221,47 @@
> 			interrupts = <73>;
> 			status = "disabled";
> 		};
> +
> +		sata: sata@181000 {
> +			compatible = "brcm,bcm7425-ahci", "brcm,sata3-ahci";
> +			reg-names = "ahci", "top-ctrl";
> +			reg = <0x181000 0xa9c>, <0x180020 0x1c>;
> +			interrupt-parent = <&periph_intc>;
> +			interrupts = <40>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			brcm,broken-ncq;
> +			brcm,broken-phi;

I am sorry. This should be remove brcm,broken-ncq and brcm,broken-phy.

> +			status = "disabled";
> +
> +			sata0: sata-port@0 {
> +				reg = <0>;
> +				phys = <&sata_phy0>;
> +			};
> +
> +			sata1: sata-port@1 {
> +				reg = <1>;
> +				phys = <&sata_phy1>;
> +			};
> +		};
> +
> +		sata_phy: sata-phy@1800000 {
> +			compatible = "brcm,bcm7425-sata-phy", "brcm,phy-sata3";
> +			reg = <0x180100 0x0eff>;
> +			reg-names = "phy";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			sata_phy0: sata-phy@0 {
> +				reg = <0>;
> +				#phy-cells = <0>;
> +			};
> +
> +			sata_phy1: sata-phy@1 {
> +				reg = <1>;
> +				#phy-cells = <0>;
> +			};
> +		};
> 	};
> };
> -- 
> 2.6.2
> 
