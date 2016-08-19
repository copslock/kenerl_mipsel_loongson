Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Aug 2016 02:04:19 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:42922 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992316AbcHSAEMKVIee (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Aug 2016 02:04:12 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 83E1161CD0; Fri, 19 Aug 2016 00:04:09 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C1F0E61CCD;
        Fri, 19 Aug 2016 00:04:08 +0000 (UTC)
Date:   Thu, 18 Aug 2016 17:04:08 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 3/3] clk: Loongson1: Make use of GENMASK
Message-ID: <20160819000408.GM361@codeaurora.org>
References: <1470999108-9851-1-git-send-email-keguang.zhang@gmail.com>
 <1470999108-9851-4-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1470999108-9851-4-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54667
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
> Make use of GENMASK instead of open coding the equivalent operation,
> and update the PLL formula.

Was the old formula broken? I would expect a bug fix like this to
be first in the series and be backported to any affected stable
trees.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
