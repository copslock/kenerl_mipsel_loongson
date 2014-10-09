Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 03:32:43 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.11.231]:40809 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010844AbaJIBcmFDpYB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 03:32:42 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1CEAB13F7D5;
        Thu,  9 Oct 2014 01:32:34 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 034D513F907; Thu,  9 Oct 2014 01:32:33 +0000 (UTC)
Received: from [10.46.167.8] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 322D013F92C;
        Thu,  9 Oct 2014 01:32:33 +0000 (UTC)
Message-ID: <5435E5B0.90900@codeaurora.org>
Date:   Wed, 08 Oct 2014 18:32:32 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
CC:     Mike Turquette <mturquette@linaro.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Alex Elder <elder@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-omap@vger.kernel.org,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Matt Porter <mporter@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Tim Kryger <tim.kryger@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v2 0/8] Per-user clock constraints
References: <1412695334-2608-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1412695334-2608-1-git-send-email-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43113
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

On 10/07/2014 08:21 AM, Tomeu Vizoso wrote:
> Hello,
>
> this second version of the series adds several cleanups that were suggested by
> Stephen Boyd and contains several improvements to the seventh patch (clk: Make
> clk API return per-user struct clk instances) that were suggested by him during
> the review of v1.
>
> The first six patches are just cleanups that should be desirable on their own,
> and that should make easier to review the actual per-user clock patch.
>
> The seventh patch actually moves the per-clock data that was stored in struct
> clk to a new struct clk_core and adds references to it from both struct clk and
> struct clk_hw. struct clk is now ready to contain information that is specific
> to a given clk consumer.
>
> The eighth patch adds API for setting floor and ceiling constraints and stores
> that information on the per-user struct clk, which is iterable from struct
> clk_core.
>
>

As said in the patches, can you please indicate which baseline this is 
on? Also can you rebase onto clk-next if you send again before that is 
merged into 3.18-rc1? There are some changes in the debugfs part that 
will conflict. I'll review the more complicated parts in detail soon.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
