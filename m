Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Feb 2015 17:27:35 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.10]:64786 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012516AbbBDQ1eeWJR3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Feb 2015 17:27:34 +0100
Received: from wuerfel.localnet ([149.172.15.242]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0LeAyi-1XrjO50T9Q-00pxuH; Wed, 04 Feb
 2015 17:27:25 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, mturquette@linaro.org,
        sboyd@codeaurora.org, ralf@linux-mips.org, jslaby@suse.cz,
        tglx@linutronix.de, jason@lakedaemon.net, lars@metafoo.de,
        paul.burton@imgtec.com
Subject: Re: [PATCH_V2 15/34] dt: clk: Add ingenic,jz4740-cgu binding documentation
Date:   Wed, 04 Feb 2015 17:27:23 +0100
Message-ID: <33166978.Cd8LolvEG6@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1423063323-19419-16-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1423063323-19419-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1423063323-19419-16-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID:  V03:K0:5+1f/x6rTTDVNROSBa0kapTj6s3NVRHR0xf4GtNrLeSfXBGi7yo
 yhQljGT9hue/L6L1zZ8wMW028FDq5xhp2yvG3DmH5UIEW/2hisf9gSMyzXV6XIVQax4N15C
 4pZNolb22SkEK0iLm7oOV9zQDgOQFl3SkJD0hDutb/iwunieqo6zXhefkqKbc+lnORWDqGU
 BR40jfxBcEGRxIEWazp4A==
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wednesday 04 February 2015 15:21:44 Zubair Lutfullah Kakakhel wrote:
> 
> +/ {
> +       ext: clock@0 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <12000000>;
> +       };
> +
> +       rtc: clock@1 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <32768>;
> +       };
> +
> +       &cgu {
> +               clocks = <&ext> <&rtc>;
> +               clock-names: "ext", "rtc";
> +       };
> +};
> diff --git a/include/dt-bindings/clock/jz4740-cgu.h b/include/dt-bindings/clock/jz4740-cgu.h
> new file mode 100644
> index 0000000..43153d3
> --- /dev/null
> +++ b/include/dt-bindings/clock/jz4740-cgu.h
> @@ -0,0 +1,37 @@
> +/*
> + * This header provides clock numbers for the ingenic,jz4740-cgu DT binding.
> + *
> + * They are roughly ordered as:
> + *   - external clocks
> + *   - PLLs
> + *   - muxes/dividers in the order they appear in the jz4740 programmers manual
> + *   - gates in order of their bit in the CLKGR* registers
> + */
> +
> +#ifndef __DT_BINDINGS_CLOCK_JZ4740_CGU_H__
> +#define __DT_BINDINGS_CLOCK_JZ4740_CGU_H__
> +
> +#define JZ4740_CLK_EXT         0
> +#define JZ4740_CLK_RTC         1
> +#define JZ4740_CLK_PLL         2
> +#define JZ4740_CLK_PLL_HALF    3

So there are fixed clocks for ext and rtc that are used as inputs
to the cgu, but also outputs with the same name. How do these relate?

	Arnd
