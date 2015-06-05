Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jun 2015 10:46:30 +0200 (CEST)
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18194 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007354AbbFEIq1WR9sO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jun 2015 10:46:27 +0200
Received: from hqnvupgp08.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com
        id <B557161e50000>; Fri, 05 Jun 2015 01:46:30 -0700
Received: from hqemhub02.nvidia.com ([172.20.12.94])
  by hqnvupgp08.nvidia.com (PGP Universal service);
  Fri, 05 Jun 2015 01:42:28 -0700
X-PGP-Universal: processed;
        by hqnvupgp08.nvidia.com on Fri, 05 Jun 2015 01:42:28 -0700
Received: from UKMAIL101.nvidia.com (10.26.138.13) by hqemhub02.nvidia.com
 (172.20.150.31) with Microsoft SMTP Server (TLS) id 8.3.342.0; Fri, 5 Jun
 2015 01:46:19 -0700
Received: from [10.21.144.144] (10.21.144.144) by UKMAIL101.nvidia.com
 (10.26.138.13) with Microsoft SMTP Server (TLS) id 15.0.1044.25; Fri, 5 Jun
 2015 08:46:11 +0000
Message-ID: <557161D1.3040107@nvidia.com>
Date:   Fri, 5 Jun 2015 09:46:09 +0100
From:   Jon Hunter <jonathanh@nvidia.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Paul Walmsley <paul@pwsan.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
CC:     Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        ascha Hauer <kernel@pengutronix.de>,
        David Brown <davidb@codeaurora.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Viresh Kumar <viresh.linux@gmail.com>,
        =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Tero Kristo <t-kristo@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <patches@opensource.wolfsonmicro.com>,
        <linux-rockchip@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <spear-devel@list.st.com>,
        <linux-tegra@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-media@vger.kernel.org>, <rtc-linux@googlegroups.com>
Subject: Re: [PATCH v2 1/2] clk: change clk_ops' ->round_rate() prototype
References: <1430407809-31147-1-git-send-email-boris.brezillon@free-electrons.com> <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com> <alpine.DEB.2.02.1506042258530.12316@utopia.booyaka.com>
In-Reply-To: <alpine.DEB.2.02.1506042258530.12316@utopia.booyaka.com>
X-Originating-IP: [10.21.144.144]
X-ClientProxiedBy: UKMAIL101.nvidia.com (10.26.138.13) To UKMAIL101.nvidia.com
 (10.26.138.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <jonathanh@nvidia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonathanh@nvidia.com
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


On 05/06/15 00:02, Paul Walmsley wrote:
> Hi folks
> 
> just a brief comment on this one:
> 
> On Thu, 30 Apr 2015, Boris Brezillon wrote:
> 
>> Clock rates are stored in an unsigned long field, but ->round_rate()
>> (which returns a rounded rate from a requested one) returns a long
>> value (errors are reported using negative error codes), which can lead
>> to long overflow if the clock rate exceed 2Ghz.
>>
>> Change ->round_rate() prototype to return 0 or an error code, and pass the
>> requested rate as a pointer so that it can be adjusted depending on
>> hardware capabilities.
> 
> ...
> 
>> diff --git a/Documentation/clk.txt b/Documentation/clk.txt
>> index 0e4f90a..fca8b7a 100644
>> --- a/Documentation/clk.txt
>> +++ b/Documentation/clk.txt
>> @@ -68,8 +68,8 @@ the operations defined in clk.h:
>>  		int		(*is_enabled)(struct clk_hw *hw);
>>  		unsigned long	(*recalc_rate)(struct clk_hw *hw,
>>  						unsigned long parent_rate);
>> -		long		(*round_rate)(struct clk_hw *hw,
>> -						unsigned long rate,
>> +		int		(*round_rate)(struct clk_hw *hw,
>> +						unsigned long *rate,
>>  						unsigned long *parent_rate);
>>  		long		(*determine_rate)(struct clk_hw *hw,
>>  						unsigned long rate,
> 
> I'd suggest that we should probably go straight to 64-bit rates.  There 
> are already plenty of clock sources that can generate rates higher than 
> 4GiHz.

An alternative would be to introduce to a frequency "base" the default
could be Hz (for backwards compatibility), but for CPUs we probably only
care about MHz (or may be kHz) and so 32-bits would still suffice. Even
if CPUs cared about Hz they could still use Hz, but in that case they
probably don't care about GHz. Obviously, we don't want to break DT
compatibility but may be the frequency base could be defined in DT and
if it is missing then Hz is assumed. Just a thought ...

Jon
