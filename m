Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2016 02:33:27 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:35337 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026634AbcDPAdZBdYBA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Apr 2016 02:33:25 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 775E6603B4;
        Sat, 16 Apr 2016 00:33:23 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6572561506; Sat, 16 Apr 2016 00:33:23 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5FBC60677;
        Sat, 16 Apr 2016 00:33:22 +0000 (UTC)
Date:   Fri, 15 Apr 2016 17:33:22 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH V1 1/7] clk: Loongson1: Update clocks of Loongson1B
Message-ID: <20160416003322.GK26353@codeaurora.org>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
 <1459946095-7637-2-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459946095-7637-2-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53021
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

On 04/06, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> - Rename the file to clk-loongson1.c
> - Add AC97, DMA and NAND clock
> - Update clock names
> - Remove superfluous error messages
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---

Can you please send this with git format-patch -M? I can't easily
tell what has changed.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
