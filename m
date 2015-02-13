Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Feb 2015 17:39:17 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:49068 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013389AbbBMQjO4np1v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Feb 2015 17:39:14 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BC2BC140C27;
        Fri, 13 Feb 2015 16:39:12 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id A349B140C6D; Fri, 13 Feb 2015 16:39:12 +0000 (UTC)
Received: from [10.134.64.202] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D23D4140C27;
        Fri, 13 Feb 2015 16:39:11 +0000 (UTC)
Message-ID: <54DE28AE.8060301@codeaurora.org>
Date:   Fri, 13 Feb 2015 08:39:10 -0800
From:   Stephen Boyd <sboyd@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-mips@linux-mips.org
CC:     Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Michael Turquette <mturquette@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Alchemy: Remove bogus args from alchemy_clk_fgcs_detr
References: <1423834499-13674-1-git-send-email-tomeu.vizoso@collabora.com>
In-Reply-To: <1423834499-13674-1-git-send-email-tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45812
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

On 02/13/15 05:34, Tomeu Vizoso wrote:
> They were added to this function by mistake when they were added to the
> clk_ops.determine_rate callback.
>
> Fixes: 1c8e600440c7 ("clk: Add rate constraints to clocks")
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
