Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Oct 2017 05:09:10 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46278 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdJ0DJD34F2z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Oct 2017 05:09:03 +0200
Received: by mail-oi0-f68.google.com with SMTP id n82so8961574oig.3
        for <linux-mips@linux-mips.org>; Thu, 26 Oct 2017 20:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p3hIVaSweXT5CJ9M4KpP734TrxkvltudFbFeXwwAzhM=;
        b=JZRaaifH2bQmPZQFmBXMIL2/8iAdwOm9FDstEDr3Hdxd2ezeOy8OG5L6aIXyz83vHk
         EXx0IErihWeUx3Opm7sUKzANmyuHdQBhGGSuzHvg34vbzw2NY5inUCkwg6hVnI8AVKDc
         +Zq4JDuxVCAUIerwiv/UoZdK3XA1bz/Vfuj6y1neKSMq/oZe9lctRWbfQu2//W70Q+ge
         KX1DHIGItkhpeUGZ5CnguwzvoGmZWBmMTf9y6dBB879HtpDYehD4uZ8ewa9PpPhQ7hXv
         aCGNKoFUq5E8vmG2Jr3EGCnHroD+fdWMk/b+SUJ/66yTQpvNA4snYibifbVunVMR1FqO
         +IoA==
X-Gm-Message-State: AMCzsaXSVimiaZXzpuaRPQWNiV38DKaqyRZF/ZKBVlOmt4RlBwweEHJM
        zRdVhhSZK2owYvvlrHI3Ug==
X-Google-Smtp-Source: ABhQp+SokWYahqtsl9VS6O1j+p2SdxlSUx0e1EKDJtrylLISf1tPmXcxcIz9R+2bKlO4R6+jUtpziQ==
X-Received: by 10.202.239.135 with SMTP id n129mr3432881oih.381.1509073737299;
        Thu, 26 Oct 2017 20:08:57 -0700 (PDT)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id r129sm2976140oig.14.2017.10.26.20.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Oct 2017 20:08:56 -0700 (PDT)
Date:   Thu, 26 Oct 2017 22:08:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org, Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Douglas Leung <douglas.leung@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Hogan <james.hogan@mips.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 1/5] Documentation: Add device tree binding for
 Goldfish PIC driver
Message-ID: <20171027030856.a2mahvhipy5vly26@rob-hp-laptop>
References: <1508510055-6167-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1508510055-6167-2-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508510055-6167-2-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60573
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

On Fri, Oct 20, 2017 at 04:33:34PM +0200, Aleksandar Markovic wrote:
> From: Miodrag Dinic <miodrag.dinic@mips.com>
> 
> Add documentation for DT binding of Goldfish PIC driver. The compatible
> string used by OS for binding the driver is "google,goldfish-pic".
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  .../interrupt-controller/google,goldfish-pic.txt   | 30 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt b/Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
> new file mode 100644
> index 0000000..295bf97
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
> @@ -0,0 +1,30 @@
> +Android Goldfish PIC
> +
> +Android Goldfish programmable interrupt device used by Android
> +emulator.
> +
> +Required properties:
> +
> +- compatible : should contain "google,goldfish-pic"
> +- reg        : <registers mapping>
> +- interrupts : <interrupt mapping>
> +
> +Example for mips when used in cascade mode:
> +
> +        cpuintc {
> +                #interrupt-cells = <0x1>;
> +                #address-cells = <0>;
> +                interrupt-controller;
> +                compatible = "mti,cpu-interrupt-controller";
> +        };
> +
> +        goldfish_pic@1f000000 {

interrupt-controller@...

With that,

Acked-by: Rob Herring <robh@kernel.org>

> +                compatible = "google,goldfish-pic";
> +                reg = <0x1f000000 0x0 0x1000>;
> +
> +                interrupt-controller;
> +                #interrupt-cells = <0x1>;
> +
> +                interrupt-parent = <&cpuintc>;
> +                interrupts = <0x2>;
> +        };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4a3de82..4d5108f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -872,6 +872,11 @@ S:	Supported
>  F:	drivers/android/
>  F:	drivers/staging/android/
>  
> +ANDROID GOLDFISH PIC DRIVER
> +M:	Miodrag Dinic <miodrag.dinic@mips.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
> +
>  ANDROID GOLDFISH RTC DRIVER
>  M:	Miodrag Dinic <miodrag.dinic@mips.com>
>  S:	Supported
> -- 
> 2.7.4
> 
