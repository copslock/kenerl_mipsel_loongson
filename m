Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2014 22:45:37 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.11.231]:36382 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010999AbaJIUpfe9-4s (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Oct 2014 22:45:35 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C1C2913F984;
        Thu,  9 Oct 2014 20:45:29 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id B3FA013F98A; Thu,  9 Oct 2014 20:45:29 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A83D13F984;
        Thu,  9 Oct 2014 20:45:29 +0000 (UTC)
Date:   Thu, 9 Oct 2014 13:45:28 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Mike Turquette <mturquette@linaro.org>,
        Javier Martinez Canillas <javier.martinez@collabora.co.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/8] MIPS: Alchemy: Remove direct access to
 prepare_count field of struct clk
Message-ID: <20141009204528.GF5493@codeaurora.org>
References: <1412866903-6970-1-git-send-email-tomeu.vizoso@collabora.com>
 <1412866903-6970-2-git-send-email-tomeu.vizoso@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1412866903-6970-2-git-send-email-tomeu.vizoso@collabora.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43168
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

On 10/09, Tomeu Vizoso wrote:
> Replacing it with a call to __clk_is_prepared(), which isn't entirely
> equivalent but in practice shouldn't matter.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
