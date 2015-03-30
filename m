Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 02:00:01 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:37243 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010143AbbC3X77dkLhA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 01:59:59 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1A1D8141994;
        Mon, 30 Mar 2015 23:59:58 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 0A8561419A5; Mon, 30 Mar 2015 23:59:58 +0000 (UTC)
Received: from [10.134.64.202] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87EB8141994;
        Mon, 30 Mar 2015 23:59:57 +0000 (UTC)
Message-ID: <5519E37C.9010201@codeaurora.org>
Date:   Mon, 30 Mar 2015 16:59:56 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>,
        Mike Turquette <mturquette@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 2/7] clk: Add basic infrastructure for Pistachio clocks
References: <1424836567-7252-1-git-send-email-abrestic@chromium.org> <1424836567-7252-3-git-send-email-abrestic@chromium.org>
In-Reply-To: <1424836567-7252-3-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46630
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

On 02/24/15 19:56, Andrew Bresticker wrote:
> +
> +void pistachio_clk_force_enable(struct pistachio_clk_provider *p,
> +				unsigned int *clk_ids, unsigned int num)
> +{
> +	unsigned int i;
> +	int err;
> +
> +	for (i = 0; i < num; i++) {
> +		struct clk *clk = p->clk_data.clks[clk_ids[i]];
> +
> +		if (IS_ERR(clk))
> +			continue;
> +
> +		err = clk_prepare_enable(clk);
> +		if (err)
> +			pr_err("Failed to enable clock %s: %d\n",
> +			       __clk_get_name(clk), err);
> +	}
> +}
>

Is this to workaround some problems in the framework where clocks are
turned off? Or is it that these clocks are already on before we boot
Linux and we need to make sure the framework knows that?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
