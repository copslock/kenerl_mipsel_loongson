Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jul 2015 20:07:48 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:35127 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010837AbbGHSHq2mR0T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Jul 2015 20:07:46 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 00BA514133C;
        Wed,  8 Jul 2015 18:07:44 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id DE8B51413A6; Wed,  8 Jul 2015 18:07:43 +0000 (UTC)
Received: from [10.134.64.202] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3A1A14133C;
        Wed,  8 Jul 2015 18:07:42 +0000 (UTC)
Message-ID: <559D66EE.4060707@codeaurora.org>
Date:   Wed, 08 Jul 2015 11:07:42 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Boris Brezillon <boris.brezillon@free-electrons.com>
CC:     Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?RW1pbGlvIEzDs3Bleg==?= <emilio@elopez.com.ar>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Tero Kristo <t-kristo@ti.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mips@linux-mips.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v5] clk: change clk_ops' ->determine_rate() prototype
References: <1436294888-25752-1-git-send-email-boris.brezillon@free-electrons.com>      <20150708005748.GG30412@codeaurora.org> <20150708110005.704c49ff@bbrezillon>
In-Reply-To: <20150708110005.704c49ff@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@codeaurora.org
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

On 07/08/2015 02:00 AM, Boris Brezillon wrote:
> Hi Stephen,
>
> On Tue, 7 Jul 2015 17:57:48 -0700
> Stephen Boyd <sboyd@codeaurora.org> wrote:
>
>> On 07/07, Boris Brezillon wrote:
>>>
>>>  	} else {
>>>  		pr_err("clk: clk_composite_determine_rate function called, but no mux or rate callback set!\n");
>>> +		req->rate = 0;
>>>  		return 0;
>> Shouldn't this return an error now? And then assigning req->rate
>> wouldn't be necessary. Sorry I must have missed this last round.
>>
> Actually I wanted to keep the existing behavior: return a 0 rate (not
> an error) when there is no mux or rate ops.
>
> That's something we can change afterwards, but it might reveals
> new bugs if some users are checking for a 0 rate to detect errors.
>

Ok. Care to send the patch now to do that while we're thinking about it?
We can test it out for a month or two.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
