Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 May 2008 14:38:46 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:16368 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20025744AbYEDNio (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 May 2008 14:38:44 +0100
Received: from localhost (p4020-ipad208funabasi.chiba.ocn.ne.jp [60.43.105.20])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 61F80A846; Sun,  4 May 2008 22:38:37 +0900 (JST)
Date:	Sun, 04 May 2008 22:39:44 +0900 (JST)
Message-Id: <20080504.223944.41198532.anemo@mba.ocn.ne.jp>
To:	tsbogend@alpha.franken.de
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Breakage in arch/mips/kernel/traps.c for 64bit
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080503224849.GA2314@alpha.franken.de>
References: <20080502101113.GA24408@linux-mips.org>
	<20080504.011647.93019265.anemo@mba.ocn.ne.jp>
	<20080503224849.GA2314@alpha.franken.de>
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
X-archive-position: 19095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 4 May 2008 00:48:49 +0200, tsbogend@alpha.franken.de (Thomas Bogendoerfer) wrote:
> hmm, why not simply use __get_user() when accessing the stack content ?
> show_stacktrace() already does it for stack dumping ? This would
> avoid any work for whatever sick stack mappings. Below is a patch,
> which does this.

I like this patch.  One minor request:

> +	unsigned long __user *sp = (unsigned long __user *)(reg29 & ~3);
...
> +	while (!kstack_end(sp)) {
> +		if (__get_user(addr, sp++)) {

This will leads a sparse warning since an argument for kstack_end is 'void *'.

	while (!kstack_end((void *)(unsigned long)sp)) {

will make this part sparse-free, though it seems a bit ugly.

---
Atsushi Nemoto
