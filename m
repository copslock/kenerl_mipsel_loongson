Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2016 01:05:37 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:59234 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992240AbcHXXFaViR8x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2016 01:05:30 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6064861B5A; Wed, 24 Aug 2016 23:05:27 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04B2761B13;
        Wed, 24 Aug 2016 23:05:26 +0000 (UTC)
Date:   Wed, 24 Aug 2016 16:05:26 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 01/11] clk: microchip: use readl_poll_timeout() in
 pbclk_set_rate().
Message-ID: <20160824230526.GG19826@codeaurora.org>
References: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463461560-9629-1-git-send-email-purna.mandal@microchip.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54745
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

On 05/17, Purna Chandra Mandal wrote:
> pbclk_set_rate() is using readl_poll_timeout_atomic() even
> though spinlock is released. Fix it by replacing with
> readl_poll_timeout().
> 
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
