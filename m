Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2015 10:46:53 +0200 (CEST)
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13368 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006602AbbFHIqtyvdUq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Jun 2015 10:46:49 +0200
Received: from hqnvupgp07.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com
        id <B557556760001>; Mon, 08 Jun 2015 01:46:46 -0700
Received: from HQMAIL107.nvidia.com ([172.20.12.94])
  by hqnvupgp07.nvidia.com (PGP Universal service);
  Mon, 08 Jun 2015 01:44:02 -0700
X-PGP-Universal: processed;
        by hqnvupgp07.nvidia.com on Mon, 08 Jun 2015 01:44:02 -0700
Received: from UKMAIL101.nvidia.com (10.26.138.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1044.25; Mon, 8 Jun
 2015 08:46:41 +0000
Received: from [10.21.134.107] (10.21.134.107) by UKMAIL101.nvidia.com
 (10.26.138.13) with Microsoft SMTP Server (TLS) id 15.0.1044.25; Mon, 8 Jun
 2015 08:46:36 +0000
Message-ID: <5575566A.4060503@nvidia.com>
Date:   Mon, 8 Jun 2015 09:46:34 +0100
From:   Jon Hunter <jonathanh@nvidia.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
CC:     Paul Walmsley <paul@pwsan.com>,
        Mike Turquette <mturquette@linaro.org>,
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
        =?windows-1252?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Stephen Warren" <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Tero Kristo <t-kristo@ti.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
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
References: <1430407809-31147-1-git-send-email-boris.brezillon@free-electrons.com> <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com> <alpine.DEB.2.02.1506042258530.12316@utopia.booyaka.com> <557161D1.3040107@nvidia.com> <20150605133928.66909901@bbrezillon>
In-Reply-To: <20150605133928.66909901@bbrezillon>
X-Originating-IP: [10.21.134.107]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To UKMAIL101.nvidia.com
 (10.26.138.13)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <jonathanh@nvidia.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47901
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

Hi Boris,

On 05/06/15 12:39, Boris Brezillon wrote:
> Hi Jon,
> 
> On Fri, 5 Jun 2015 09:46:09 +0100
> Jon Hunter <jonathanh@nvidia.com> wrote:
> 
>>
>> On 05/06/15 00:02, Paul Walmsley wrote:
>>> Hi folks
>>>
>>> just a brief comment on this one:
>>>
>>> On Thu, 30 Apr 2015, Boris Brezillon wrote:
>>>
>>>> Clock rates are stored in an unsigned long field, but ->round_rate()
>>>> (which returns a rounded rate from a requested one) returns a long
>>>> value (errors are reported using negative error codes), which can lead
>>>> to long overflow if the clock rate exceed 2Ghz.
>>>>
>>>> Change ->round_rate() prototype to return 0 or an error code, and pass the
>>>> requested rate as a pointer so that it can be adjusted depending on
>>>> hardware capabilities.
>>>
>>> ...
>>>
>>>> diff --git a/Documentation/clk.txt b/Documentation/clk.txt
>>>> index 0e4f90a..fca8b7a 100644
>>>> --- a/Documentation/clk.txt
>>>> +++ b/Documentation/clk.txt
>>>> @@ -68,8 +68,8 @@ the operations defined in clk.h:
>>>>  		int		(*is_enabled)(struct clk_hw *hw);
>>>>  		unsigned long	(*recalc_rate)(struct clk_hw *hw,
>>>>  						unsigned long parent_rate);
>>>> -		long		(*round_rate)(struct clk_hw *hw,
>>>> -						unsigned long rate,
>>>> +		int		(*round_rate)(struct clk_hw *hw,
>>>> +						unsigned long *rate,
>>>>  						unsigned long *parent_rate);
>>>>  		long		(*determine_rate)(struct clk_hw *hw,
>>>>  						unsigned long rate,
>>>
>>> I'd suggest that we should probably go straight to 64-bit rates.  There 
>>> are already plenty of clock sources that can generate rates higher than 
>>> 4GiHz.
>>
>> An alternative would be to introduce to a frequency "base" the default
>> could be Hz (for backwards compatibility), but for CPUs we probably only
>> care about MHz (or may be kHz) and so 32-bits would still suffice. Even
>> if CPUs cared about Hz they could still use Hz, but in that case they
>> probably don't care about GHz. Obviously, we don't want to break DT
>> compatibility but may be the frequency base could be defined in DT and
>> if it is missing then Hz is assumed. Just a thought ...
> 
> Yes, but is it really worth the additional complexity. You'll have to
> add the unit information anyway, so using an unsigned long for the
> value and another field for the unit (an enum ?) is just like using a
> 64 bit integer.

For a storage perspective, yes it would be the same. However, there are
probably a lot of devices that would not need the extra range, but would
now have to deal with 64-bit types. I have no idea how much overhead
that would be in reality. If the overhead is negligible then a 64-bit
type is definitely the way to go, as I agree it is simpler and cleaner.

Cheers
Jon
