Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Nov 2006 02:51:58 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:48575 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039081AbWKBCv4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Nov 2006 02:51:56 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 2 Nov 2006 11:51:55 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id B4B5441A10;
	Thu,  2 Nov 2006 11:51:53 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id A9782204D2;
	Thu,  2 Nov 2006 11:51:53 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kA22prW0029341;
	Thu, 2 Nov 2006 11:51:53 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 02 Nov 2006 11:51:53 +0900 (JST)
Message-Id: <20061102.115153.25475422.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips irq cleanups
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061101184755.GC4736@linux-mips.org>
References: <20061102.020836.25912635.anemo@mba.ocn.ne.jp>
	<20061101184755.GC4736@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 1 Nov 2006 18:47:55 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> >  37 files changed, 289 insertions(+), 1647 deletions(-)
> 
> Very nice.  I gave it a shot on a Malta and it works just fine.

Thanks!  For most level type irq chips (which initialize .ack, .mask
and .mask_ack rountine with same function), it should be easy to
migrate to new irq flow handler:

1. replace set_irq_chip() with set_irq_chip_and_handler(..., handle_level_irq)
2. use generic_handle_irq() instead of __do_IRQ()

I'm still not sure for per-cpu type irq chips and egdg type irq chips,
especially i8259.  The i8259 seems not suitable for handle_edge_irq or
handle_level_irq yet.  The irq handling on SMP seems another maze ...

---
Atsushi Nemoto
