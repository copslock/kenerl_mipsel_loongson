Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2016 12:03:24 +0100 (CET)
Received: from smtp2-g21.free.fr ([212.27.42.2]:29800 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010663AbcBALDXTjpvA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2016 12:03:23 +0100
Received: from tock (unknown [176.0.132.117])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 4B29A4B01A9;
        Mon,  1 Feb 2016 12:00:59 +0100 (CET)
Date:   Mon, 1 Feb 2016 12:03:00 +0100
From:   Alban <albeu@free.fr>
To:     Antony Pavlov <antonynpavlov@gmail.com>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC v3 01/14] WIP: clk: add Atheros AR724X/AR913X/AR933X SoCs
 clock driver
Message-ID: <20160201120300.3d6fd1b3@tock>
In-Reply-To: <20160131234155.eee918745880878963c044aa@gmail.com>
References: <1453580251-2341-1-git-send-email-antonynpavlov@gmail.com>
        <1453580251-2341-2-git-send-email-antonynpavlov@gmail.com>
        <20160125232156.35c0ce3f@tock>
        <20160131234155.eee918745880878963c044aa@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

On Sun, 31 Jan 2016 23:41:55 +0300
Antony Pavlov <antonynpavlov@gmail.com> wrote:

> > > +	ath79_clks[ATH79_CLK_REF] = ath79_add_sys_clkdev("ref", ref_rate);
> > > +	ath79_clks[ATH79_CLK_CPU] = ath79_add_sys_clkdev("cpu", cpu_rate);
> > > +	ath79_clks[ATH79_CLK_DDR] = ath79_add_sys_clkdev("ddr", ddr_rate);
> > > +	ath79_clks[ATH79_CLK_AHB] = ath79_add_sys_clkdev("ahb", ahb_rate);
> > > +	ath79_clks[ATH79_CLK_WDT] = ath79_add_sys_clkdev("wdt", ahb_rate);
> > > +	ath79_clks[ATH79_CLK_UART] = ath79_add_sys_clkdev("uart", ahb_rate);  
> > 
> > You shouldn't add ref, wdt and uart, they are not needed and make the
> > driver incompatible with the current DT bindings.  
> 
> Please describe the situation then this incompatibility does matter.
> 
> Current ath79 dt support is very preliminary and the only dt user
> is 5-years old TP-Link WR1043ND so it's near impossible to break somethink.
> 
> Anyway current ath79 dt binding is somewhat broken (see __your__ message
> 'Re: [RFC 1/4] WIP: MIPS: ath79: make ar933x clks more
> devicetree-friendly' from 'Thu, 21 Jan 2016 12:03:20 +0100').

The point is that DT is about describing the hardware in a consistent
and OS independent manner. It shouldn't be modeled just to suit some
existing code. So it is no big deal if the code doesn't use all the
informations provided by the DT, like here where the input clock is not
*yet* used by the code. However it is a no-go to extend the binding to
add things that don't exists in the hardware just to suit some old code.

I agree we might need to clear a few things regarding the UART clock in
the newer SoC, in particular if the UART use the output of the PLL
pre-divider or something similar. Then we would need to rework the DT
binding for the those SoC. However with the current knowledge I don't
see any need to change the biding yet.

Alban
