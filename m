Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2007 14:47:04 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:60612 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038524AbXA3Oq7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 Jan 2007 14:46:59 +0000
Received: from localhost (p6132-ipad32funabasi.chiba.ocn.ne.jp [221.189.138.132])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BFDD17D5A; Tue, 30 Jan 2007 23:45:37 +0900 (JST)
Date:	Tue, 30 Jan 2007 23:45:37 +0900 (JST)
Message-Id: <20070130.234537.126574565.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	dan@debian.org, vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: RFC: Sentosa boot fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0701291833480.26916@blysk.ds.pg.gda.pl>
References: <cda58cb80701290806p5d68ba5ck5e3e3b2b3490126f@mail.gmail.com>
	<20070129161450.GA3384@nevyn.them.org>
	<Pine.LNX.4.64N.0701291833480.26916@blysk.ds.pg.gda.pl>
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
X-archive-position: 13858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 29 Jan 2007 18:47:12 +0000 (GMT), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  I have BUILD_ELF64 enabled for my SWARM configuration and I do not plan 
> to change it.  If there is a bug in the definition of __pa_page_offset() 
> for such a setup it should be fixed indeed.

Though I do not object to remove "&& !defined(CONFIG_BUILD_ELF64)"
from __pa_page_offset(), are there any point of CONFIG_BUILD_ELF64=y
if your load address was CKSEG0?

---
Atsushi Nemoto
