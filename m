Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2018 00:31:18 +0200 (CEST)
Received: from mail-it0-f65.google.com ([209.85.214.65]:53411 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992554AbeHMWbLcEPkz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Aug 2018 00:31:11 +0200
Received: by mail-it0-f65.google.com with SMTP id 72-v6so15576087itw.3;
        Mon, 13 Aug 2018 15:31:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ixxyV+zZ5lpUR/tC3df0LJWkBDWprKeVxR8Rsg3d/s=;
        b=CMLjAOhuzEXuXWy3jFISYoWM0cBcyJzLy8gr5uqCv12EVqiosVLpcmGqQQ6MR2ZBls
         1LTxfj+MpX4U77ci2wgwexuI/Q6KU7vl6Mk5LcqOCb2I52w50QoUvbPo+U6M6J1ogzdH
         Pjn04wUsDxN7ynSaI8r1r0TN+B+uxxKH74AWrbFjemGdoJHAHxdcmzjOV+TA5FdQVIh2
         BNgC+ixYxVwX2w6U4xfO8CVR+LIHYPl84FbeHsuYFnk7slphMmyvTes1BKZQUSMWku6r
         pBpWvPdAGig3RUH+F6TZyF89zUJApBG0UMLdM3BmUmYJB90WEfqesfd2Q1c06WUNbjDM
         J/RQ==
X-Gm-Message-State: AOUpUlFDSy73WOX7dfts5s7yaANUzzRVSXhFP3yjhGbM/Ui6+43fCCjV
        2d9TWpu2gXliQtixKcqjyw==
X-Google-Smtp-Source: AA+uWPyj1dRllgCWFyDNgTTzfqbEcwgUtUIULAvSHjK3Q0fWN/uozfV99VJtOJPvo4BkU7vH2+h27g==
X-Received: by 2002:a24:6302:: with SMTP id j2-v6mr12862803itc.8.1534199465429;
        Mon, 13 Aug 2018 15:31:05 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id h12-v6sm2788029ioj.57.2018.08.13.15.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 15:31:04 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:31:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, kishon@ti.com, andrew@lunn.ch,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 02/10] dt-bindings: net: ocelot: remove hsio
 from the list of register address spaces
Message-ID: <20180813223103.GA16669@rob-hp-laptop>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <3558e538b55a2249b0a179c04c27e9d3715bbbaa.1532954208.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3558e538b55a2249b0a179c04c27e9d3715bbbaa.1532954208.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65576
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

On Mon, Jul 30, 2018 at 02:43:47PM +0200, Quentin Schulz wrote:
> HSIO register address space should be handled outside of the MAC
> controller as there are some registers for PLL5 configuring,
> SerDes/switch port muxing and a thermal sensor IP, so let's remove it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mips/mscc.txt       | 16 ++++++++++++-
>  Documentation/devicetree/bindings/net/mscc-ocelot.txt |  9 ++-----
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mips/mscc.txt b/Documentation/devicetree/bindings/mips/mscc.txt
> index ae15ec3..bc817e9 100644
> --- a/Documentation/devicetree/bindings/mips/mscc.txt
> +++ b/Documentation/devicetree/bindings/mips/mscc.txt
> @@ -41,3 +41,19 @@ Example:
>  		compatible = "mscc,ocelot-cpu-syscon", "syscon";
>  		reg = <0x70000000 0x2c>;
>  	};
> +
> +o HSIO regs:
> +
> +The SoC has a few registers (HSIO) handling miscellaneous functionalities:
> +configuration and status of PLL5, RCOMP, SyncE, SerDes configurations and
> +status, SerDes muxing and a thermal sensor.
> +
> +Required properties:
> +- compatible: Should be "mscc,ocelot-hsio", "syscon", "simple-mfd"
> +- reg : Should contain registers location and length
> +
> +Example:
> +	syscon@10d0000 {
> +		compatible = "mscc,ocelot-hsio", "syscon", "simple-mfd";

simple-mfd is not appropriate without child nodes, so drop it.

> +		reg = <0x10d0000 0x10000>;
> +	};
> diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> index 0a84711..9e5c17d 100644
> --- a/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> +++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> @@ -12,7 +12,6 @@ Required properties:
>    - "sys"
>    - "rew"
>    - "qs"
> -  - "hsio"
>    - "qsys"
>    - "ana"
>    - "portX" with X from 0 to the number of last port index available on that
> @@ -45,7 +44,6 @@ Example:
>  		reg = <0x1010000 0x10000>,
>  		      <0x1030000 0x10000>,
>  		      <0x1080000 0x100>,
> -		      <0x10d0000 0x10000>,
>  		      <0x11e0000 0x100>,
>  		      <0x11f0000 0x100>,
>  		      <0x1200000 0x100>,
> @@ -59,10 +57,9 @@ Example:
>  		      <0x1280000 0x100>,
>  		      <0x1800000 0x80000>,
>  		      <0x1880000 0x10000>;
> -		reg-names = "sys", "rew", "qs", "hsio", "port0",
> -			    "port1", "port2", "port3", "port4", "port5",
> -			    "port6", "port7", "port8", "port9", "port10",
> -			    "qsys", "ana";
> +		reg-names = "sys", "rew", "qs", "port0", "port1", "port2",
> +			    "port3", "port4", "port5", "port6", "port7",
> +			    "port8", "port9", "port10", "qsys", "ana";
>  		interrupts = <21 22>;
>  		interrupt-names = "xtr", "inj";
>  
> -- 
> git-series 0.9.1
