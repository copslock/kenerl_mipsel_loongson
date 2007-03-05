Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2007 10:21:07 +0000 (GMT)
Received: from smtp.osdl.org ([65.172.181.24]:22172 "EHLO smtp.osdl.org")
	by ftp.linux-mips.org with ESMTP id S20037396AbXCEKVF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Mar 2007 10:21:05 +0000
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l25AHjq8018485
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Mar 2007 02:17:45 -0800
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l25AHjNJ015821;
	Mon, 5 Mar 2007 02:17:45 -0800
Date:	Mon, 5 Mar 2007 02:17:44 -0800
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Marc St-Jean <stjeanma@pmc-sierra.com>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] drivers: PMC MSP71xx TWI driver
Message-Id: <20070305021744.bb34a7ce.akpm@linux-foundation.org>
In-Reply-To: <200702262348.l1QNm6LY015085@pasqua.pmc-sierra.bc.ca>
References: <200702262348.l1QNm6LY015085@pasqua.pmc-sierra.bc.ca>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

Previous comments apply - please convert all this code to kernel coding style.

There are many typecasts of void*, eg:

> +	struct pmcmsp_priv_data *p = (struct pmcmsp_priv_data*)data;

Such casts are unneeded and give an undesirable decrease in typesafety - please
remove them all.

pmcmsp_priv_data.lock should be converted from semaphore to a mutex

Convert u_intN_t -> uN throughout.

Convert all symbol of the form getClockConfig to (in this case)
get_clock_config.

These:

> +/* The default settings */
> +const static struct pmctwi_clockcfg pmctwi_defclockcfg = {
> +	.standard = {
> +		.filter = 0x3,
> +		.clock = 0x1f,
> +	},
> +	.highspeed = {
> +		.filter = 0x3,
> +		.clock = 0x1f,
> +	},
> +};
> +
> +const static struct pmctwi_cfg pmctwi_deftwicfg = {
> +	.arbf		= 0x03,
> +	.nak		= 0x03,
> +	.add10		= 0x00,
> +	.mst_code	= 0x00,
> +	.arb		= 0x01,
> +	.highspeed	= 0x00,
> +};

Should be in a .c file, not a .h file.
