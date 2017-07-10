Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2017 16:14:02 +0200 (CEST)
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33797 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992274AbdGJONtkn0Gc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jul 2017 16:13:49 +0200
Received: by mail-yb0-f193.google.com with SMTP id n205so4201528yba.1;
        Mon, 10 Jul 2017 07:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=49IxFimhdhOj8HdZUkNZFDqEeJIa8dr4JsRVbx1zT3Y=;
        b=oHU/WJbukq5e1MHEHm3QTguOB+mJb9n2kQ6AF4QjsDMcwrCrlcwV8lKFg480X9bovz
         Yvs9m/MicsY6CYPXAZW2xq6JNwr9CyamWVFRuyTjFyVxB1jdpOZXJp9e3PLzNANU7PF9
         T6tfvU8y9aVYhQ2Beg2tiKLns/14itvDo9KtfcaJj3pW1CdKmHFVm61xUh1mEsNma83d
         AzXfA9QQGzgq/JFvw7QZ0HyUoZZ8z5cp7A7T6bbZeEbwr2yPZve5RQIt4uzGLR5gvn4t
         ShyCZE8sH+jmEH1JqNiIDV2LS/6r+s4e8DE8rbnOXxXsf6Avcf7am3xaPvnNj3cjgomu
         JIeQ==
X-Gm-Message-State: AIVw111rJ8Y2l3Ts+zo+RQE4IpqddOZBG/tLRW8CNXZoM/AIDVEsrTGc
        d4bF1ZR0c2XnCA==
X-Received: by 10.37.234.79 with SMTP id o15mr15248097ybe.67.1499696023736;
        Mon, 10 Jul 2017 07:13:43 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id b135sm4756922ywh.55.2017.07.10.07.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jul 2017 07:13:43 -0700 (PDT)
Date:   Mon, 10 Jul 2017 09:13:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM BCM47XX MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>, linux-pm@vger.kernerl.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 3/4] dt-bindings: Document MIPS Broadcom STB power
 management nodes
Message-ID: <20170710141342.fghqil4px5ylj336@rob-hp-laptop>
References: <20170706222225.9758-1-f.fainelli@gmail.com>
 <20170706222225.9758-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706222225.9758-4-f.fainelli@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59080
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

On Thu, Jul 06, 2017 at 03:22:24PM -0700, Florian Fainelli wrote:
> Document the different nodes required for supporting S2/S3/S5 suspend
> states on MIPS-based Broadcom STB SoCs.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../devicetree/bindings/mips/brcm/soc.txt          | 153 +++++++++++++++++++++
>  1 file changed, 153 insertions(+)

A couple of nits on the node names, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> +Example:
> +
> +	memory-controller: memc@0 {

memory-controller@0

> +		compatible = "brcm,brcmstb-memc", "simple-bus";
> +		ranges = <0x0 0x0 0xa000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		memc-arb@1000 {
> +			...
> +		};
> +
> +		memc-ddr@2000 {
> +			...
> +		};
> +
> +		ddr-phy@6000 {
> +			...
> +		};
> +	};


> +Example:
> +
> +	timers: timers@4067c0 {

timer@...

> +		compatible = "brcm,bcm7425-timers", "brcm,brcmstb-timers";
> +		reg = <0x4067c0 0x40>;
> +		interrupts = <&periph_intc 19>;
> +	};
> -- 
> 2.9.3
> 
