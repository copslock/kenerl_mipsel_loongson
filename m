Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Dec 2017 02:54:22 +0100 (CET)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36515 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991827AbdLAByPjBSXi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Dec 2017 02:54:15 +0100
Received: by mail-oi0-f66.google.com with SMTP id j17so6232677oih.3;
        Thu, 30 Nov 2017 17:54:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CArEYkOjzm5zkm61NaSpPOsfzY/S2G2XP8+JD+MkkOk=;
        b=jvaEhBrVilZ2ceeCdVl5ME9/5T0prkCIP8XAiDKhuEgpkkNYQsSfLciU7JREqmroUq
         /SD7lQs8ahB4kRwewK0//l9MX4gZoFg3v2V4ZKXyLYA+hB9g+c9zYlHGqBvo/1Lc86eA
         aKmqMOaiP1wtmvcMG3ywqpAsdZXOR0UFN3EF8qoKQSSHwyA07qFFjmpVnXMhNknMHl1v
         uOEgt7JVRaM97k9m4iHTVVAoqAtbgpszuWHokgR1B8TWZ0HUAmoVgskpJvLiXLOOLwzV
         RJ9cIwpyki0PDUIG8wRMDpQlX7c02Y3rheW2D0TlQLL9Hguu26M1pB/ebda/AeignVA3
         AkyQ==
X-Gm-Message-State: AJaThX4EZWobNPJAvXCZOu1BXKEt6Ivn2Cagdoq39isod4GRnjBgaaL3
        w5+hHgKwTH/Q9exbX5xRDQ==
X-Google-Smtp-Source: AGs4zMZzthUfkKxQd7vur9+07frR2NV93e7MBVDsfiuin8rAO4pg5uMSK5xLsQydhlnFgfsX0M92Zg==
X-Received: by 10.202.3.65 with SMTP id 62mr5771177oid.193.1512093249474;
        Thu, 30 Nov 2017 17:54:09 -0800 (PST)
Received: from localhost (216-188-254-6.dyn.grandenetworks.net. [216.188.254.6])
        by smtp.gmail.com with ESMTPSA id h96sm2440294otb.62.2017.11.30.17.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 17:54:09 -0800 (PST)
Date:   Thu, 30 Nov 2017 19:54:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 06/13] dt-bindings: power: reset: Document ocelot-reset
 binding
Message-ID: <20171201015408.gg5di47m7nic57cz@rob-hp-laptop>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-7-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128152643.20463-7-alexandre.belloni@free-electrons.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61257
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

On Tue, Nov 28, 2017 at 04:26:36PM +0100, Alexandre Belloni wrote:
> Add binding documentation for the Microsemi Ocelot reset block.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> To: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> 
>  .../bindings/power/reset/ocelot-reset.txt          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> new file mode 100644
> index 000000000000..2d3f2c21fadd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/ocelot-reset.txt
> @@ -0,0 +1,24 @@
> +Microsemi Ocelot reset driver

Bindings are not drivers.

> +
> +The DEVCPU_GCB:CHIP_REGS have a SOFT_RST register that can be used to reset the
> +SoC MIPS core.
> +
> +Required Properties:
> + - compatible: "mscc,ocelot-chip-reset"
> + - mscc,cpucontrol: phandle to the CPU system control syscon block
> +
> +Example:
> +		cpu_ctrl: syscon@70000000 {
> +			compatible = "syscon";

syscon alone is not valid.

> +			reg = <0x70000000 0x2c>;
> +		};
> +
> +		syscon@71070000 {
> +			compatible = "simple-mfd", "syscon";

SoC specific compatible?

> +			reg = <0x71070000 0x1c>;
> +
> +			reset {
> +				compatible = "mscc,ocelot-chip-reset";
> +				mscc,cpucontrol = <&cpu_ctrl>;

This looks strange. A syscon pointing to another syscon?

Doesn't look like you even need this node, but hard to know if you don't 
document the parent node completely (i.e. what are all the functions in 
this syscon).

> +			};
> +		};
> -- 
> 2.15.0
> 
