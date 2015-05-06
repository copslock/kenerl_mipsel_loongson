Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 May 2015 07:56:57 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:51698 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011764AbbEFF4zcb3wR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 May 2015 07:56:55 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6B4961409F8;
        Wed,  6 May 2015 05:56:55 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 4DDEA1409FF; Wed,  6 May 2015 05:56:55 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83DC81409F8;
        Wed,  6 May 2015 05:56:54 +0000 (UTC)
Date:   Tue, 5 May 2015 22:56:53 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Turquette <mturquette@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Barry Song <baohua@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alexandre Courbot <gnurou@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH v2 0/8] clk: Minor cleanups
Message-ID: <20150506055653.GF10871@codeaurora.org>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47249
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

On 04/28, Krzysztof Kozlowski wrote:
> Hi,
> 
> 
> Changes since v1
> ================
> 1. Rebase on next-20150427 and Sascha Hauer's:
>    clk: make strings in parent name arrays const [1]
> 2. Add patch "clk: tegra: Fix inconsistent indenting".
> 
> 
> Description and dependencies
> ============================
> Small cleanups for different clock drivers.
> 
> The first three patches are independent.
> 
> Rest of the patches (these related to constifying parent names,
> including the change for MIPS) depend on the "clk: make strings in
> parent name arrays const" from Sascha Hauer [1].
> 
> 
> Tested on Arndale Octa (Exynos5420) and Trats2 (Exynos4412). Other
> drivers (and MIPS related) only compile tested plus some static
> checkers.
> 
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg413763.html
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (8):
>   clk: rockchip: Staticize file-scope declarations
>   clk: exynos: Staticize file-scope declarations
>   clk: tegra: Fix inconsistent indenting
>   clk: tegra: Fix duplicate const for parent names
>   clk: cdce706: Constify parent names in clock init data
>   clk: sirf: Constify parent names in clock init data
>   clk: ls1x: Fix duplicate const for parent names
>   MIPS: Alchemy: Remove unneeded cast removing const

Applied 1,2,5,6,7 to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
