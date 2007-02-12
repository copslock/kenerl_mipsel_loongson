Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2007 17:03:01 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:28113 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038879AbXBLRCz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2007 17:02:55 +0000
Received: from localhost (p7240-ipad209funabasi.chiba.ocn.ne.jp [58.88.118.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A9873AD6E; Tue, 13 Feb 2007 02:01:34 +0900 (JST)
Date:	Tue, 13 Feb 2007 02:01:34 +0900 (JST)
Message-Id: <20070213.020134.18306317.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	vagabon.xyz@gmail.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] clean up ret_from_{irq,exception}
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0702121642010.31592@blysk.ds.pg.gda.pl>
References: <cda58cb80702120044o6c434032pc2f3da68a7327097@mail.gmail.com>
	<20070212.234538.25910340.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0702121642010.31592@blysk.ds.pg.gda.pl>
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
X-archive-position: 14052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 12 Feb 2007 16:51:57 +0000 (GMT), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > It seems dec/int-handler.S has been broken for a while.  I'll send a
> > patch to fix it.  If it was ACKed, I ACK your patch.
> 
>  It works for me with 2.6.18 -- if it needs an update due to more recent 
> changes, then I have not got there yet. ;-)  I plan to rewrite this bit in 
> C if feasible like other platforms did too.

The breakage happened during 2.6.19 development cycle (large pt_regs
argument removal).

---
Atsushi Nemoto
