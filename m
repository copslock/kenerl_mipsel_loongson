Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Aug 2009 00:35:48 +0200 (CEST)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51136 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493553AbZHJWfl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 11 Aug 2009 00:35:41 +0200
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7AMZ3xj024297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Aug 2009 15:35:04 -0700
Received: from akpm.mtv.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id n7AMZ39r024547;
	Mon, 10 Aug 2009 15:35:03 -0700
Date:	Mon, 10 Aug 2009 15:35:03 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	ralf@linux-mips.org, torvalds@linux-foundation.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	ddaney@caviumnetworks.com
Subject: Re: [PATCH 1/2] MIPS: Octeon:  Add hardware RNG platform device.
Message-Id: <20090810153503.07dee9c4.akpm@linux-foundation.org>
In-Reply-To: <1249929025-29625-1-git-send-email-ddaney@caviumnetworks.com>
References: <4A806529.3060609@caviumnetworks.com>
	<1249929025-29625-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Mon, 10 Aug 2009 11:30:24 -0700
David Daney <ddaney@caviumnetworks.com> wrote:

> Add a platform device for the Octeon Random Number Generator (RNG).
> 
> ...
>
>  device_initcall(octeon_cf_device_init);
> +
> +/* Octeon Random Number Generator.  */
> +static int __init octeon_rng_device_init(void)
> +{
> +	struct platform_device *pd;
> +	struct resource rng_resources[2];
> +	unsigned int res_count;
> +	int ret = 0;
> +
> +	memset(rng_resources, 0, sizeof(rng_resources));
> +	res_count = 0;
> +	rng_resources[res_count].flags = IORESOURCE_MEM;
> +	rng_resources[res_count].start = XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS);
> +	rng_resources[res_count].end = rng_resources[res_count].start + 0xf;
> +	res_count++;
> +
> +	rng_resources[res_count].flags = IORESOURCE_MEM;
> +	rng_resources[res_count].start = cvmx_build_io_address(8, 0);
> +	rng_resources[res_count].end = rng_resources[res_count].start + 0x7;
> +	res_count++;

You could do

	strut resource rng_resources[2] = {
		{
			.flags = IORESOURCE_MEM,
			.start = XKPHYS_TO_PHYS(CVMX_RNM_CTL_STATUS),
	{etc}

here. 

> +	pd = platform_device_alloc("octeon_rng", -1);
> +	if (!pd) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = platform_device_add_resources(pd, rng_resources, res_count);

use ARRAY_SIZE() here.

> +	if (ret)
> +		goto fail;
> +
> +	ret = platform_device_add(pd);
> +	if (ret)
> +		goto fail;
> +
> +	return ret;
> +fail:
> +	platform_device_put(pd);
> +
> +out:
> +	return ret;
> +}

Or not bother ;)  It doesn't make any difference.

> --- /dev/null
> +++ b/arch/mips/include/asm/octeon/cvmx-rnm-defs.h
>
> ...
>
> +	uint64_t u64;
>
> ...
>

This file should include types.h (at least).
