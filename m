Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 01:34:45 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:60012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992036AbdFSXeihzQzQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 01:34:38 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A6BCF6080B; Mon, 19 Jun 2017 23:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497915276;
        bh=SUb1+sBqwRFD8iGfJsRQXDKk1wEpTd1KJLdiqlxwGzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPFwWoljkO4oraAVSXOpG/2mOkDwIaC0INv2gZ3viZ6gFHiqiC6HnxYl0mNW9JqBj
         guswOyf8GvaP1Kv12JH2lLj4gB4xwbkR/pysA3lZ18bNvOYTmWQWKKVQjz2NuCo61P
         S3QjrUR+F9mNRSq/xPfpdtOrZ9Sp5CDfMAPx+xrA=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6438260870;
        Mon, 19 Jun 2017 23:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1497915275;
        bh=SUb1+sBqwRFD8iGfJsRQXDKk1wEpTd1KJLdiqlxwGzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dGhwkjAs5/oBUSqRAEEHfccbueKyX0A2oaim5KqPL/ftofsaTb1iDT3wPzYyvF4uI
         lKo8rHJ+2/pyWQGNVWe8457vVsYpqBMOPJ7E3SSuAqnYAaRPN7dTiEG/5OLME+Ai3g
         XtuO08E7H7f8ud942nYPJAXWR388YpsN6JZuddYo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6438260870
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Mon, 19 Jun 2017 16:34:34 -0700
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
Subject: Re: [PATCH v7 7/8] clk: Loongson: Add Loongson-1A clock support
Message-ID: <20170619233434.GQ20170@codeaurora.org>
References: <1497581573-17258-1-git-send-email-zhoubb@lemote.com>
 <1497581573-17258-8-git-send-email-zhoubb@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497581573-17258-8-git-send-email-zhoubb@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58655
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

On 06/16, Binbin Zhou wrote:
> diff --git a/drivers/clk/loongson1/clk-loongson1a.c b/drivers/clk/loongson1/clk-loongson1a.c
> new file mode 100644
> index 0000000..263a82c
> --- /dev/null
> +++ b/drivers/clk/loongson1/clk-loongson1a.c
> @@ -0,0 +1,75 @@
> +/*
> + * Copyright (c) 2012-2016 Binbin Zhou <zhoubb@lemote.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +
> +#include <loongson1.h>
> +#include "clk.h"
> +
> +#define OSC		(33 * 1000000)
> +#define DIV_APB		2
> +
> +static DEFINE_SPINLOCK(_lock);

I know the other loongson1*.c files also call it "_lock", but
that's not a very good name for something that may show up in
lockdep debugging error messages. How about something a bit more
descriptive, loongson1x_clk_lock?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
