Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2007 15:59:10 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.134]:23992 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20022947AbXKFP7B (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Nov 2007 15:59:01 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id E83EB3103BA;
	Tue,  6 Nov 2007 15:59:09 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue,  6 Nov 2007 15:59:09 +0000 (UTC)
Received: from jennifer.localdomain ([192.168.7.224]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 6 Nov 2007 07:58:57 -0800
Message-ID: <47308F36.2070200@avtrex.com>
Date:	Tue, 06 Nov 2007 07:58:46 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: WAIT vs. tickless kernel
References: <20071101.013124.108121433.anemo@mba.ocn.ne.jp>	<20071031163900.GB22871@linux-mips.org>	<20071103.014649.122254137.anemo@mba.ocn.ne.jp> <20071107.003925.74752709.anemo@mba.ocn.ne.jp>
In-Reply-To: <20071107.003925.74752709.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2007 15:58:57.0615 (UTC) FILETIME=[F06C0DF0:01C8208D]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> +LEAF(r4k_wait)
> +	.set	push
> +	.set	noreorder
> +	/* start of rollback region */
> +	LONG_L	t0, TI_FLAGS($28)
> +	nop
> +	andi	t0, _TIF_NEED_RESCHED
> +	bnez	t0, 1f
> +	 nop
> +	nop
> +	nop
> +	.set	mips3
> +	wait
> +	.set	mips0
> +	/* end of rollback region (the region size must be power of two) */
> +	.set	pop
>   

The .set mips0 is redundant as .set pop immediately follows.

David Daney
