Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 May 2007 17:03:31 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:49143 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022578AbXEEQD0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 May 2007 17:03:26 +0100
Received: from localhost (p1094-ipad26funabasi.chiba.ocn.ne.jp [220.104.87.94])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CA0BFA104; Sun,  6 May 2007 01:03:05 +0900 (JST)
Date:	Sun, 06 May 2007 01:03:13 +0900 (JST)
Message-Id: <20070506.010313.41199101.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] time: replace board_time_init() by plat_clk_setup()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <11782930063123-git-send-email-fbuihuu@gmail.com>
References: <1178293006633-git-send-email-fbuihuu@gmail.com>
	<11782930063123-git-send-email-fbuihuu@gmail.com>
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
X-archive-position: 14966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri,  4 May 2007 17:36:45 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> This patch introduces plat_clk_setup() which is a hook that platforms
> can implement to setup clock and mips_hpt_frequency.
> 
> This was done by board_time_init function pointer previously.
> 
> There are 3 reasons why we should prefer plat_clk_setup() over
> board_time_init:
> 
>     1/ There's no need for platforms to initialize a function
>     pointer anymore.
> 
>     2/ board_time_init was previously initialized in plat_mem_setup()
>     which is normally used to setup platform's *memories*.
> 
>     3/ plat_clk_setup() is called earlier in boot process. Therefore
>     others subsystems can get the time during their initialisation,
>     timekeeping subsystem is an example.

Though providing plat_clk_setup() for timekeeping code might be a good
idea, I think your patch break at least those two platforms:

MOMENCO_JAGUAR_ATX: momenco_time_init() assumes tlb_init() was already
called.  (wire_stupidity_into_tlb() calls local_flush_tlb_all())

MOMENCO_OCELOT_G: gt64240_time_init() assumes IRQ subsystem are
already initialized.

How about keeping board_time_init pointer as is and adding
plat_clk_setup only for simple platforms?

---
Atsushi Nemoto
