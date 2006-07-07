Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2006 17:42:36 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:43463 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133512AbWGGQm1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Jul 2006 17:42:27 +0100
Received: from localhost (p1163-ipad206funabasi.chiba.ocn.ne.jp [222.146.104.163])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 25B2D8CFE; Sat,  8 Jul 2006 01:42:23 +0900 (JST)
Date:	Sat, 08 Jul 2006 01:43:39 +0900 (JST)
Message-Id: <20060708.014339.89274844.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060708.011245.82794581.anemo@mba.ocn.ne.jp>
References: <20060708.000032.88471510.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0607071607520.25285@blysk.ds.pg.gda.pl>
	<20060708.011245.82794581.anemo@mba.ocn.ne.jp>
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
X-archive-position: 11939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sat, 08 Jul 2006 01:12:45 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> >  For a VIVT I-cache this can result in a TLB exception.  TLB handlers are 
> > not currently prepared for being called at the exception level.
> 
> Thanks, now I understand the problem.  Are there any good solutions?
> Only I can think now is using handle_ri_slow for such CPUs.

Can we use Index_Load_Data_I to load the instruction code from icache?
Just an idea...

---
Atsushi Nemoto
