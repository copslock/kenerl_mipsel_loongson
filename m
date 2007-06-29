Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jun 2007 02:33:40 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:50446 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S20022817AbXF2Bdf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 Jun 2007 02:33:35 +0100
Received: by mo.po.2iij.net (mo30) id l5T1XW29029293; Fri, 29 Jun 2007 10:33:32 +0900 (JST)
Received: from localhost.localdomain (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id l5T1XU8i017622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Jun 2007 10:33:30 +0900
Date:	Fri, 29 Jun 2007 10:33:30 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	Brian_Oostenbrink@pmc-sierra.com, linux-mips@linux-mips.org,
	Rod_Sillett@pmc-sierra.com
Subject: Re: [PATCH 1/12] mips: PMC MSP71xx core platform
Message-Id: <20070629103330.035cb021.yoichi_yuasa@tripeaks.co.jp>
In-Reply-To: <200706290105.l5T15UJC032272@pasqua.pmc-sierra.bc.ca>
References: <200706290105.l5T15UJC032272@pasqua.pmc-sierra.bc.ca>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Thu, 28 Jun 2007 19:05:30 -0600
Marc St-Jean <stjeanma@pmc-sierra.com> wrote:

> diff --git a/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c b/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
> new file mode 100644
> index 0000000..6fa8572
> --- /dev/null
> +++ b/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
> @@ -0,0 +1,179 @@
> +/*
> + * Sets up interrupt handlers for various hardware switches which are
> + * connected to interrupt lines.
> + *
> + * Copyright 2005-2207 PMC-Sierra, Inc.
                     ^^^^


> +
> +#ifdef CONFIG_PMC_MSP7120_GW

You have already set "obj-$(CONFIG_PMC_MSP7120_GW) += msp_hwbutton.o" in Makefile.
It is not necessary.

> +
> +static int __init msp_hwbutton_setup(void)
> +{
> +#ifdef CONFIG_PMC_MSP7120_GW

same.

Yoichi
