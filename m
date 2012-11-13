Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2012 06:00:48 +0100 (CET)
Received: from avon.wwwdotorg.org ([70.85.31.133]:52311 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823033Ab2KMFArUpiTp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Nov 2012 06:00:47 +0100
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id C95F96234;
        Mon, 12 Nov 2012 22:01:54 -0700 (MST)
Received: from dart.wwwdotorg.org (unknown [IPv6:2001:470:bb52:63:4c64:ca41:c8bc:4ee5])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id C8F62E40EF;
        Mon, 12 Nov 2012 22:00:44 -0700 (MST)
Message-ID: <50A1D3FC.9010207@wwwdotorg.org>
Date:   Mon, 12 Nov 2012 22:00:44 -0700
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
MIME-Version: 1.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Kevin Cernekee <cernekee@gmail.com>,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [RFC] MIPS: BCM63XX: add Device Tree glue code for IRQ handling
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com> <1352638249-29298-5-git-send-email-jonas.gorski@gmail.com>
In-Reply-To: <1352638249-29298-5-git-send-email-jonas.gorski@gmail.com>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 34973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/11/2012 05:50 AM, Jonas Gorski wrote:
> Register IRQ domains through Device Tree for the internal and external
> interrupt controllers. Register the same IRQ ranges as previously to
> provide backward compatibility for non-DT drivers.

> diff --git a/Documentation/devicetree/bindings/mips/bcm63xx/epic.txt b/Documentation/devicetree/bindings/mips/bcm63xx/epic.txt

Rather than putting binding docs in an arch-specific directory, perhaps
put them into a device-type-specific directory, such as
bindings/interrupt-controller/brcm,bcm63xx-epic.txt?

> +- #interrupt-cells: <2>
> +  This controller supports level and edge triggered interrupts. The
> +  first cell is the interrupt number, the second is a 1:1 mapping to
> +  the linux interrupt flags.

The DT documentation should be self-contained, and not reference
anything OS-specific. In this case, you could reference
Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
for the interrupt flags.

> diff --git a/arch/mips/bcm63xx/dts/bcm6328.dtsi b/arch/mips/bcm63xx/dts/bcm6328.dtsi

>  		ranges = <0 0x10000000 0x20000>;
>  		compatible = "simple-bus";
> +
> +		interrupt-parent = <&ipic>;
> +
> +		perf@0 {
> +			epic: interrupt-controller@18 {

Don't you need some reg properties in the perf and interrupt-controller
nodes so that the register address can be determined?

> +				compatible = "brcm,bcm63xx-epic";
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +			};
