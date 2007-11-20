Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 13:44:15 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:50655 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20041004AbXKTNoH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2007 13:44:07 +0000
Received: from localhost (p2098-ipad211funabasi.chiba.ocn.ne.jp [58.91.158.98])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C80E399BF; Tue, 20 Nov 2007 22:42:45 +0900 (JST)
Date:	Tue, 20 Nov 2007 22:44:57 +0900 (JST)
Message-Id: <20071120.224457.108739276.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	zzh.hust@gmail.com, linux-mips@linux-mips.org
Subject: Re: how to use memory before kernel load address?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20071120130451.GI11996@networkno.de>
References: <50c9a2250711191706g40744ab2w2027124c4bc8dbbb@mail.gmail.com>
	<20071120130451.GI11996@networkno.de>
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
X-archive-position: 17550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 20 Nov 2007 13:04:51 +0000, Thiemo Seufer <ths@networkno.de> wrote:
> >          i have try to pass param as mem=1M@1M mem=16M@16M  to the kernel,
> > it seems only take the 0x8000000 ~ kernel_end as reserved.
> >          is there any other options to set the memory useable? ( my kernel
> > version is 2.6.14)
> >          thanks for any hints
> 
> AFAIR the kernel assumes to occupy the lowest addresses of the usable RAM.

You can use prom_free_prom_memory() to give some low pages back to kernel.

---
Atsushi Nemoto
