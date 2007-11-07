Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2007 14:21:53 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:65254 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20032180AbXKGOVn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2007 14:21:43 +0000
Received: from localhost (p5186-ipad203funabasi.chiba.ocn.ne.jp [222.146.84.186])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 591B99DDE; Wed,  7 Nov 2007 23:21:39 +0900 (JST)
Date:	Wed, 07 Nov 2007 23:23:43 +0900 (JST)
Message-Id: <20071107.232343.104640143.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: WAIT vs. tickless kernel
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071107.003925.74752709.anemo@mba.ocn.ne.jp>
References: <20071031163900.GB22871@linux-mips.org>
	<20071103.014649.122254137.anemo@mba.ocn.ne.jp>
	<20071107.003925.74752709.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 07 Nov 2007 00:39:25 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> +	MFC0	k0, CP0_EPC
> +	ori	k0, 0x1f	/* 32 byte rollback region */
> +	xori	k0, 0x1f
> +	PTR_LA	k1, r4k_wait

Well, this part should be like this, for better pipelining.

	MFC0	k0, CP0_EPC
	PTR_LA	k1, r4k_wait
	ori	k0, 0x1f	/* 32 byte rollback region */
	xori	k0, 0x1f

> +	bne	k0, k1, 9f
> +	MTC0	k0, CP0_EPC
> +9:

And if we could assume branch-likely, this can be:

	.set	noreorder
	beql	k0, k1, 9f
	 MTC0	k0, CP0_EPC
9:

But not sure if it really have points.

>  	.align  5
> +BUILD_ROLLBACK_PROLOGUE handle_int
>  NESTED(handle_int, PT_SIZE, sp)

And one more question: should we put one more ".align 5" just befor
handle_int for CPUs do not need the rollback?

---
Atsushi Nemoto
