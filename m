Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 23:41:19 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:47470 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010804AbcBYWlOWEbdh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 23:41:14 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B8C366021A;
        Thu, 25 Feb 2016 22:41:12 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A884560896; Thu, 25 Feb 2016 22:41:12 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5E031600EC;
        Thu, 25 Feb 2016 22:41:12 +0000 (UTC)
Date:   Thu, 25 Feb 2016 14:41:11 -0800
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Joshua Henderson <joshua.henderson@microchip.com>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] clk: Get rid of HAVE_MACH_CLKDEV
Message-ID: <20160225224111.GO4847@codeaurora.org>
References: <1453933020-8577-1-git-send-email-sboyd@codeaurora.org>
 <56CF6461.9040308@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56CF6461.9040308@microchip.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52273
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

On 02/25, Joshua Henderson wrote:
> On 01/27/2016 03:17 PM, Stephen Boyd wrote:
> > This config was used for the ARM port so that it could use a
> > machine specific clkdev.h include, but those are all gone now.
> > The MIPS architecture is the last user, and from what I can tell
> > it doesn't actually use it anyway, so let's remove the config all
> > together.
> > 
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: <linux-mips@linux-mips.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Reviewed-by: Joshua Henderson <joshua.henderson@microchip.com>
> 

Thanks. Merged to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
