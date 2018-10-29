Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2018 18:23:57 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:43844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992446AbeJ2RXyvDszP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Oct 2018 18:23:54 +0100
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0532C20657;
        Mon, 29 Oct 2018 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540833828;
        bh=w1YnWt+AnwXv/iS2szCUWKOpLQDHkLKhFgwvClfS/eA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=MJBtKs9GnpyaQ0ZEieMECWGU9IX3goI8lnsgPjeQrGhQwWcbRJJ/6lzfYAP3biVAe
         w5HB88qL6AbOwRLQZLb/47qCAp/9Y1Qe0ULzZ9F/X8leUWeHzUUrI2nwhsoDJUaEV1
         Z+Bi4QsHJu3p4CrLmpwW+8i+0Nak4O8aiBgeuQfI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Yi Wang <wang.yi59@zte.com.cn>, paul.burton@mips.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1540801907-31544-1-git-send-email-wang.yi59@zte.com.cn>
Cc:     mturquette@baylibre.com, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Yi Wang <wang.yi59@zte.com.cn>
References: <1540801907-31544-1-git-send-email-wang.yi59@zte.com.cn>
Message-ID: <154083382731.98144.10932242759017894372@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: boston: fix possible memory leak in clk_boston_setup()
Date:   Mon, 29 Oct 2018 10:23:47 -0700
Return-Path: <sboyd@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sboyd@kernel.org
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

Quoting Yi Wang (2018-10-29 01:31:47)
> 'onecell' is malloced in clk_boston_setup(), but is not freed
> before leaving from the error handling cases.

How did you find this? Visual inspection? Some coccinelle script?

> 
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
> v2: fix syntax issue in comment, thanks to  Sergei.
> 
>  drivers/clk/imgtec/clk-boston.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
> index 15af423..f5d54a6 100644
> --- a/drivers/clk/imgtec/clk-boston.c
> +++ b/drivers/clk/imgtec/clk-boston.c
> @@ -73,27 +73,32 @@ static void __init clk_boston_setup(struct device_node *np)
>         hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
>         if (IS_ERR(hw)) {
>                 pr_err("failed to register input clock: %ld\n", PTR_ERR(hw));
> -               return;
> +               goto error;
>         }
>         onecell->hws[BOSTON_CLK_INPUT] = hw;
>  
>         hw = clk_hw_register_fixed_rate(NULL, "sys", "input", 0, sys_freq);
>         if (IS_ERR(hw)) {
>                 pr_err("failed to register sys clock: %ld\n", PTR_ERR(hw));
> -               return;
> +               goto error;
>         }
>         onecell->hws[BOSTON_CLK_SYS] = hw;
>  
>         hw = clk_hw_register_fixed_rate(NULL, "cpu", "input", 0, cpu_freq);
>         if (IS_ERR(hw)) {
>                 pr_err("failed to register cpu clock: %ld\n", PTR_ERR(hw));
> -               return;
> +               goto error;
>         }
>         onecell->hws[BOSTON_CLK_CPU] = hw;
>  
>         err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, onecell);
>         if (err)
>                 pr_err("failed to add DT provider: %d\n", err);
> +
> +       return;
> +
> +error:
> +       kfree(onecell);

Ok, sure. But then clks are still left registered on failure?
