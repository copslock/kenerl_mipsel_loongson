Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 22:18:14 +0100 (CET)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:45759
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990723AbeCWVSHSeTQ1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Mar 2018 22:18:07 +0100
Received: by mail-pf0-x241.google.com with SMTP id l27so5202367pfk.12
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2018 14:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/s5wC0qI05F48i2qcZoHlKzT6rjDbiBhy/z50U3vEOY=;
        b=rKBHzxRQXA7bwkmyYxtCSIefBRRdRcxRl0R+iY7icv499z+KeltfNrSTK4Z1dL2IiJ
         DTPEuggpcX5hx8/rbzv9YjfilbPVifSnkDiJLHN6sx+LAUSG+ZRghfRf0zT17wwC3Ugq
         jlNDz5gMwq+jYB/8WgD3LzJlrp6OI9IqvqMMHghq7IQECT/XU7KWy1qMnMkA925NDTqg
         c8x+h66ADqfJ59gq27wBXNi9Kr5N86kLotCWrKLQoNrB8kbhpCqYWEs3fP0ZR3icIvJX
         RhLIb/pvmQhwmjI2lVP5GXnBZDMwrHCeTFMYdn/5Fk1RZzc//VcJOQUvtYZ3GUbP9Bm4
         gthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/s5wC0qI05F48i2qcZoHlKzT6rjDbiBhy/z50U3vEOY=;
        b=ZRnF7IaxyC258ImOeL7qNX4WGC+/f3xh92lZQCB3WoGmbDFD6RDcqVXXVEUw89bFwQ
         LSpk4z5pjdSYSL2A0IIvEc8r4AQNjEl0FHIq/hdpjTyiTeBzdg/Cxv4OBrfPnKlsFy/w
         Gh3IdBoT0R2XqkZTdW17D7qiIWxGTrHBuSWz4ig1u4oGtwqiwJy1k6+Pwl0ckfGBAisG
         lZyJsEN9QU/OMFxZye0c9HIaOm7WK16b5V/5Ubpo7WBlm7qiU/MfiMpLiyOUi64uaBFi
         O5V2gUzApcMRMos+4luU+KIWco7pSHZzCALgtobN5HCtRfh9JLxCRWzYlso1hxKHVHBp
         TClw==
X-Gm-Message-State: AElRT7F656y2JPYRO92FzsvpuGfTR4oIz8Vnwlg6RJX8JxB9sYiwNQ5e
        vBjCK840GXx+AXwg+z/Cz2A=
X-Google-Smtp-Source: AG47ELuXDyK9EZ2v7LOS4XHG/0G6qkGg1iumtF58zUZke8dEAUKFvhH4s+tpB1RDe/daDwRzODjHUA==
X-Received: by 10.99.127.88 with SMTP id p24mr7296951pgn.93.1521839880520;
        Fri, 23 Mar 2018 14:18:00 -0700 (PDT)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id l64sm21033666pfi.142.2018.03.23.14.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 14:17:59 -0700 (PDT)
Subject: Re: [PATCH net-next 6/8] MIPS: mscc: Add switch to ocelot
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-7-alexandre.belloni@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e488fd29-0094-d005-a078-873f6f5add13@gmail.com>
Date:   Fri, 23 Mar 2018 14:17:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323201117.8416-7-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63196
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> Ocelot has an integrated switch, add support for it.
> 
> Cc: James Hogan <jhogan@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  arch/mips/boot/dts/mscc/ocelot.dtsi | 84 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
> 
> diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
> index dd239cab2f9d..22a86373b1c9 100644
> --- a/arch/mips/boot/dts/mscc/ocelot.dtsi
> +++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
> @@ -91,6 +91,69 @@
>  			status = "disabled";
>  		};
>  
> +		switch@1010000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "mscc,ocelot-switch";
> +			reg = <0x1010000 0x10000>,
> +			      <0x1030000 0x10000>,
> +			      <0x1080000 0x100>,
> +			      <0x10d0000 0x10000>,
> +			      <0x11e0000 0x100>,
> +			      <0x11f0000 0x100>,
> +			      <0x1200000 0x100>,
> +			      <0x1210000 0x100>,
> +			      <0x1220000 0x100>,
> +			      <0x1230000 0x100>,
> +			      <0x1240000 0x100>,
> +			      <0x1250000 0x100>,
> +			      <0x1260000 0x100>,
> +			      <0x1270000 0x100>,
> +			      <0x1280000 0x100>,
> +			      <0x1800000 0x80000>,
> +			      <0x1880000 0x10000>;
> +			reg-names = "sys", "rew", "qs", "hsio", "port0",
> +				    "port1", "port2", "port3", "port4", "port5",
> +				    "port6", "port7", "port8", "port9", "port10",
> +				    "qsys", "ana";
> +			interrupts = <21 22>;
> +			interrupt-names = "xtr", "inj";

See my comment about the binding patch, this should be moved to a ports
subnode so it is conforming to the existing DSA binding and makes it a
lot easier to have all ports disabled by default at the .dsti level by
not defini

> +
> +			port0: port@0 {
> +				reg = <0>;
> +			};
> +			port1: port@1 {
> +				reg = <1>;
> +			};
> +			port2: port@2 {
> +				reg = <2>;
> +			};
> +			port3: port@3 {
> +				reg = <3>;
> +			};
> +			port4: port@4 {
> +				reg = <4>;
> +			};
> +			port5: port@5 {
> +				reg = <5>;
> +			};
> +			port6: port@6 {
> +				reg = <6>;
> +			};
> +			port7: port@7 {
> +				reg = <7>;
> +			};
> +			port8: port@8 {
> +				reg = <8>;
> +			};
> +			port9: port@9 {
> +				reg = <9>;
> +			};
> +			port10: port@10 {
> +				reg = <10>;
> +			};
> +		};
> +
>  		reset@1070008 {
>  			compatible = "mscc,ocelot-chip-reset";
>  			reg = <0x1070008 0x4>;
> @@ -113,5 +176,26 @@
>  				function = "uart2";
>  			};
>  		};
> +
> +		mdio0: mdio@107009c {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "mscc,ocelot-miim";
> +			reg = <0x107009c 0x36>, <0x10700f0 0x8>;
> +			interrupts = <14>;

status = "disabled" by default?

> +
> +			phy0: ethernet-phy@0 {
> +				reg = <0>;
> +			};
> +			phy1: ethernet-phy@1 {
> +				reg = <1>;
> +			};
> +			phy2: ethernet-phy@2 {
> +				reg = <2>;
> +			};
> +			phy3: ethernet-phy@3 {
> +				reg = <3>;
> +			};

These PHYs should be defined at the board DTS level.
-- 
Florian
