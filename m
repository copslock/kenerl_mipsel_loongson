Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 19:36:18 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:33880 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990491AbdL1SgKwOapO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 19:36:10 +0100
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6B8FE607F5; Thu, 28 Dec 2017 18:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1514486167;
        bh=3AcgYxi9IN1tEFhoplsuRF3aIPWdMgvL5Mq8AJDpMZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XpnxqCXl65ZElaXaZXMxvPElE1ze988+RHCVhm55MVmU0L1/wu81vu+P0cKfl4eOp
         F2Dt6KoijN0ovTFCc7WyMiK7nEfF1VNv8VXWdzn/LfpNBFCzCwpNm8ex7SDi+qzWRZ
         BLB20u8uSp4ccAKX1vCl/C7Lj+UtgeOubLNdtN90=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B58886071B;
        Thu, 28 Dec 2017 18:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1514486166;
        bh=3AcgYxi9IN1tEFhoplsuRF3aIPWdMgvL5Mq8AJDpMZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkVXhcz6fhAeP/Geh75jMV2/4OQczVp5Aq7+0MmajP6WYbP9FcDRgbbQrXLCNZpnT
         1RlAI3xy6KR6lB+k1+5glh4NmfLkYC8/GfaEwWJnFy21a9FGgyqXnFw/HAxDWVIFx5
         2QqieKG37Ev5jXqFGScwKn0SxYwU0SmLvAXZjCwo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B58886071B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Thu, 28 Dec 2017 10:36:06 -0800
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 02/15] clk: ingenic: Fix recalc_rate for clocks with
 fixed divider
Message-ID: <20171228183606.GI7997@codeaurora.org>
References: <20170702163016.6714-2-paul@crapouillou.net>
 <20171228135634.30000-1-paul@crapouillou.net>
 <20171228135634.30000-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171228135634.30000-3-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61680
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

On 12/28, Paul Cercueil wrote:
> Previously, the clocks with a fixed divider would report their rate
> as being the same as the one of their parent, independently of the
> divider in use. This commit fixes this behaviour.
> 
> This went unnoticed as neither the jz4740 nor the jz4780 CGU code
> have clocks with fixed dividers yet.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
