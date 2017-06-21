Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2017 19:49:29 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:38472 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993870AbdFURtSv2CFs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jun 2017 19:49:18 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 12FFF60A4F; Wed, 21 Jun 2017 17:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1498067357;
        bh=O4RVu9AKpjlW0Cj9JoFKb6Y5biN7GJ6kSVGKxd5wvJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CL9zdy3/C3KDoq4cchuQgbwoKCFwW5mzHV+cKy1iDP+UrDvmZqkMMxoVH17AJ3SQl
         uVp32EHDac/CcuzDD3jrSKcH1FnKAKobeeF0npGP1YByiAi2OWDnQwn0FUEFjaFiNC
         dOjBU/kFckId3DhBy7XFiqTxmSc9dOuV5pA0j4TY=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1913260854;
        Wed, 21 Jun 2017 17:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1498067355;
        bh=O4RVu9AKpjlW0Cj9JoFKb6Y5biN7GJ6kSVGKxd5wvJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aal1/BcDm1RGw5XhXZqWTXdzrCSVYM7KQov2GRYSN9DJkEX8ClELLfEFUO0wfV/E0
         zkGKmONJ/wjmWCBv2ptWrBt/kwcZ+4OVDgavij1Dbbtmv/Qs3uRWF9aVAyPbqBeXoE
         5H7ocgQFc411aPVKc/dmZfqTDPhJoCl3wz4nfuf8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1913260854
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Wed, 21 Jun 2017 10:49:14 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Binbin Zhou <zhoubb@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        =?utf-8?B?6LCi6Ie06YKm?= <Yeking@Red54.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        HuaCai Chen <chenhc@lemote.com>
Subject: Re: [PATCH v8 8/9] clk: Loongson: Add Loongson-1A clock support
Message-ID: <20170621174914.GE4493@codeaurora.org>
References: <1497949027-10988-1-git-send-email-zhoubb@lemote.com>
 <1497949027-10988-9-git-send-email-zhoubb@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497949027-10988-9-git-send-email-zhoubb@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58736
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

On 06/20, Binbin Zhou wrote:
> This patch adds clock support to Loongson-1A SoC.
> 
> Unfortunately, The Loongson-1A's PLL register is written only,
> so we just set it with a fixed value.
> 
> Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
> Signed-off-by: HuaCai Chen <chenhc@lemote.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-clk@vger.kernel.org
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
