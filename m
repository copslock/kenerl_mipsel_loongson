Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Dec 2017 21:23:47 +0100 (CET)
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35985 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992336AbdLOUXkI1h1j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Dec 2017 21:23:40 +0100
Received: by mail-ot0-f193.google.com with SMTP id d5so8813017oti.3;
        Fri, 15 Dec 2017 12:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=djdccVSk6KllSs7ziVy9CFuznfeqm0ByGhMrhRMWMMQ=;
        b=ufTXIjw2sk1idyrgPzF8cvMG1nWvd/M1l6eDYQMgto3u216WSKY+MltAMRkgFp1hhF
         c8jtgA+7BmcKFltyX60xOT+jOBocqVUgU5ffon+c8hmjWEyCICPuD15bZq9ptMYwMyVu
         mDWLk1WFnNYu0P0XHPWLwSoRy/AK0MRYDvUJI3+i4I7fFK8/J/MPs2nOpN9KTI4if3fr
         iBL2puX2+1kROP3l8Ouybj8ReUR8ZVeitCgperDdfuilEH1+k/63k+z/ptMK1VRGTsWQ
         KRgjzvz/msWIKkSFqZpJ/KU8XWJeYeecxLvsfvfvWYWCbNXpPIuzfGznLwd4BxVlut0H
         pArQ==
X-Gm-Message-State: AKGB3mJoYeZcUn/uCANttVNaIf/pjFcCTgIcYiZyT2/2Fj481lM4/pnG
        z8fow+mZeSmpDCVkVCHRgw==
X-Google-Smtp-Source: ACJfBovtKRRrmqS631ynHPoGNA5SLYmsg+z50JWXwsrJMblKHUnKhTe+WlZJZc4JZx4dRe2a37gerQ==
X-Received: by 10.157.81.16 with SMTP id c16mr315454oth.255.1513369413974;
        Fri, 15 Dec 2017 12:23:33 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id t90sm3476556ota.79.2017.12.15.12.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Dec 2017 12:23:33 -0800 (PST)
Date:   Fri, 15 Dec 2017 14:23:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 07/13] dt-bindings: power: reset: Document
 ocelot-reset binding
Message-ID: <20171215202332.bn47da3fpkynusno@rob-hp-laptop>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
 <20171208154618.20105-8-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171208154618.20105-8-alexandre.belloni@free-electrons.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61491
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

On Fri, Dec 08, 2017 at 04:46:12PM +0100, Alexandre Belloni wrote:
> Add binding documentation for the Microsemi Ocelot reset block.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  .../devicetree/bindings/power/reset/ocelot-reset.txt    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> new file mode 100644
> index 000000000000..1bcf276b04cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> @@ -0,0 +1,17 @@
> +Microsemi Ocelot reset controller
> +
> +The DEVCPU_GCB:CHIP_REGS have a SOFT_RST register that can be used to reset the
> +SoC MIPS core.
> +
> +Required Properties:
> + - compatible: "mscc,ocelot-chip-reset"
> +
> +Example:
> +	syscon@71070000 {
> +		compatible = "mscc,ocelot-chip-regs", "simple-mfd", "syscon";
> +		reg = <0x71070000 0x1c>;
> +
> +		reset {
> +			compatible = "mscc,ocelot-chip-reset";

Why do you need a subnode here other than as a way to instantiate a 
driver? Can you describe the SOFT_RST register in reg property here 
(without having overlapping regions)?
