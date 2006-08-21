Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 16:20:31 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:40424 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037552AbWHUPUa (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2006 16:20:30 +0100
Received: from localhost (p7064-ipad03funabasi.chiba.ocn.ne.jp [219.160.87.64])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A578196B8; Tue, 22 Aug 2006 00:20:25 +0900 (JST)
Date:	Tue, 22 Aug 2006 00:22:11 +0900 (JST)
Message-Id: <20060822.002211.123673881.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] qemu does not have dcache aliases
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060821144605.GA19032@linux-mips.org>
References: <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl>
	<20060821.225910.108307053.anemo@mba.ocn.ne.jp>
	<20060821144605.GA19032@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 21 Aug 2006 15:46:06 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> The CPU emulated by Qemu might change eventually so I think this is
> preferable.

Then we can just remove mach-qemu/cpu-features-overrides.h to get
maximum availability.  Would I create a patch?

---
Atsushi Nemoto
