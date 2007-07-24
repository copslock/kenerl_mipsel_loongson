Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2007 15:55:31 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:12022 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023048AbXGXOz3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Jul 2007 15:55:29 +0100
Received: from localhost (p1202-ipad203funabasi.chiba.ocn.ne.jp [222.146.80.202])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CA51EB6CE; Tue, 24 Jul 2007 23:54:06 +0900 (JST)
Date:	Tue, 24 Jul 2007 23:55:08 +0900 (JST)
Message-Id: <20070724.235508.59464186.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: Re: [PATCH] Fix marge error due to conflict in
 arch/mips/kernel/head.S
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070723.000734.08075709.anemo@mba.ocn.ne.jp>
References: <20070723.000734.08075709.anemo@mba.ocn.ne.jp>
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
X-archive-position: 15882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 23 Jul 2007 00:07:34 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> __INIT directive just before kernel_entry was dropped for most
> (i.e. BOOT_RAW=n) platforms by merge accident (perhaps).  This patch
> fixes it and get rid of this warning:
> 
> WARNING: vmlinux.o(.text+0x478): Section mismatch: reference to .init.text:start_kernel (between '_stext' and 'run_init_process')
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Also, I suppose this fix is needed for MIPSsim and PMC MSP.

---
Atsushi Nemoto
