Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Sep 2006 02:56:09 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:26845 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038603AbWILB4G (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Sep 2006 02:56:06 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 12 Sep 2006 10:56:04 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 102F820603;
	Tue, 12 Sep 2006 10:55:59 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 040FE205B1;
	Tue, 12 Sep 2006 10:55:59 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k8C1tuW0001517;
	Tue, 12 Sep 2006 10:55:57 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 12 Sep 2006 10:55:56 +0900 (JST)
Message-Id: <20060912.105556.25910629.nemoto@toshiba-tops.co.jp>
To:	macro@linux-mips.org
Cc:	nigel@mips.com, ralf@linux-mips.org, dan@debian.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0609111810090.29692@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0609111406400.29692@blysk.ds.pg.gda.pl>
	<20060911.233046.41631256.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0609111810090.29692@blysk.ds.pg.gda.pl>
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
X-archive-position: 12563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 11 Sep 2006 18:53:29 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > It might add a little overhead to usual TLB refill handling.  The
> > overhead might be neglectable, but I'm not sure.
> 
>  There is no need to change the refill handler -- only the general TLBL 
> exception has to be modified.  And this one may be not too critical -- the 
> change required is in the path to mark pages accessed.  Is the path 
> frequent enough to seek a complex solution while a simple one would just 
> work?

Yes, my description was wrong.  general TLBL handling, not TLB refill
handling.

Hmm, it seems not so critical indeed.  Then "take 2" patch would be
exactly what you preferred.

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=20060710.234010.07457279.anemo%40mba.ocn.ne.jp

Any comments about that?

---
Atsushi Nemoto
