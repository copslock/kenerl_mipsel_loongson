Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Sep 2006 15:28:53 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:45041 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037486AbWIKO2w (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 Sep 2006 15:28:52 +0100
Received: from localhost (p8244-ipad25funabasi.chiba.ocn.ne.jp [220.104.86.244])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6F5239CB5; Mon, 11 Sep 2006 23:28:47 +0900 (JST)
Date:	Mon, 11 Sep 2006 23:30:46 +0900 (JST)
Message-Id: <20060911.233046.41631256.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	nigel@mips.com, ralf@linux-mips.org, dan@debian.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0609111406400.29692@blysk.ds.pg.gda.pl>
References: <4501AABC.1050009@mips.com>
	<20060909.225641.41198763.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0609111406400.29692@blysk.ds.pg.gda.pl>
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
X-archive-position: 12557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 11 Sep 2006 14:09:20 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > But I'm still looking for better solution (silver bullet?) for
> > cpu_has_vtag_icache case.
> 
>  What's wrong with just letting a TLB fault happen?

It might add a little overhead to usual TLB refill handling.  The
overhead might be neglectable, but I'm not sure.

---
Atsushi Nemoto
