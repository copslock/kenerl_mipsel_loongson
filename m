Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Dec 2006 17:22:03 +0000 (GMT)
Received: from phoenix.bawue.net ([193.7.176.60]:20192 "EHLO mail.bawue.net")
	by ftp.linux-mips.org with ESMTP id S20039585AbWLLRV5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 Dec 2006 17:21:57 +0000
Received: from lagash (intrt.mips-uk.com [194.74.144.130])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bawue.net (Postfix) with ESMTP id A30DEB98CC;
	Tue, 12 Dec 2006 18:20:22 +0100 (CET)
Received: from ths by lagash with local (Exim 4.63)
	(envelope-from <ths@networkno.de>)
	id 1GuBGc-0006Qb-5u; Tue, 12 Dec 2006 17:18:10 +0000
Date:	Tue, 12 Dec 2006 17:18:10 +0000
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] csum_partial and copy in parallel
Message-ID: <20061212171809.GG21819@networkno.de>
References: <20061213.012206.98747230.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213.012206.98747230.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
[snip]
> + * See "Spec" in memcpy.S for details.  Unlike __copy_user, all
> + * function in this file use the standard calling convention.
> + */
> +
> +#define src a0
> +#define dst a1
> +#define len a2
> +#define psum a3
> +#define sum v0
> +#define odd t5
> +#define errptr t6

Does this work for 64 bit? t5/t6/t7 look weird for that.


Thiemo
