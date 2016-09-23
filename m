Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2016 23:53:31 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:53364 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992289AbcIWVxLIR0zu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Sep 2016 23:53:11 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3DD3E61268; Fri, 23 Sep 2016 21:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1474667590;
        bh=9EilN1XSmonliZgQiExR/lsNpei+cPZfegRSsJGMD3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TpSJkM3VCtr0ppB1QhTwNsb/Swx2PLEYM9Lyl6uhGUhwdVKdRjl1A0N1/DZ0YSgri
         cw85r5+XTO5m/v/BYjNXdOY2S5vFlOoWBsIxul2IQzvtfh6ZT5sN3aC0azetlUKEHr
         7Xny64Kt0xgSMoSAI5qNAaVN2KuLVzrAK6IwEhAk=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B81C861258;
        Fri, 23 Sep 2016 21:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1474667589;
        bh=9EilN1XSmonliZgQiExR/lsNpei+cPZfegRSsJGMD3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cceXtRGLzJk5w9cedL4COF8JoxUVOjGpeSab1qAoW+StTHewugW1RBvjmzzo4ymZC
         cjcrGjpRRw0G5LUo76NUKhHF8OxvpdI1dhbjJ9cjKTtUgjL0BKHtqe13FHVaZdV4ZU
         GVW/7GOxNil6JYHDi4xCVpqeuTVIU+OOLwIXCm9A=
DMARC-Filter: OpenDMARC Filter v1.3.1 smtp.codeaurora.org B81C861258
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=sboyd@codeaurora.org
Date:   Fri, 23 Sep 2016 14:53:09 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Yang Ling <gnaygnil@gmail.com>
Cc:     mturquette@baylibre.com, keguang.zhang@gmail.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3] CLK: Add Loongson1C clock support
Message-ID: <20160923215309.GJ21232@codeaurora.org>
References: <20160920155439.GA26095@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160920155439.GA26095@ubuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55259
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

On 09/20, Yang Ling wrote:
> This patch adds clock support to Loongson1C SoC.
> 
> Signed-off-by: Yang Ling <gnaygnil@gmail.com>
> 
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
