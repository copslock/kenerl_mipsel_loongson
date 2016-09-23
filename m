Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2016 23:53:08 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:53290 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992240AbcIWVxBJO3Hu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Sep 2016 23:53:01 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 11AAC61258; Fri, 23 Sep 2016 21:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1474667579;
        bh=PidjYIh1R41qEK6UBetSIxu58uVSWctFjkyOdoCLXZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dy1pI7C69wt39hAoKwhZbNS8PT1vxK3L/N7b452uP2KtLhNRhsxcp6OAZnWAHWM+t
         nw3IQSJ4+wegnYCVCNsDX9/scxhhgNq1kZLEGNou+qrSBdQgCm2PZlsJWlV/kzY4sg
         xaLnOD3wvr6iu+6PTmOb4ImKFyr9YD+j/pkI5dhQ=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8223561258;
        Fri, 23 Sep 2016 21:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1474667578;
        bh=PidjYIh1R41qEK6UBetSIxu58uVSWctFjkyOdoCLXZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FPkxGe++cJN+O9umOKVVvE5/MmAtSApdX58LzMzSK4RETRpohD2755PuxURQ4yGUS
         L07Xp378U4lilvM2rgf4JmeYvwXcYq6rSqYiYjLj8n/fBUYIWene9eAz8WiRR0UMuY
         KQHiD4eheLo+TH+gxk4tuibYEpisAMVus4GT8dnE=
DMARC-Filter: OpenDMARC Filter v1.3.1 smtp.codeaurora.org 8223561258
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=sboyd@codeaurora.org
Date:   Fri, 23 Sep 2016 14:52:57 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH V1 1/3] clk: Loongson1: Refactor Loongson1 clock
Message-ID: <20160923215257.GG21232@codeaurora.org>
References: <1474259936-9657-1-git-send-email-keguang.zhang@gmail.com>
 <1474259936-9657-2-git-send-email-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474259936-9657-2-git-send-email-keguang.zhang@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55258
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

On 09/19, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> Factor out the common functions into loongson1/clk.c
> to support both Loongson1B and Loongson1C. And, put
> the rest into loongson1/clk-loongson1b.c.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
