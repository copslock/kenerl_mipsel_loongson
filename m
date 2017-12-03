Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Dec 2017 17:27:10 +0100 (CET)
Received: from shards.monkeyblade.net ([184.105.139.130]:54404 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990489AbdLCQ1DJbtLM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Dec 2017 17:27:03 +0100
Received: from localhost (pool-173-77-163-229.nycmny.fios.verizon.net [173.77.163.229])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BD10713E01935;
        Sun,  3 Dec 2017 08:26:54 -0800 (PST)
Date:   Sun, 03 Dec 2017 11:26:53 -0500 (EST)
Message-Id: <20171203.112653.224466614263640515.davem@davemloft.net>
To:     david.daney@cavium.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        james.hogan@mips.com, netdev@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        steven.hill@cavium.com, devicetree@vger.kernel.org, andrew@lunn.ch,
        f.fainelli@gmail.com, pombredanne@nexb.com, cmunoz@cavium.com
Subject: Re: [PATCH v5 net-next,mips 6/7] netdev: octeon-ethernet: Add
 Cavium Octeon III support.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20171201231807.25266-7-david.daney@cavium.com>
References: <20171201231807.25266-1-david.daney@cavium.com>
        <20171201231807.25266-7-david.daney@cavium.com>
X-Mailer: Mew version 6.7 on Emacs 25.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 03 Dec 2017 08:26:55 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: David Daney <david.daney@cavium.com>
Date: Fri,  1 Dec 2017 15:18:06 -0800

> +static char *mix_port;
> +module_param(mix_port, charp, 0444);
> +MODULE_PARM_DESC(mix_port, "Specifies which ports connect to MIX interfaces.");
> +
> +static char *pki_port;
> +module_param(pki_port, charp, 0444);
> +MODULE_PARM_DESC(pki_port, "Specifies which ports connect to the PKI.");

Please no module parameters.

Please instead find a way to determine or configure these elements
at run time with generic configuration interfaces.
> +
> +static int bgx_probe(struct platform_device *pdev)
> +{
> +	struct mac_platform_data platform_data;
> +	const __be32 *reg;
> +	u32 port;
> +	u64 addr;
> +	struct device_node *child;
> +	struct platform_device *new_dev;
> +	struct platform_device *pki_dev;
> +	int numa_node, interface;
> +	int i;
> +	int r = 0;
> +	char id[64];
> +	u64 data;

Please use reverse-christmas-tree ordering (longest to shortest line) for
local variable declarations.

Please fix this in your entire submission.

> +static int bgx_mix_init_from_fdt(void)
> +{
> +	struct device_node	*node;
> +	struct device_node	*parent = NULL;
> +	int			mix = 0;
> +

Please do not use tabs like this when declaring local variables.
Much worse, some functions use this style whereas others do not,
be consistent otherwise your code is very hard to read.

Please fix this for your entire submission not just this specific
case I am pointing out.

Thanks.
