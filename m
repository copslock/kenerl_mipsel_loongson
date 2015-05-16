Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 13:14:35 +0200 (CEST)
Received: from mail.kapsi.fi ([217.30.184.167]:51558 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011827AbbEPLOcQwSoo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 May 2015 13:14:32 +0200
Received: from [2001:708:30:12d0:beee:7bff:fe5b:f272]
        by mail.kapsi.fi with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <mikko.perttunen@kapsi.fi>)
        id 1Yta2j-0000iQ-9d; Sat, 16 May 2015 14:14:09 +0300
Message-ID: <5557267D.7080209@kapsi.fi>
Date:   Sat, 16 May 2015 14:14:05 +0300
From:   Mikko Perttunen <mikko.perttunen@kapsi.fi>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Stephen Boyd <sboyd@codeaurora.org>
CC:     Mike Turquette <mturquette@linaro.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        ascha Hauer <kernel@pengutronix.de>,
        David Brown <davidb@codeaurora.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>,
        Paul Walmsley <paul@pwsan.com>,
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
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        Tero Kristo <t-kristo@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, patches@opensource.wolfsonmicro.com,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, spear-devel@list.st.com,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH v2 1/2] clk: change clk_ops' ->round_rate() prototype
References: <1430407809-31147-1-git-send-email-boris.brezillon@free-electrons.com>      <1430407809-31147-2-git-send-email-boris.brezillon@free-electrons.com>  <20150507063953.GC32399@codeaurora.org> <20150507093702.0b58753d@bbrezillon> <20150515174048.4a31af49@bbrezillon>
In-Reply-To: <20150515174048.4a31af49@bbrezillon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:708:30:12d0:beee:7bff:fe5b:f272
X-SA-Exim-Mail-From: mikko.perttunen@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Return-Path: <mikko.perttunen@kapsi.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47434
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikko.perttunen@kapsi.fi
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

On 05/15/2015 06:40 PM, Boris Brezillon wrote:
> Hi Stephen,
>
> Adding Mikko in the loop (after all, he was the one complaining about
> this signed long limitation in the first place, and I forgot to add
> him in the Cc list :-/).

I think I got it through linux-tegra anyway, but thanks :)

>
> Mikko, are you okay with the approach proposed by Stephen (adding a
> new method) ?

Yes, sounds good to me. If a driver uses the existing methods with too 
large frequencies, the issue is pretty discoverable anyway. I think 
"adjust_rate" sounds a bit too much like it sets the clock's rate, 
though; perhaps "adjust_rate_request" or something like that?

Thanks,
Mikko

>
> On Thu, 7 May 2015 09:37:02 +0200
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>
>> Hi Stephen,
>>
>> On Wed, 6 May 2015 23:39:53 -0700
>> Stephen Boyd <sboyd@codeaurora.org> wrote:
>>
>>> On 04/30, Boris Brezillon wrote:
>>>> Clock rates are stored in an unsigned long field, but ->round_rate()
>>>> (which returns a rounded rate from a requested one) returns a long
>>>> value (errors are reported using negative error codes), which can lead
>>>> to long overflow if the clock rate exceed 2Ghz.
>>>>
>>>> Change ->round_rate() prototype to return 0 or an error code, and pass the
>>>> requested rate as a pointer so that it can be adjusted depending on
>>>> hardware capabilities.
>>>>
>>>> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>>>> Tested-by: Heiko Stuebner <heiko@sntech.de>
>>>> Tested-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
>>>> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>>>
>>> This patch is fairly invasive, and it probably doesn't even
>>> matter for most of these clock providers to be able to round a
>>> rate above 2GHz.
>>
>> Fair enough.
>>
>>> I've been trying to remove the .round_rate op
>>> from the framework by encouraging new features via the
>>> .determine_rate op.
>>
>> Oh, I wasn't aware of that (BTW, that's a good thing).
>> Maybe this should be clearly stated (both in the struct clk_ops
>> kerneldoc header and in Documentation/clk.txt).
>>
>>> Sadly, we still have to do a flag day and
>>> change all the .determine_rate ops when we want to add things.
>>
>> Yes, but the number of clk drivers implementing ->determine_rate() is
>> still quite limited compared to those implementing ->round_rate().
>>
>>>
>>> What if we changed determine_rate ops to take a struct
>>> clk_determine_info (or some better named structure) instead of
>>> the current list of arguments that it currently takes? Then when
>>> we want to make these sorts of framework wide changes we can just
>>> throw a new member into that structure and be done.
>>
>> I really like this idea, especially since I was wondering if we could
>> pass other 'clk rate requirements' like the rounding policy (down,
>> closest, up), or the maximum clk inaccuracy.
>>
>>>
>>> It doesn't solve the unsigned long to int return value problem
>>> though. We can solve that by gradually introducing a new op and
>>> handling another case in the rounding path. If we can come up
>>> with some good name for that new op like .decide_rate or
>>> something then it makes things nicer in the long run. I like the
>>> name .determine_rate though :/
>
> Okay, if you want a new method, how about this one:
>
> struct clk_adjust_rate_req {
> 	/* fields filled by the caller */
> 	unsigned long rate; /* rate is updated by the clk driver */
> 	unsigned long min;
> 	unsigned long max;
>
> 	/* fields filled by the clk driver */
> 	struct clk_hw *best_parent;
> 	unsigned long best_parent_rate;
>
> 	/*
> 	 * new fields I'd like to add at some point:
> 	 * unsigned long max_inaccuracy;
> 	 * something about the power consumption constraints :-)
> 	 */
> };
>
> int (*adjust_rate)(struct clk_hw *hw, struct clk_adjust_rate_req *req);
>
>>
>> Why not changing the ->determine_rate() prototype. As said above, the
>> number of clk drivers implementing this function is still quite
>> limited, and I guess we can have an ack for all of them.
>>
>>>
>>> The benefit of all this is that we don't have to worry about
>>> finding the random clk providers that get added into other
>>> subsystems and fixing them up. If drivers actually care about
>>> this problem then they'll be fixed to use the proper op. FYI,
>>> last time we updated the function signature of .determine_rate we
>>> broke a couple drivers along the way.
>>>
>>
>> Hm, IMHO, adding a new op is not a good thing. I agree that it eases
>> the transition, but ITOH you'll have to live with old/deprecated ops in
>> your clk_ops structure with people introducing new drivers still using
>> the old ops (see the number of clk drivers implementing ->round_rate()
>> instead of ->determine_rate()).
>>
>> Best Regards,
>>
>> Boris
>>
>
>
>
