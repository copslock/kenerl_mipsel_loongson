Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2015 21:48:50 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:54463 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008255AbbFDTss3x5sJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2015 21:48:48 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1E1BE141828;
        Thu,  4 Jun 2015 19:48:46 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id 0CEF5141831; Thu,  4 Jun 2015 19:48:46 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 960DC141828;
        Thu,  4 Jun 2015 19:48:45 +0000 (UTC)
Date:   Thu, 4 Jun 2015 12:48:44 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Mike Turquette <mturquette@linaro.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, cernekee@chromium.org,
        Govindraj.Raja@imgtec.com, Damien.Horsley@imgtec.com
Subject: Re: [PATCH 3/3] clk: pistachio: Add sanity checks on PLL
 configuration
Message-ID: <20150604194844.GH676@codeaurora.org>
References: <1432677669-29581-1-git-send-email-ezequiel.garcia@imgtec.com>
 <1432677669-29581-4-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1432677669-29581-4-git-send-email-ezequiel.garcia@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47867
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

On 05/26, Ezequiel Garcia wrote:
> From: Kevin Cernekee <cernekee@chromium.org>
> 
> When setting the PLL rates, check that:
> 
>  - VCO is within range
>  - PFD is within range
>  - PLL is disabled when postdiv is changed
>  - postdiv2 <= postdiv1
> 
> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Kevin Cernekee <cernekee@chromium.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
