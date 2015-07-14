Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 14:22:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46479 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009844AbbGNMWA62gI0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Jul 2015 14:22:00 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.1/8.14.8) with ESMTP id t6ECLxxp030277;
        Tue, 14 Jul 2015 14:21:59 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.1/8.15.1/Submit) id t6ECLsEU030276;
        Tue, 14 Jul 2015 14:21:54 +0200
Date:   Tue, 14 Jul 2015 14:21:54 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Alchemy: Include clk.h
Message-ID: <20150714122154.GA30195@linux-mips.org>
References: <1436819450-16440-1-git-send-email-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1436819450-16440-1-git-send-email-sboyd@codeaurora.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48270
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Jul 13, 2015 at 01:30:50PM -0700, Stephen Boyd wrote:

> This clock provider uses the consumer API, so include clk.h
> explicitly.
> 
> Cc: Manuel Lauss <manuel.lauss@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Linux-MIPS <linux-mips@linux-mips.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Please ack so this can go through the clk tree. We're removing
> the include of clk.h in clk-provider.h so that the consumer
> and provider APIs are clearly split.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
