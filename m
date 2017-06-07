Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jun 2017 22:59:56 +0200 (CEST)
Received: from smtp.codeaurora.org ([198.145.29.96]:35544 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992145AbdFGU7qqdzac (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jun 2017 22:59:46 +0200
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1029D60DAA; Wed,  7 Jun 2017 20:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1496869185;
        bh=3wyZFrZb0rh4Qdr0QdXQf9FDD3nXhg/T+HVyuWy577c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8bYvOkBZXEN2lTkv1As+RtbXvZPkF8Zkon5b9yTPZBFAcVfXp5AwiMbtrae7VPOe
         o4vCKTSYYs+gLIvb1v+Ek6r00Octg2a1kezRvbblCoGbWAL5t/n2EDBjMi/IUGi4Rd
         +pyyKniOSEXFt9lhC7Pnh8QLLfVbiDGLSdj48z98=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sboyd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D3BB60D71;
        Wed,  7 Jun 2017 20:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1496869184;
        bh=3wyZFrZb0rh4Qdr0QdXQf9FDD3nXhg/T+HVyuWy577c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJUqyzHOQSRaxPNcnhWttsBggj8v3EFcZB5QMlJ5XXjhbYkE5V45PdewGM4TuLznE
         CcDGmsnhXbLOo2RypkkBDAz4xVWQ9pGSmJq6d2ICe061f+xWJEy7YDOODQxEazchYM
         E50gKNzufaT8ucl4xRnFTLthbkpYgb7gxySdnIx0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D3BB60D71
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sboyd@codeaurora.org
Date:   Wed, 7 Jun 2017 13:59:43 -0700
From:   Stephen Boyd <sboyd@codeaurora.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 04/15] clk: Add Ingenic jz4770 CGU driver
Message-ID: <20170607205943.GO20170@codeaurora.org>
References: <20170607200439.24450-1-paul@crapouillou.net>
 <20170607200439.24450-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170607200439.24450-5-paul@crapouillou.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <sboyd@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58289
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

On 06/07, Paul Cercueil wrote:
> Add support for the clocks provided by the CGU in the Ingenic JZ4770
> SoC.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>

Signed-off chain looks odd. Sender should be last in the chain
and first is typically author.

WARNING: struct clk_ops should normally be const
#118: FILE: drivers/clk/ingenic/jz4770-cgu.c:84:
+struct clk_ops jz4770_uhc_phy_ops = {

WARNING: struct clk_ops should normally be const
#149: FILE: drivers/clk/ingenic/jz4770-cgu.c:115:
+struct clk_ops jz4770_otg_phy_ops = {

drivers/clk/ingenic/jz4770-cgu.c:84:16:
warning: symbol 'jz4770_uhc_phy_ops' was not declared. Should it
be static?
drivers/clk/ingenic/jz4770-cgu.c:115:16:
warning: symbol 'jz4770_otg_phy_ops' was not declared. Should it
be static?

> diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
> new file mode 100644
> index 000000000000..993db42df5fc
> --- /dev/null
> +++ b/drivers/clk/ingenic/jz4770-cgu.c
> @@ -0,0 +1,485 @@
> +/*
> + * JZ4770 SoC CGU driver
> + *
> + * Copyright 2017, Paul Cercueil <paul@crapouillou.net>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 or later
> + * as published by the Free Software Foundation.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/syscore_ops.h>
> +#include <dt-bindings/clock/jz4770-cgu.h>
> +#include "cgu.h"
> +
[..]
> +
> +static struct syscore_ops jz4770_cgu_pm_ops = {
> +	.suspend = jz4770_cgu_pm_suspend,
> +	.resume = jz4770_cgu_pm_resume,
> +};
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static void __init jz4770_cgu_init(struct device_node *np)
> +{
> +	int retval;
> +
> +	cgu = ingenic_cgu_new(jz4770_cgu_clocks,
> +			      ARRAY_SIZE(jz4770_cgu_clocks), np);
> +	if (!cgu)
> +		pr_err("%s: failed to initialise CGU\n", __func__);
> +
> +	retval = ingenic_cgu_register_clocks(cgu);
> +	if (retval)
> +		pr_err("%s: failed to register CGU Clocks\n", __func__);
> +
> +#ifdef CONFIG_PM_SLEEP

if (IS_ENABLED(CONFIG_PM_SLEEP) instead?

> +	register_syscore_ops(&jz4770_cgu_pm_ops);
> +#endif
> +}
> +CLK_OF_DECLARE(jz4770_cgu, "ingenic,jz4770-cgu", jz4770_cgu_init);

Any reason this can't be a platform driver? Please add a comment
above CLK_OF_DECLARE describing what is preventing that.

> diff --git a/include/dt-bindings/clock/jz4770-cgu.h b/include/dt-bindings/clock/jz4770-cgu.h
> new file mode 100644
> index 000000000000..54b8b2ae4a73
> --- /dev/null
> +++ b/include/dt-bindings/clock/jz4770-cgu.h

Can you split this file off into a different patch? That way clk
tree can apply clk patches on top of a stable branch where this
file lives by itself.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
