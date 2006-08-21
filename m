Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 13:45:07 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:38923 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038551AbWHUMpF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 Aug 2006 13:45:05 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 4801EF6EBD;
	Mon, 21 Aug 2006 14:45:01 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e3rjPVCL+aRK; Mon, 21 Aug 2006 14:45:01 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id EECEEF5993;
	Mon, 21 Aug 2006 14:45:00 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.7/8.13.1) with ESMTP id k7LCj7kA031461;
	Mon, 21 Aug 2006 14:45:08 +0200
Date:	Mon, 21 Aug 2006 13:45:03 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] qemu does not have dcache aliases
In-Reply-To: <20060820.003338.25478178.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl>
References: <20060820.003338.25478178.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.4/1696/Sun Aug 20 22:21:18 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 20 Aug 2006, Atsushi Nemoto wrote:

> @@ -20,7 +20,7 @@ #define cpu_has_ejtag		0
>  
>  #define cpu_has_llsc		1
>  #define cpu_has_vtag_icache	0
> -#define cpu_has_dc_aliases	(PAGE_SIZE < 0x4000)
> +#define cpu_has_dc_aliases	0
>  #define cpu_has_ic_fills_f_dc	0
>  
>  #define cpu_has_dsp		0

 Hmm, it looks like a bug in QEMU -- we should definitely implement them!

  Maciej
