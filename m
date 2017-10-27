Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Oct 2017 05:11:10 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:54186 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991526AbdJ0DLCzcZ6z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Oct 2017 05:11:02 +0200
Received: by mail-oi0-f68.google.com with SMTP id h6so8942212oia.10
        for <linux-mips@linux-mips.org>; Thu, 26 Oct 2017 20:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUTwuSsjk3YMA7/wdW17hDamc7odo0xMCr4LDhIQMBA=;
        b=MtJ7pQ0FNPZ1NNapkNMYZnJ4fs00F3eBEKv1v/qDtBZAcH2pJYLsQxli9aPzyN7dtD
         euKCgZh25czkksUyShX04Xdt4XReYtrDVv8AlazZcIsrtWxrlZS5mz/SBCgX9jQ/1i8d
         nHeVearpEGheBozLZORZu9EueBN3EBSxX7a/A2BfL4cYjlfJeIlNjprmPx2elor28Kq8
         DFmW6WBY9ltIuN9C7/hvBDDDA79fL5HafqBwJbjaGm1mMsZY9dqqZUCW6ZVyQugvl0oY
         9P+9IsIZMLF2RABZkkkJxWv4BARcda0KQp0ul4blyYGkmuy33eRcMQXJ+8DglB1XVZK2
         e96w==
X-Gm-Message-State: AMCzsaWVeT2QmbL/7NUnMobyxLM01VLjAAHKeTTRTVBzhiZJPFIWqDRS
        cIFisBZHyBSvexzeSFKv/GZEfHk=
X-Google-Smtp-Source: ABhQp+SfhEMUuDUY/L499GDMueydH9qnUKOCyPIJHd9goaaFqil73FXQxXU1GVU5OjLJlXmAHhuyuQ==
X-Received: by 10.202.61.65 with SMTP id k62mr3741998oia.418.1509073857070;
        Thu, 26 Oct 2017 20:10:57 -0700 (PDT)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id d42sm3647779ote.45.2017.10.26.20.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Oct 2017 20:10:56 -0700 (PDT)
Date:   Thu, 26 Oct 2017 22:10:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     linux-mips@linux-mips.org,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        Douglas Leung <douglas.leung@mips.com>,
        dri-devel@lists.freedesktop.org,
        James Hogan <james.hogan@mips.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Petar Jovanovic <petar.jovanovic@mips.com>,
        Raghu Gandham <raghu.gandham@mips.com>
Subject: Re: [PATCH v5 3/5] Documentation: Add device tree binding for
 Goldfish FB driver
Message-ID: <20171027031056.scmky5n5vbbnldmc@rob-hp-laptop>
References: <1508510055-6167-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1508510055-6167-4-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508510055-6167-4-git-send-email-aleksandar.markovic@rt-rk.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60574
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

On Fri, Oct 20, 2017 at 04:33:36PM +0200, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
> 
> Add documentation for DT binding of Goldfish FB driver. The compatible
> string used by OS for binding the driver is "google,goldfish-fb".
> 
> Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> ---
>  .../devicetree/bindings/display/google,goldfish-fb.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/google,goldfish-fb.txt b/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
> new file mode 100644
> index 0000000..9ce0615
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/google,goldfish-fb.txt
> @@ -0,0 +1,18 @@
> +Android Goldfish framebuffer
> +
> +Android Goldfish framebuffer device used by Android emulator.
> +
> +Required properties:
> +
> +- compatible : should contain "google,goldfish-fb"
> +- reg        : <registers mapping>
> +- interrupts : <interrupt mapping>
> +
> +Example:
> +
> +	goldfish_fb@1f008000 {

Use generic node names:

display-controller@...

With that,

Acked-by: Rob Herring <robh@kernel.org>


> +		compatible = "google,goldfish-fb";
> +		interrupts = <0x10>;
> +		reg = <0x1f008000 0x0 0x100>;

An address of one cell and size of 2 cells is strange...

> +		compatible = "google,goldfish-fb";
> +	};
> -- 
> 2.7.4
> 
