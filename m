Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 16:22:58 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40714 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133492AbWGGPWt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Jul 2006 16:22:49 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 80FC6F65E4;
	Fri,  7 Jul 2006 17:22:42 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10458-06; Fri,  7 Jul 2006 17:22:42 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 25BDCF65D9;
	Fri,  7 Jul 2006 17:22:42 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.7/8.13.1) with ESMTP id k67FMp59004760;
	Fri, 7 Jul 2006 17:22:51 +0200
Date:	Fri, 7 Jul 2006 16:22:46 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
In-Reply-To: <20060708.000032.88471510.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0607071607520.25285@blysk.ds.pg.gda.pl>
References: <20060708.000032.88471510.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.2/1588/Fri Jul  7 15:54:23 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 8 Jul 2006, Atsushi Nemoto wrote:

> Adding special short path for emulationg RDHWR which is used to
> support TLS.

 You need to take care of VIVT I-caches.

> @@ -369,6 +369,39 @@ #endif
>  	BUILD_HANDLER dsp dsp sti silent		/* #26 */
>  	BUILD_HANDLER reserved reserved sti verbose	/* others */
>  
> +	.align	5
> +	LEAF(handle_ri)
> +	.set	push
> +	.set	noat
> +	mfc0	k0, CP0_CAUSE
> +	MFC0	k1, CP0_EPC
> +	bltz	k0, handle_ri_slow	/* if delay slot */
> +	lw	k0, (k1)

 For a VIVT I-cache this can result in a TLB exception.  TLB handlers are 
not currently prepared for being called at the exception level.

 Also I am fairly sure gas won't fill the branch delay slot above -- a 
trivial rearrangement of code would save a cycle here (and this is a fast 
path, so we do not want wasting time).

> +	li	k1, 0x7c03e83b	/* rdhwr v1,$29 */
> +	bne	k0, k1, handle_ri_slow	/* if not ours */
> +	get_saved_sp	/* k1 := current_thread_info */
> +	MFC0	k0, CP0_EPC
> +	LONG_ADDIU	k0, 4

 I suggest moving MFC0 ahead of get_saved_sp to avoid a stall.  I would 
fit in the branch delay slot nicely.

  Maciej
