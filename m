Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 02:03:45 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:42896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992067AbcHSADi2g1ge (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 02:03:38 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9989161CE1; Fri, 19 Aug 2016 00:03:37 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0698761CC8;
        Fri, 19 Aug 2016 00:03:36 +0000 (UTC)
Date:   Thu, 18 Aug 2016 17:03:36 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 2/3] clk: Loongson1: Update clocks of Loongson1B
Message-ID: <20160819000336.GL361@codeaurora.org>
References: <1470999108-9851-1-git-send-email-keguang.zhang@gmail.com>
 <1470999108-9851-3-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1470999108-9851-3-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54666
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

On 08/12, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch updates some clock names of Loongson1B,
> and adds AC97, DMA and NAND clock.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

Ah here's the rewrite of the name. We should squash the other
patch into this one so that we don't break bisection.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
