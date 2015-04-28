Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 17:11:52 +0200 (CEST)
Received: from mail.kapsi.fi ([217.30.184.167]:57075 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026218AbbD1PLvK56fv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Apr 2015 17:11:51 +0200
Received: from [2001:708:30:12d0:beee:7bff:fe5b:f272]
        by mail.kapsi.fi with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <mikko.perttunen@kapsi.fi>)
        id 1Yn7AY-0001Zj-RK; Tue, 28 Apr 2015 18:11:30 +0300
Message-ID: <553FA320.4040006@kapsi.fi>
Date:   Tue, 28 Apr 2015 18:11:28 +0300
From:   Mikko Perttunen <mikko.perttunen@kapsi.fi>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Boris Brezillon <boris.brezillon@free-electrons.com>,
        Mike Turquette <mturquette@linaro.org>
CC:     Jonathan Corbet <corbet@lwn.net>, Shawn Guo <shawn.guo@linaro.org>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, patches@opensource.wolfsonmicro.com,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, spear-devel@list.st.com,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH 1/2] clk: change clk_ops' ->round_rate() prototype
References: <1429255769-13639-1-git-send-email-boris.brezillon@free-electrons.com> <1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1429255769-13639-2-git-send-email-boris.brezillon@free-electrons.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:708:30:12d0:beee:7bff:fe5b:f272
X-SA-Exim-Mail-From: mikko.perttunen@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Return-Path: <mikko.perttunen@kapsi.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47136
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

The series

Tested-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>

on Jetson-TK1.

I rebased my cpufreq series on top of this and everything's working well 
now. :)

Thanks,
Mikko.

On 04/17/2015 10:29 AM, Boris Brezillon wrote:
> ...
