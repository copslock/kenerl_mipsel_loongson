Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2018 23:49:19 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35983 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994599AbeIJVtPtxSDf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2018 23:49:15 +0200
Received: by mail-oi0-f65.google.com with SMTP id r69-v6so43259668oie.3
        for <linux-mips@linux-mips.org>; Mon, 10 Sep 2018 14:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K79AY4O6RedfDU91jDByJwqX1DCixicnTbrRfV/n2Ck=;
        b=W0RGnBzm1qUJr6vdiwmwnupYsFczwxvlPlB8LwyVQtA0wjjoFXfIDJM7Onqo9wl6Be
         GmTcBjhSUmUnCxo3WheWvJZAx8MVed1nzddcZigVC88CV4eoJCbAruFeBT0bIzckTKqj
         XmcY3wWgDpWlXCPsMXv2VUehCkyod9o1QmT3+rDpEQvOUm4yphpUiV81ip0cfqqqWwgA
         jXAIMWJgY6NGYrNI96fxjoYDka1HbSXITwJbfTzk/clcCZpJlXKGDL/6qh88wZNzfjsd
         nJ50yQJIwqswGL3kEgcrKEjedYMijsXYWkcr7pnHf1xu2U5Gs+49N9Ynuyx4mg8aJjae
         uFZg==
X-Gm-Message-State: APzg51CsfKDqG/MHLZhC+6MqwiHq6Spbg2amnP0cG5LdE7DEOMJnd5rc
        2rpaIpmEVPdxrJNwO/a/jw==
X-Google-Smtp-Source: ANB0VdZZNnNhGCQEjydLINRvH/y3i/T+OXH8jnU/E56QurEY15X68i0O61zsbIe3GIJgeap3l7rOQg==
X-Received: by 2002:aca:bc54:: with SMTP id m81-v6mr24707506oif.308.1536616149612;
        Mon, 10 Sep 2018 14:49:09 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r10-v6sm19672662oif.37.2018.09.10.14.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 14:49:09 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:49:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, f.fainelli@gmail.com,
        john@phrozen.org, linux-mips@linux-mips.org, dev@kresin.me,
        hauke.mehrtens@intel.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/6] dt-bindings: net: Add lantiq,xrx200-net
 DT bindings
Message-ID: <20180910214908.GA30443@bogus>
References: <20180909201647.32727-1-hauke@hauke-m.de>
 <20180909201647.32727-4-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180909201647.32727-4-hauke@hauke-m.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66189
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

On Sun, Sep 09, 2018 at 10:16:44PM +0200, Hauke Mehrtens wrote:
> This adds the binding for the PMAC core between the CPU and the GSWIP
> switch found on the xrx200 / VR9 Lantiq / Intel SoC.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/net/lantiq,xrx200-net.txt   | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
> new file mode 100644
> index 000000000000..8a2fe5200cdc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/lantiq,xrx200-net.txt
> @@ -0,0 +1,21 @@
> +Lantiq xRX200 GSWIP PMAC Ethernet driver
> +==================================
> +
> +Required properties:
> +
> +- compatible	: "lantiq,xrx200-net" for the PMAC of the embedded
> +		: GSWIP in the xXR200
> +- reg		: memory range of the PMAC core inside of the GSWIP core
> +- interrupts	: TX and RX DMA interrupts. Use interrupt-names "tx" for
> +		: the TX interrupt and "rx" for the RX interrupt.
> +
> +Example:
> +
> +eth0: eth@E10B308 {

ethernet@e10b308

> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	compatible = "lantiq,xrx200-net";
> +	reg = <0xE10B308 0x30>;

lowercase hex please.

> +	interrupts = <73>, <72>;
> +	interrupt-names = "tx", "rx";
> +};
> -- 
> 2.11.0
> 
