Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2007 17:40:29 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:22484 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20021923AbXD1Qk1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2007 17:40:27 +0100
Received: from localhost (p7147-ipad204funabasi.chiba.ocn.ne.jp [222.146.94.147])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7A443B729; Sun, 29 Apr 2007 01:40:23 +0900 (JST)
Date:	Sun, 29 Apr 2007 01:40:26 +0900 (JST)
Message-Id: <20070429.014026.25926525.anemo@mba.ocn.ne.jp>
To:	akpm@linux-foundation.org
Cc:	linux-mips@linux-mips.org, netdev@vger.kernel.org, jeff@garzik.org,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: Re: [PATCH 1/3] ne: Add platform_driver
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070428005727.6414a24e.akpm@linux-foundation.org>
References: <20070425.015450.25909765.anemo@mba.ocn.ne.jp>
	<20070428005727.6414a24e.akpm@linux-foundation.org>
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
X-archive-position: 14940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 28 Apr 2007 00:57:27 -0700, Andrew Morton <akpm@linux-foundation.org> wrote:
> > +#else /* MODULE */
> > +module_init(ne_init);
> > +module_exit(ne_exit);
> >  #endif /* MODULE */
> 
> Are we sure about this part?  It is unusual to have special treatment dependent
> upon MODULE.

Yes, it is unusual now, but ne.c has old-fashioned init_module() which
can not be used if it was built into kernel.  Also ne.c depends on
old-style initialization by Space.c.

Rewriting those old-style initialization code could be possible, but
it will involve much more changes and might cause compatibility issue
(if somebody depends on ethN order of built-in drivers).  So I chose
least intrusive way.

---
Atsushi Nemoto
