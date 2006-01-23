Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 13:09:43 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:48376 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S3458578AbWAWNJZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Jan 2006 13:09:25 +0000
Received: from localhost (p2198-ipad02funabasi.chiba.ocn.ne.jp [61.214.22.198])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 43744A4EE; Mon, 23 Jan 2006 22:13:30 +0900 (JST)
Date:	Mon, 23 Jan 2006 22:13:04 +0900 (JST)
Message-Id: <20060123.221304.126141509.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	tbm@cyrius.com, yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: DECstation fails to compile with iomap patch applied
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0601231204110.27141@blysk.ds.pg.gda.pl>
References: <20060122134553.GA27266@deprecation.cyrius.com>
	<20060123.152640.11963149.nemoto@toshiba-tops.co.jp>
	<Pine.LNX.4.64N.0601231204110.27141@blysk.ds.pg.gda.pl>
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
X-archive-position: 10057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Mon, 23 Jan 2006 12:09:50 +0000 (GMT), "Maciej W. Rozycki" <macro@linux-mips.org> said:

macro>  I think "iomap.o" should simply be obj-$(CONFIG_PCI) until
macro> (unless) there is a use for it for other I/O buses.

This is another problem.  For example, The _CACHE_CACHEABLE_COW is not
defined for TX39XX too, and TX3927 has a builtin PCI controller.  So
this is not enough theoretically.

---
Atsushi Nemoto
