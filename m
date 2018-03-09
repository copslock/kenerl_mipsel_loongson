Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 15:44:45 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:37476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994806AbeCIOogXiy0w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Mar 2018 15:44:36 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A858B206B2;
        Fri,  9 Mar 2018 14:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A858B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 9 Mar 2018 14:44:21 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v4 7/8] MIPS: BMIPS: Add PCI bindings for 7425, 7435
Message-ID: <20180309144420.GG24558@saruman>
References: <1516058925-46522-1-git-send-email-jim2101024@gmail.com>
 <1516058925-46522-8-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline
In-Reply-To: <1516058925-46522-8-git-send-email-jim2101024@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62875
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Jan 15, 2018 at 06:28:44PM -0500, Jim Quinlan wrote:
> diff --git a/arch/mips/boot/dts/brcm/bcm7425.dtsi b/arch/mips/boot/dts/brcm/bcm7425.dtsi
> index e4fb9b6..02168d0 100644
> --- a/arch/mips/boot/dts/brcm/bcm7425.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm7425.dtsi
> @@ -495,4 +495,30 @@
>  			status = "disabled";
>  		};
>  	};
> +
> +	pcie: pcie@10410000 {
> +		reg = <0x10410000 0x830c>;
> +		compatible = "brcm,bcm7425-pcie";
> +		interrupts = <37>, <37>;
> +		interrupt-names = "pcie", "msi";
> +		interrupt-parent = <&periph_intc>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		linux,pci-domain = <0>;
> +		brcm,enable-ssc;
> +		bus-range = <0x00 0xff>;
> +		msi-controller;
> +		#interrupt-cells = <1>;
> +		/* 4x128mb windows */
> +		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xd8000000 0xd8000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xe0000000 0xe0000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xe8000000 0xe8000000 0 0x08000000>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &periph_intc 33
> +				 0 0 0 2 &periph_intc 34
> +				 0 0 0 3 &periph_intc 35
> +				 0 0 0 4 &periph_intc 36>;

no status = "disabled" like the other dtsi?

> +	};
> +
>  };
> diff --git a/arch/mips/boot/dts/brcm/bcm7435.dtsi b/arch/mips/boot/dts/brcm/bcm7435.dtsi
> index 1484e89..84881224 100644
> --- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
> +++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
> @@ -510,4 +510,31 @@
>  			status = "disabled";
>  		};
>  	};
> +
> +	pcie: pcie@10410000 {
> +		reg = <0x10410000 0x930c>;
> +		interrupts = <0x27>, <0x27>;
> +		interrupt-names = "pcie", "msi";
> +		interrupt-parent = <&periph_intc>;
> +		compatible = "brcm,bcm7435-pcie";

Might be nice to be consistent in your property ordering between these
two dtsi files. I for one would prefer compatible to be near the top
too, if only for consistency with most other nodes in these files.

> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		linux,pci-domain = <0>;
> +		brcm,enable-ssc;
> +		bus-range = <0x00 0xff>;
> +		msi-controller;
> +		#interrupt-cells = <1>;
> +		/* 4x128mb windows */
> +		ranges = <0x2000000 0x0 0xd0000000 0xd0000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xd8000000 0xd8000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xe0000000 0xe0000000 0 0x08000000>,
> +			 <0x2000000 0x0 0xe8000000 0xe8000000 0 0x08000000>;
> +		interrupt-map-mask = <0 0 0 7>;
> +		interrupt-map = <0 0 0 1 &periph_intc 35
> +				 0 0 0 2 &periph_intc 36
> +				 0 0 0 3 &periph_intc 37
> +				 0 0 0 4 &periph_intc 38>;
> +		status = "disabled";
> +	};
> +
>  };

Cheers
James

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqincQACgkQbAtpk944
dnr2hA/+P6w7+sOSZ5SEM19861JqBmRkXLy5Hd/18PMHGTennR09vEOJv9skH3oS
CojTysqBeNHvupX9gQ48lCeccH2GNv4fExM8QZyKreEwli/gmCxJRTXeZmmO3aqO
RUFpkIauu/whA/e8fxoEhUuX79wyNw+wqT0DHxpafPc66Aq+SBXXz8LINE+DaM+/
i4JGd0fY/1N48CieB1mFgOCkaTJ1F1ei7Jh+f6qeHKv6tNTx+LRnU0oKbGpybEJN
kpY6BvodOgC/YL+tOiyyAASN90a7wS4vj0vxSkxbeKZp1fMF/3F5uA3J1FdJDd5X
Ydqy3jFG3gggm7GhFUOeZPv1KogWt7PddWpoZnpu5GlIaE9Eb7ba0FMhb6+LPrx8
bj/rms88LosucmT5u/QvuGrIArBNyhAQPTFVner+gTfjHDvpB5iAG/RcZCCrRX9d
sOMSmDorbfGs8t0m/k3HScl9d2ZQJPzRjL/YOJSuBpJQPGG+Cz4p0+5lr+zar0qQ
BeZcwGCvv3VjFUg60flzbOBuiQ3KTvKFo52ssk7l/Tuq2cIW/vgVBvcbgFPu+GfT
zeE1no/C1jT8EtJDipihJa1GmsfMs7Czi17nb03dljylkh7eXmKcsuwn4h95wskZ
WzW46Mgkb98ZDrN9b1iH4TUe7IuNhhMFxjnVtfeudkt05TKyplo=
=Z5Mn
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--
