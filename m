Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Mar 2016 13:05:06 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:53020 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014172AbcCQMFFBrAEr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Mar 2016 13:05:05 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 4179817DA; Thu, 17 Mar 2016 13:04:59 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 13F60468;
        Thu, 17 Mar 2016 13:04:59 +0100 (CET)
Date:   Thu, 17 Mar 2016 13:04:59 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
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
Message-ID: <20160317120459.GC3362@piout.net>
References: <1457217531-26064-1-git-send-email-paul@crapouillou.net>
 <1457217531-26064-2-git-send-email-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1457217531-26064-2-git-send-email-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

On 05/03/2016 at 23:38:48 +0100, Paul Cercueil wrote :
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

Trailing whitespace on that line.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
