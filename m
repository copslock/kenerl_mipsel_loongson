Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 17:55:33 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.11.231]:42509 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6865297Ab3HHPz0iTEtf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Aug 2013 17:55:26 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 0118D13EF6B;
        Thu,  8 Aug 2013 15:55:19 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id E71F513EF93; Thu,  8 Aug 2013 15:55:18 +0000 (UTC)
Received: from [192.168.1.103] (99-51-185-173.lightspeed.austtx.sbcglobal.net [99.51.185.173])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: galak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 089D413EF89;
        Thu,  8 Aug 2013 15:55:17 +0000 (UTC)
Subject: Re: [PATCH V2 1/2] DT: Add documentation for ralink-wdt
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From:   Kumar Gala <galak@codeaurora.org>
In-Reply-To: <1375954919-30737-1-git-send-email-blogic@openwrt.org>
Date:   Thu, 8 Aug 2013 10:55:15 -0500
Cc:     Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0631E84C-AC6E-4B75-9073-D6A2BFD9EB02@codeaurora.org>
References: <1375954919-30737-1-git-send-email-blogic@openwrt.org>
To:     John Crispin <blogic@openwrt.org>
X-Mailer: Apple Mail (2.1283)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <galak@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: galak@codeaurora.org
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


On Aug 8, 2013, at 4:41 AM, John Crispin wrote:

> Describe ralink-wdt binding.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: devicetree@vger.kernel.org
> ---
> V1 used the old devicetree list as Cc.
> 
> .../devicetree/bindings/watchdog/ralink-wdt.txt     |   19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/watchdog/ralink-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt b/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt
> new file mode 100644
> index 0000000..a70f0e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/ralink-wdt.txt

Seems like this should be ralink-rt2880-wdt.txt (I'm guessing there are other ralink watchdog timers).

> @@ -0,0 +1,19 @@
> +Ralink Watchdog Timers

Should probably be Ralink RT2880 Watchdog Timer

> +
> +Required properties :
> +- compatible: must be "ralink,rt2880-wdt"
> +- reg: physical base address of the controller and length of the register range
> +
> +Optional properties :
> +- interrupt-parent: phandle to the INTC device node
> +- interrupts : Specify the INTC interrupt number

Since you'll be updating this to drop 'ralink,mt7620a-wdt' how about cleaning up the whitespace around ' :'

> +
> +Example:
> +
> +	watchdog@120 {
> +		compatible = "ralink,mt7620a-wdt", "ralink,rt2880-wdt";
> +		reg = <0x120 0x10>;
> +
> +		interrupt-parent = <&intc>;
> +		interrupts = <1>;
> +	};
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


- k

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
