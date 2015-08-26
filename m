Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Aug 2015 20:36:38 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:56493 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010557AbbHZSgfOGXtz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Aug 2015 20:36:35 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6BB13141314;
        Wed, 26 Aug 2015 18:36:33 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 5011C141316; Wed, 26 Aug 2015 18:36:33 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8205D141314;
        Wed, 26 Aug 2015 18:36:32 +0000 (UTC)
Date:   Wed, 26 Aug 2015 11:36:31 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Govindraj Raja <Govindraj.Raja@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Zdenko Pulitika <zdenko.pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v6 1/4] clk: pistachio: Fix 32bit integer overflows
Message-ID: <20150826183631.GO19120@codeaurora.org>
References: <1440605500-13274-1-git-send-email-Govindraj.Raja@imgtec.com>
 <1440605500-13274-2-git-send-email-Govindraj.Raja@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440605500-13274-2-git-send-email-Govindraj.Raja@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49032
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

On 08/26, Govindraj Raja wrote:
> From: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
> 
> This commit fixes 32bit integer overflows throughout the pll driver
> (i.e. wherever the result of integer multiplication may exceed the
> range of u32).
> 
> One of the functions affected by this problem is .recalc_rate. It
> returns incorrect rate for some pll settings (not for all though)
> which in turn results in the incorrect rate setup of pll's child
> clocks.
> 
> Fixes: 43049b0c83f17("CLK: Pistachio: Add PLL driver")
> Cc: <stable@vger.kernel.org> # 4.1
> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Zdenko Pulitika <zdenko.pulitika@imgtec.com>
> Signed-off-by: Govindraj Raja <govindraj.raja@imgtec.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
