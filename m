Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 16:32:35 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:34549 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20029762AbXIZPc0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Sep 2007 16:32:26 +0100
Received: from localhost (p2188-ipad308funabasi.chiba.ocn.ne.jp [123.217.188.188])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4E51413ABB; Thu, 27 Sep 2007 00:32:21 +0900 (JST)
Date:	Thu, 27 Sep 2007 00:34:00 +0900 (JST)
Message-Id: <20070927.003400.108121785.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	vagabon.xyz@gmail.com, tbm@cyrius.com, linux-mips@linux-mips.org
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0709261525510.30122@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709261226340.30122@blysk.ds.pg.gda.pl>
	<46FA5FFA.1060704@gmail.com>
	<Pine.LNX.4.64N.0709261525510.30122@blysk.ds.pg.gda.pl>
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
X-archive-position: 16699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 26 Sep 2007 15:49:41 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
>  Given the dependency is quite straightforward it could have been sorted 
> out with a reverse dependency in Kconfig based on the load addresses 
> specified in Makefile -- boring, but easily done.  That assuming the 
> failure of -msym32 resulting from the use of an older unsupported 
> toolchain would be reported as fatal to the user, together with 
> information of which versions are the minimum.

Current linux-queue code adds -msym32 if the load address was CKSEG0,
so it can not be compiled with gcc 3.x.  I think this patch fixes the
problem:

http://www.linux-mips.org/archives/linux-mips/2007-03/msg00404.html

---
Atsushi Nemoto
