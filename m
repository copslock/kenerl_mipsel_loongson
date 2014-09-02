Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Sep 2014 19:27:51 +0200 (CEST)
Received: from mail-ig0-f169.google.com ([209.85.213.169]:35066 "EHLO
        mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007935AbaIBR1t1EX43 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Sep 2014 19:27:49 +0200
Received: by mail-ig0-f169.google.com with SMTP id r2so3980052igi.0
        for <multiple recipients>; Tue, 02 Sep 2014 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cWir2Q1kiX3owA1tz4TgZ4k6xKXj4PAzghX5fKWuW8k=;
        b=is0Sw30hT1vb1/l/e25RusNy2scJhzvPcxuaHR22Ton2gV7SuV9cdJOmUYmIyar8EC
         7ehWzN5gvL+0+YgNj8E/tCb1mG9Tf5V8Y13ZqXEmW7Wf7NECUgTpuY0jSZeGROgAmysq
         6hlLYFDPSTKLJ09PjeIATYVfVs43zZra0+ihy0zUJbdRyLFsGjTh3ekJd6veEWaNHmJj
         MQMbjaJPV/Y7AdUYBM2Ez3H1AFqLWmcmXD8tXPKYJZ5m6vmxMzL7QnzctL78j739VSH1
         c9cDPRe/gKS6l/8vtsUQ5Nw1nhCmQ+pfcK+mxehSzPsK8Ab0DlCgG9eagsEqZaPPGOa/
         2GFg==
X-Received: by 10.42.227.10 with SMTP id iy10mr32627285icb.3.1409678861996;
        Tue, 02 Sep 2014 10:27:41 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id e1sm40220490igx.18.2014.09.02.10.27.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 10:27:41 -0700 (PDT)
Message-ID: <5405FE07.4030400@gmail.com>
Date:   Tue, 02 Sep 2014 10:27:35 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] of: Add binding document for MIPS GIC
References: <1409350479-19108-1-git-send-email-abrestic@chromium.org> <1409350479-19108-4-git-send-email-abrestic@chromium.org>
In-Reply-To: <1409350479-19108-4-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 08/29/2014 03:14 PM, Andrew Bresticker wrote:
> The Global Interrupt Controller (GIC) present on certain MIPS systems
> can be used to route external interrupts to individual VPEs and CPU
> interrupt vectors.  It also supports a timer and software-generated
> interrupts.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>   Documentation/devicetree/bindings/mips/gic.txt | 50 ++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mips/gic.txt
>
> diff --git a/Documentation/devicetree/bindings/mips/gic.txt b/Documentation/devicetree/bindings/mips/gic.txt
> new file mode 100644
> index 0000000..725f1ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/gic.txt
> @@ -0,0 +1,50 @@
> +MIPS Global Interrupt Controller (GIC)
> +
> +The MIPS GIC routes external interrupts to individual VPEs and IRQ pins.
> +It also supports a timer and software-generated interrupts which can be
> +used as IPIs.
> +
> +Required properties:
> +- compatible : Should be "mti,global-interrupt-controller"
> +- reg : Base address and length of the GIC registers.
> +- interrupts : Core interrupts to which the GIC may route external interrupts.

This doesn't make sense to me.  The GIC can, and does, route interrupts 
to all CPU cores in a SMP system.  How can there be a concept of only 
associating it with several interrupt lines on a single CPU in the 
system?  That is not what the GIC does, is it?  It is a Global 
interrupts controller, not local.  So specifying device tree bindings 
that don't show its Global nature seems wrong.


> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt specifier.  Should be 3.
> +  - The first cell is the GIC interrupt number.
> +  - The second cell encodes the interrupt flags.
> +    See <include/dt-bindings/interrupt-controller/irq.h> for a list of valid
> +    flags.
> +  - The optional third cell indicates which CPU interrupt vector the GIC
> +    interrupt should be routed to.  It is a 0-based index into the list of
> +    GIC-to-CPU interrupts specified in the "interrupts" property described
> +    above.  For example, a '2' in this cell will route the interrupt to the
> +    3rd core interrupt listed in 'interrupts'.  If omitted, the interrupt will
> +    be routed to the 1st core interrupt.
> +

This seems like a really convoluted way of doing things that really goes 
against the device tree model.

The routing of interrupts through the GIC to a core interrupt is 
controlled entirely within the GIC hardware and therefore should be a 
property of the GIC itself, not all the random devices connected 
upstream to the GIC.

It also places policy about the priority of the various interrupts into 
the device tree.  Typically the device tree would contain only 
information about the topology of the hardware blocks, not arbitrary 
policy decisions that software could change and still have a perfectly 
functional system.

Therefore I would recommend removing the third cell from the interrupt 
specifier.


> +Example:
> +
> +	cpu_intc: interrupt-controller@0 {
> +		compatible = "mti,cpu-interrupt-controller";
> +
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +	};
> +
> +	gic: interrupt-controller@1bdc0000 {
> +		compatible = "mti,global-interrupt-controller";
> +		reg = <0x1bdc0000 0x20000>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +
> +		interrupt-parent = <&cpu_intc>;
> +		interrupts = <3>, <4>;
> +	};
> +
> +	uart@18101400 {
> +		...
> +		interrupt-parent = <&gic>;
> +		interrupts = <24 IRQ_TYPE_LEVEL_HIGH 0>;
> +		...
> +	};
>
