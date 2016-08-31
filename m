Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 00:51:25 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:42264 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992002AbcHaWvPwGKoe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 00:51:15 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 215AA61EA1; Wed, 31 Aug 2016 22:51:14 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1C4761E93;
        Wed, 31 Aug 2016 22:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.1 smtp.codeaurora.org A1C4761E93
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=sboyd@codeaurora.org
Date:   Wed, 31 Aug 2016 15:51:13 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Yang Ling <gnaygnil@gmail.com>
Cc:     keguang.zhang@gmail.com, mturquette@baylibre.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] CLK: Add Loongson1C clock support
Message-ID: <20160831225113.GL12510@codeaurora.org>
References: <20160822045034.GA6545@ly-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160822045034.GA6545@ly-pc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54914
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

On 08/22, Yang Ling wrote:
> This patch adds clock support to Loongson1C SoC.
> 
> Signed-off-by: Yang Ling <gnaygnil@gmail.com>
> 

It would be better to use the new clk_hw_*() and clkdev_hw_*()
registration APIs. Care to make that change? Obviously
clk_register_pll() isn't going to work there, but we can fix that
later.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
