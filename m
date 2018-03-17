Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Mar 2018 00:52:52 +0100 (CET)
Received: from merlin.infradead.org ([IPv6:2001:8b0:10b:1231::1]:60522 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994661AbeCQXwpCzM3h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Mar 2018 00:52:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3mLWtQcd5y/L2A2BbCpWy5Gi3V0YT31DAUQiAPHSdi8=; b=TbaNy1rBhelahb6uqB5G0MiPa5
        5D0gJPiNJsTPvEwlOraIwKsY60u8MNVKRh3EtoVxNZNGnZrBgY0DPrJbOoGtnjNT+wGRdKqJCGJOu
        v8xupFLsp2+38knm9rCwWxjtGfZ+Sla04U2PyzVSd2UUa1JXmvvfpZt80wxJLlsMBx9lE8HtzVklB
        PU4dwKikVfUs8iJA2L3IbVA9+4kDq4HdiPsecCjSLXlBBw8+11G0wBY1ENLzXCBqIQ9M98lzq4yOx
        x9eCls3yX44hYrn/3xHb/z3q7UYBNhiKeESv9mUHfdt05GRDKh+wpVys6xmcorWZE6/9O0vlbUHaJ
        Pg4AWIKA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1exLcp-00058B-5k; Sat, 17 Mar 2018 23:52:35 +0000
Subject: Re: [PATCH v4 3/8] doc: Add doc for the Ingenic TCU hardware
To:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org
References: <20180110224838.16711-2-paul@crapouillou.net>
 <20180317232901.14129-1-paul@crapouillou.net>
 <20180317232901.14129-4-paul@crapouillou.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1e5b82ca-5ac3-6e98-d40b-67916008b485@infradead.org>
Date:   Sat, 17 Mar 2018 16:52:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180317232901.14129-4-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <rdunlap@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63024
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@infradead.org
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

On 03/17/2018 04:28 PM, Paul Cercueil wrote:
> Add a documentation file about the Timer/Counter Unit (TCU)
> present in the Ingenic JZ47xx SoCs.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/mips/00-INDEX        |  3 +++
>  Documentation/mips/ingenic-tcu.txt | 50 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/mips/ingenic-tcu.txt
> 
>  v4: New patch in this series

> diff --git a/Documentation/mips/ingenic-tcu.txt b/Documentation/mips/ingenic-tcu.txt
> new file mode 100644
> index 000000000000..2508e5793da8
> --- /dev/null
> +++ b/Documentation/mips/ingenic-tcu.txt
> @@ -0,0 +1,50 @@
> +Ingenic JZ47xx SoCs Timer/Counter Unit hardware
> +-----------------------------------------------
> +
> +The Timer/Counter Unit (TCU) in Ingenic JZ47xx SoCs is a multi-function
> +hardware block. It features eight channels, that can be used as counters,

                    drop comma ............. ^

> +timers, or PWM.
> +
> +- JZ4770 introduced a separate channel, called Operating System Timer (OST).
> +  It is a 64-bit programmable timer.
> +
> +- Each one of the eight channels has its own clock, which can be reparented
> +  to three different clocks (pclk, ext, rtc), gated, and reclocked, through
> +  their TCSR register.
> +  * The watchdog and OST hardware blocks also feature a TCSR register with
> +	the same format in their register space.
> +  * The TCU registers used to gate/ungate can also gate/ungate the watchdog
> +	and OST clocks.
> +
> +- On SoCs >= JZ4770, there are two different modes:
> +  * Channels 0, 3-7 operate in TCU1 mode: they cannot work in sleep mode,
> +	but are easier to operate.
> +  * Channels 1-2 operate in TCU2 mode: they can work in sleep mode, but
> +	the operation is a bit more complicated than with TCU1 channels.
> +
> +- Each channel can generate an interrupt. Some channels share an interrupt	
> +  line, some don't, and this changes between SoC versions:
> +  * on JZ4740, timer 0 and timer 1 have their own interrupt line; others share
> +	one interrupt line.
> +  * on JZ4770 and JZ4780, timer 5 has its own interrupt; timers 0-4 and 6-7 all
> +	use one interrupt line; the OST uses the last interrupt.

"The OST uses the last interrupt." is not clear to someone who doesn't know
about this hardware. (I can read it several ways.)

Does it mean that the 4770 and 4780 have 3 interrupt lines used like so?

- timer 5 uses one interrupt line
- timers 0-4 and 6-7 use a second interrupt line
- the OST uses a third interrupt line


thanks,
-- 
~Randy
