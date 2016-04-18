Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2016 06:56:47 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:44833 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025160AbcDRE4oybNUv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Apr 2016 06:56:44 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3EC2860314;
        Mon, 18 Apr 2016 04:56:43 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2BBA7608D4; Mon, 18 Apr 2016 04:56:43 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BEA7B60271;
        Mon, 18 Apr 2016 04:56:42 +0000 (UTC)
Date:   Sun, 17 Apr 2016 21:56:41 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH V2 1/7] clk: Loongson1: Update clocks of Loongson1B
Message-ID: <20160418045641.GB15324@codeaurora.org>
References: <1460115779-13141-1-git-send-email-keguang.zhang@gmail.com>
 <CAJhJPsWoN3sZwwUS27XduhV=mGVO5eDwRa-ieanAWwvNByUHHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhJPsWoN3sZwwUS27XduhV=mGVO5eDwRa-ieanAWwvNByUHHA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53040
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

On 04/16, Kelvin Cheung wrote:
> Dear Stephen,
> Could you check this patch?
> Thanks!
> 
> 2016-04-08 19:42 GMT+08:00 Keguang Zhang <keguang.zhang@gmail.com>:
> 
> > From: Kelvin Cheung <keguang.zhang@gmail.com>
> >
> > - Rename the file to clk-loongson1.c
> > - Add AC97, DMA and NAND clock
> > - Update clock names
> > - Remove superfluous error messages
> >
> > Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> >
> > ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
