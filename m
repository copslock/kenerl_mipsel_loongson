Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jul 2008 14:11:25 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:42449 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20036734AbYGMNLW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 13 Jul 2008 14:11:22 +0100
Received: from localhost (p1204-ipad207funabasi.chiba.ocn.ne.jp [222.145.83.204])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 03009AB3B; Sun, 13 Jul 2008 22:11:17 +0900 (JST)
Date:	Sun, 13 Jul 2008 22:13:03 +0900 (JST)
Message-Id: <20080713.221303.74752673.anemo@mba.ocn.ne.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	tsbogend@alpha.franken.de, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] mips_machtype define as one group
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080713194503.23e4e1a1.yoichi_yuasa@tripeaks.co.jp>
References: <20080712174741.c4dd3149.yoichi_yuasa@tripeaks.co.jp>
	<20080712143225.GA9053@alpha.franken.de>
	<20080713194503.23e4e1a1.yoichi_yuasa@tripeaks.co.jp>
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
X-archive-position: 19805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 13 Jul 2008 19:45:03 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > this looks a little messy. The _EVAL and _GW defines are more a kernel
> > config option than a real machine type and all they are good for is
> > selecting whether there is a second serial port and which speed the
> > speed kgdb should use. I'd remove that all and just set a flag, whether
> > there is a second uart. I'd remove the kgbd usage, but if it's really
> > needed adding another flag/variabne would do the trick.
> > 
> > Anything I missed ?
> 
> I totally agree with you.
> I'm making a patch for MACH_TOSHIBA_* .

Thanks, I'll review your patchset soon.

---
Atsushi Nemoto
