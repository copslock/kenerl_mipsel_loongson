Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 May 2007 15:42:44 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:36068 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022635AbXEKOmn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 May 2007 15:42:43 +0100
Received: from localhost (p6018-ipad206funabasi.chiba.ocn.ne.jp [222.145.80.18])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 64F49AF1E; Fri, 11 May 2007 23:41:22 +0900 (JST)
Date:	Fri, 11 May 2007 23:41:34 +0900 (JST)
Message-Id: <20070511.234134.126573972.anemo@mba.ocn.ne.jp>
To:	ths@networkno.de
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] MIPS: Run checksyscalls for N32 and O32 ABI
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070511135114.GA16014@networkno.de>
References: <20070511.010234.74566169.anemo@mba.ocn.ne.jp>
	<cda58cb80705110514g1098de81lec547e774eb76482@mail.gmail.com>
	<20070511135114.GA16014@networkno.de>
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
X-archive-position: 15042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 11 May 2007 14:51:14 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > woah, quite a lot of works are waiting for you ;)
> 
> AFAICS everything except utimensat is a false positive.

Well, fadvise64_64 is not a false positive, isn't it?  LFS version of
posix_fadvise needs fadvise64_64, not fadvise64.

And anyway fadvise64_64 needs some fix to adjust longlong argument as
I said before.
---
Atsushi Nemoto
