Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 02:01:13 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:37283 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010143AbbCaABLGAdpn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 02:01:11 +0200
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id E052313EC93;
        Tue, 31 Mar 2015 00:01:10 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 486)
        id CFBEF13EEFA; Tue, 31 Mar 2015 00:01:10 +0000 (UTC)
Received: from [10.134.64.202] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E2B213EC93;
        Tue, 31 Mar 2015 00:01:10 +0000 (UTC)
Message-ID: <5519E3C5.7040806@codeaurora.org>
Date:   Mon, 30 Mar 2015 17:01:09 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>,
        Mike Turquette <mturquette@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 0/7] clk: Common clock support for IMG Pistachio
References: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
In-Reply-To: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46631
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

On 02/24/15 19:56, Andrew Bresticker wrote:
> This series adds common clock support for the IMG Pistachio SoC.
> Pistachio has two clock controllers (core and peripheral) and two
> general control blocks (peripheral and top) which also contain
> several clock gates.  Like the recently submitted pinctrl driver [1],
> this driver is written so that it's hopefully easy to add support
> for future IMG SoCs.
>
> Tested on an IMG Pistachio BuB.  Based on 4.0-rc1 + my series adding
> Pistachio platform support [2], which introduces the MACH_PISTACHIO
> Kconfig symbol.  A branch with this series and the dependent patches
> is available at [3].  I'd like this to go through the MIPS tree with
> Mike's or Stephen's ACK if possible.
>
>

Minor comment on patch 2, but otherwise

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
