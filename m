Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jul 2006 15:54:50 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:43714 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133454AbWGJOyj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Jul 2006 15:54:39 +0100
Received: from localhost (p8142-ipad212funabasi.chiba.ocn.ne.jp [58.91.172.142])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 45664A725; Mon, 10 Jul 2006 23:54:35 +0900 (JST)
Date:	Mon, 10 Jul 2006 23:55:53 +0900 (JST)
Message-Id: <20060710.235553.48797818.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0607071715360.25285@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0607071607520.25285@blysk.ds.pg.gda.pl>
	<20060708.011245.82794581.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0607071715360.25285@blysk.ds.pg.gda.pl>
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
X-archive-position: 11965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 7 Jul 2006 17:58:44 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> 	mfc0	k0, CP0_CAUSE
> 	MFC0	k1, CP0_EPC
> 	bltz	k0, handle_ri_slow	/* if delay slot */
> 	 lui	k0, 0x7c03

I noticed that checking for CP0_CAUSE.BD is unneeded, since we are
checking the instruction code anyway and "rdhwr" does not have a delay
slot.  I removed the checking on the "take 2" patch I just sent.

---
Atsushi Nemoto
