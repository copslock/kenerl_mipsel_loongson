Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2008 18:29:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:27636 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20032286AbYGRR3a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2008 18:29:30 +0100
Received: from localhost (p8181-ipad203funabasi.chiba.ocn.ne.jp [222.146.87.181])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 41D2BB533; Sat, 19 Jul 2008 02:29:26 +0900 (JST)
Date:	Sat, 19 Jul 2008 02:31:16 +0900 (JST)
Message-Id: <20080719.023116.122828931.anemo@mba.ocn.ne.jp>
To:	jason.wessel@windriver.com
Cc:	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] kgdb, mips: add arch support for the kernel's kgdb
 core
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1216400928-29097-3-git-send-email-jason.wessel@windriver.com>
References: <1216400928-29097-1-git-send-email-jason.wessel@windriver.com>
	<1216400928-29097-2-git-send-email-jason.wessel@windriver.com>
	<1216400928-29097-3-git-send-email-jason.wessel@windriver.com>
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
X-archive-position: 19896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 18 Jul 2008 12:08:47 -0500, Jason Wessel <jason.wessel@windriver.com> wrote:
> The new kgdb architecture specific handler registers and unregisters
> dynamically for exceptions depending on when you configure a kgdb I/O
> driver.  Asside from initializing the exceptions earlier in the boot
> process, kgdb should have no impact on a device when it is compiled in
> so long as an I/O module is not configured for use.
...
> @@ -133,5 +138,15 @@ void __init init_IRQ(void)
>  	for (i = 0; i < NR_IRQS; i++)
>  		set_irq_noprobe(i);
>  
> +#ifdef CONFIG_KGDB
> +	if (kgdb_early_setup)
> +		return;
> +#endif
> +
>  	arch_init_irq();
> +
> +#ifdef CONFIG_KGDB
> +	if (!kgdb_early_setup)
> +		kgdb_early_setup = 1;
> +#endif
>  }

The kgdb_ealy_setup check should be at beginning of init_IRQ (before
set_irq_noprobe loop)?

---
Atsushi Nemoto
