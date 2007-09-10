Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Sep 2007 16:17:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:23792 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022169AbXIJPQy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 10 Sep 2007 16:16:54 +0100
Received: from localhost (p6039-ipad30funabasi.chiba.ocn.ne.jp [221.184.81.39])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7929CCF02; Tue, 11 Sep 2007 00:16:49 +0900 (JST)
Date:	Tue, 11 Sep 2007 00:18:19 +0900 (JST)
Message-Id: <20070911.001819.126573631.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [MIPS] SMTC: Fix crash on bootup with idebus= command line
 argument.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0709101406091.25038@blysk.ds.pg.gda.pl>
References: <S20024438AbXHGQ1m/20070807162742Z+2733@ftp.linux-mips.org>
	<Pine.LNX.4.64N.0709101406091.25038@blysk.ds.pg.gda.pl>
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
X-archive-position: 16441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 10 Sep 2007 14:27:54 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> >  include/asm-mips/mach-generic/ide.h |   76 ++++++++++++-----------------------
> >  1 files changed, 25 insertions(+), 51 deletions(-)
> 
>  This change breaks the SWARM -- depending on the setting of 
> CONFIG_IDE_GENERIC, either a bus error happens because of blind probing or 
> the onboard IDE interface gets designated as "ide2".  I cannot really see 
> a dependency between "idebus=" (which merely sets a variable somewhere in 
> drivers/ide/ide.c) and code affected by this change -- what's the reason 
> behind it?

http://www.linux-mips.org/archives/linux-mips/2007-09/msg00016.html
would be the answer :)

And how about this patch?  Does this fix the problem on SWARM?
http://www.linux-mips.org/archives/linux-mips/2007-09/msg00036.html

---
Atsushi Nemoto
