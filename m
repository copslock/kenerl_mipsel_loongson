Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 00:25:40 +0200 (CEST)
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43288 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992604AbeCZWZdkd5th (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2018 00:25:33 +0200
Received: by mail-ot0-f195.google.com with SMTP id m22-v6so22409460otf.10
        for <linux-mips@linux-mips.org>; Mon, 26 Mar 2018 15:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kVY0hMKCrGlY9LYK0iSINuAO17JWRkb3GHrEvg1OGzg=;
        b=B5qWFtVWz/UghCWTF3K5grGS+UmQVyIX+7UF7cqYsD6CdYWLyU42Mb57g1NBHRbhmt
         n+gstk5XjUfYXpAF3vBMTNKObYGwNmyjBdYV9Zj/s7aDMqv/LjYi5HXZ217gQv9mjENa
         erJmQUlHahbGsxa3OMeslgZgErKfV4pcRzIAFbuP8rU28kJK2mlIDCatErqvs/cse5uH
         965lzc+S77HKVZjtd01DeJHfFY9c7Vez/A2Fo+zfhJi1+UdaiLCtqJj0oxtPhGFqBl37
         ksCnBYToTydPApc3Ke5wgBU2MSj7XauEnJHvGswkAhnsy9F7InDqmJHqsr1JBpvwu7ja
         bAGw==
X-Gm-Message-State: AElRT7Gq7rHVxbGusDgAzNu24gdHuuVuEqtMC16oGwX5jHZ4QQT08d7b
        R+dlPPeTtpIhyRyXTnAJqA==
X-Google-Smtp-Source: AG47ELuLD28T3jm52A5tTl3bwmBVhEYglybY5TIFoQbDZQxA//eknnuOxteDDXTx9DTrrtjN3FkWww==
X-Received: by 2002:a9d:6057:: with SMTP id v23-v6mr9406743otj.362.1522103127769;
        Mon, 26 Mar 2018 15:25:27 -0700 (PDT)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id b41-v6sm2064989oth.60.2018.03.26.15.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 15:25:27 -0700 (PDT)
Date:   Mon, 26 Mar 2018 17:25:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        razvan.stefanescu@nxp.com, po.liu@nxp.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next 4/8] dt-bindings: net: add DT bindings for
 Microsemi Ocelot Switch
Message-ID: <20180326222526.gwflhl4m5bawdh7f@rob-hp-laptop>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323201117.8416-5-alexandre.belloni@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63238
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

On Fri, Mar 23, 2018 at 09:11:13PM +0100, Alexandre Belloni wrote:
> DT bindings for the Ethernet switch found on Microsemi Ocelot platforms.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../devicetree/bindings/net/mscc-ocelot.txt        | 62 ++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mscc-ocelot.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> new file mode 100644
> index 000000000000..ee092a85b5a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> @@ -0,0 +1,62 @@
> +Microsemi Ocelot network Switch
> +===============================
> +
> +The Microsemi Ocelot network switch can be found on Microsemi SoCs (VSC7513,
> +VSC7514)

What's the difference in these SoCs? You should probably have the 
part#'s in the compatible string.

> +
> +Required properties:
> +- compatible: Should be "mscc,ocelot-switch"
> +- reg: Must contain an (offset, length) pair of the register set for each
> +  entry in reg-names.
> +- reg-names: Must include the following entries:
> +  - "sys"
> +  - "rew"
> +  - "qs"
> +  - "hsio"
> +  - "qsys"
> +  - "ana"
> +  - "portX" with X from 0 to the number of last port index available on that
> +    switch
> +- interrupts: Should contain the switch interrupts for frame extraction and
> +  frame injection
> +- interrupt-names: should contain the interrupt names: "xtr", "inj"
> +
> +Example:
> +
> +	switch@1010000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "mscc,ocelot-switch";
> +		reg = <0x1010000 0x10000>,
> +		      <0x1030000 0x10000>,
> +		      <0x1080000 0x100>,
> +		      <0x10d0000 0x10000>,
> +		      <0x11e0000 0x100>,
> +		      <0x11f0000 0x100>,
> +		      <0x1200000 0x100>,
> +		      <0x1210000 0x100>,
> +		      <0x1220000 0x100>,
> +		      <0x1230000 0x100>,
> +		      <0x1240000 0x100>,
> +		      <0x1250000 0x100>,
> +		      <0x1260000 0x100>,
> +		      <0x1270000 0x100>,
> +		      <0x1280000 0x100>,
> +		      <0x1800000 0x80000>,
> +		      <0x1880000 0x10000>;
> +		reg-names = "sys", "rew", "qs", "hsio", "port0",
> +			    "port1", "port2", "port3", "port4", "port5",
> +			    "port6", "port7", "port8", "port9", "port10",
> +			    "qsys", "ana";
> +		interrupts = <21 22>;
> +		interrupt-names = "xtr", "inj";
> +
> +		port0: port@0 {
> +			reg = <0>;
> +			phy-handle = <&phy0>;
> +		};
> +		port1: port@1 {
> +			reg = <1>;
> +			phy-handle = <&phy1>;
> +		};
> +	};
> -- 
> 2.16.2
> 
