Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2005 01:09:27 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:20488
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225401AbVAYBJM>; Tue, 25 Jan 2005 01:09:12 +0000
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 25 Jan 2005 01:09:10 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id C384A239E41; Tue, 25 Jan 2005 10:09:08 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id j0P197Rm089898;
	Tue, 25 Jan 2005 10:09:08 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 25 Jan 2005 10:09:07 +0900 (JST)
Message-Id: <20050125.100907.45518593.nemoto@toshiba-tops.co.jp>
To:	macro@linux-mips.org
Cc:	macro@mips.com, rsandifo@redhat.com, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.61L.0501211739410.16576@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.61.0501141956520.21179@perivale.mips.com>
	<20050122.015040.108744446.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.61L.0501211739410.16576@blysk.ds.pg.gda.pl>
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
X-archive-position: 7030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sat, 22 Jan 2005 02:51:47 +0000 (GMT), "Maciej W. Rozycki" <macro@linux-mips.org> said:
macro> That needs to be addressed first and I expect another update to
macro> the file.  Here's a patch I'm going to start with.  Functions
macro> it adds have been named dma_* to indicate they are meant to
macro> preserve memory byte ordering.

Thank you.  The new patch seems good for me.  It fixes io-string
operations for no SWAP_IO_SPACE system again.

And, of course, I hope the new dma_ioswab*() will also be customizable
by mangle-port.h :-)

---
Atsushi Nemoto
