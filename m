Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 12:52:33 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:33931 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013911AbcCQLwcGvQBr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Mar 2016 12:52:32 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 08A31201C0;
        Thu, 17 Mar 2016 11:52:30 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD9020160;
        Thu, 17 Mar 2016 11:52:28 +0000 (UTC)
Date:   Thu, 17 Mar 2016 06:52:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Paul Burton <paul.burton@imgtec.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH 2/5] Documentation: dt: Add binding info for jz4740-rtc
 driver
Message-ID: <20160317115225.GA18144@rob-hp-laptop>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-2-git-send-email-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457217531-26064-2-git-send-email-paul@crapouillou.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52634
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

On Sat, Mar 05, 2016 at 11:38:48PM +0100, Paul Cercueil wrote:
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/rtc/ingenic,jz4740-rtc.txt | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> new file mode 100644
> index 0000000..71e4ad0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/ingenic,jz4740-rtc.txt
> @@ -0,0 +1,38 @@
> +JZ4740 and similar SoCs real-time clock driver
> +
> +Required properties:
> +
> +- compatible: One of:
> +  - "ingenic,jz4740-rtc" - for use with the JZ4740 SoC
> +  - "ingenic,jz4780-rtc" - for use with the JZ4780 SoC
> +- reg: Address range of rtc register set
> +- interrupts: IRQ number for the alarm interrupt
> +- interrupt-parent: phandle of the interrupt controller
> +- clocks: phandle to the "rtc" clock
> +- clock-names: must be "rtc"
> +
> +Optional properties:
> +- system-power-controller: To use this component as the
> +  system power controller

> +- reset-pin-assert-time: Reset pin low-level assertion time
> +  after wakeup (default 60ms; range 0-125ms if RTC clock at 
> +  32 kHz)
> +- min-wakeup-pin-assert-time: Minimum wakeup pin assertion time
> +  (default 100ms; range 0-2s if RTC clock at 32 kHz)

Please append units on these (-msec).

> +
> +Example:
> +
> +rtc@10003000 {
> +	compatible = "ingenic,jz4740-rtc";
> +	reg = <0x10003000 0x3F>;
> +
> +	interrupt-parent = <&intc>;
> +	interrupts = <32>;
> +
> +	clocks = <&rtc_clock>;
> +	clock-names = "rtc";
> +
> +	system-power-controller;
> +	reset-pin-assert-time = <60>;
> +	min-wakeup-pin-assert-time = <100>;
> +};
> -- 
> 2.7.0
> 
