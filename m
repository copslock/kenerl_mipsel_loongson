Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2006 15:00:11 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:7135 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133534AbWBRPAB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 18 Feb 2006 15:00:01 +0000
Received: from localhost (p7103-ipad209funabasi.chiba.ocn.ne.jp [58.88.118.103])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D4CC3AC42; Sun, 19 Feb 2006 00:06:43 +0900 (JST)
Date:	Sun, 19 Feb 2006 00:06:33 +0900 (JST)
Message-Id: <20060219.000633.63740163.anemo@mba.ocn.ne.jp>
To:	tbm@cyrius.com
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: Oops with git: do_signal32 on 64-bit
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060218145545.GX20785@deprecation.cyrius.com>
References: <20060217225216.GA15781@deprecation.cyrius.com>
	<20060218.220701.25910111.anemo@mba.ocn.ne.jp>
	<20060218145545.GX20785@deprecation.cyrius.com>
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
X-archive-position: 10511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sat, 18 Feb 2006 14:55:45 +0000, Martin Michlmayr <tbm@cyrius.com> said:

tbm> Done now, and tested on Cobalt.

Looks good for me, except one point.
Since do_signal() return void now, do_signal32 also should return void.

Also, I think prototypes of do_signal() variant should be in
asm/signal.h or so to avoid such mistake in the future, but this might
be an another patch ...

---
Atsushi Nemoto
