Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 20:46:59 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:37961 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012353AbbEASq5TMmAS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 20:46:57 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 4BC5114162A;
        Fri,  1 May 2015 18:46:57 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 39671141643; Fri,  1 May 2015 18:46:57 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EA5214162A;
        Fri,  1 May 2015 18:46:56 +0000 (UTC)
Date:   Fri, 1 May 2015 11:46:55 -0700
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
Subject: Re: [PATCH v2 3/8] clk: tegra: Fix inconsistent indenting
Message-ID: <20150501184655.GA29653@codeaurora.org>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
 <1430196383-9190-4-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430196383-9190-4-git-send-email-k.kozlowski@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47185
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
> Fix the indentation - spaces used instead of tabs and actually wrong
> number of spaces.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/clk/tegra/clk-emc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

What branch is this against? I don't see this in linux-next or
clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
