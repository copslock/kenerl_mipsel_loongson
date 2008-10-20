Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2008 16:08:44 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:31946 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S21922181AbYJTPIl (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2008 16:08:41 +0100
Received: from localhost (p5246-ipad210funabasi.chiba.ocn.ne.jp [58.88.124.246])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A744DA93B; Tue, 21 Oct 2008 00:08:37 +0900 (JST)
Date:	Tue, 21 Oct 2008 00:08:50 +0900 (JST)
Message-Id: <20081021.000850.08318458.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
	bzolnier@gmail.com, ralf@linux-mips.org
Subject: Re: [PATCH] TXx9: Add TX4938 ATA support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <48FC9878.4030306@ru.mvista.com>
References: <48FB7D9E.4030803@ru.mvista.com>
	<20081020.231450.51866269.anemo@mba.ocn.ne.jp>
	<48FC9878.4030306@ru.mvista.com>
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
X-archive-position: 20820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 20 Oct 2008 18:40:56 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > Do you mean I should use IDE_HFLAG_NO_SET_MODE instead of just
> > returning from set_pio_mode?
> 
>     No, that's for the smart RAID controllers that program the transfer modes 
> themselves. In your case, hwif->port_ops->set_pio_mode() must be NULL -- if 
> you're not going to allow the mode programming, that is.

I see.  Thanks.

---
Atsushi Nemoto
