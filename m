Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 20:51:21 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:38223 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012353AbbEASvTGFO8F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 20:51:19 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 9D8E0141698;
        Fri,  1 May 2015 18:51:19 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 8305C14169C; Fri,  1 May 2015 18:51:19 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1FB9141698;
        Fri,  1 May 2015 18:51:18 +0000 (UTC)
Date:   Fri, 1 May 2015 11:51:17 -0700
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
Subject: Re: [PATCH v2 8/8] MIPS: Alchemy: Remove unneeded cast removing const
Message-ID: <20150501185117.GB29653@codeaurora.org>
References: <1430196383-9190-1-git-send-email-k.kozlowski@samsung.com>
 <1430196383-9190-9-git-send-email-k.kozlowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1430196383-9190-9-git-send-email-k.kozlowski@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47186
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
> Parent names in clock init data is now array of const pointers to const
> strings so the cast is not needed.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

I can take this through clk-next with an ack from Ralf.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
