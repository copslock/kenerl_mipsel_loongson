Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jun 2006 16:27:50 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:12788 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8134067AbWFOP1k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 15 Jun 2006 16:27:40 +0100
Received: from localhost (p7208-ipad209funabasi.chiba.ocn.ne.jp [58.88.118.208])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id ECF7AFE; Fri, 16 Jun 2006 00:27:34 +0900 (JST)
Date:	Fri, 16 Jun 2006 00:28:37 +0900 (JST)
Message-Id: <20060616.002837.59465125.anemo@mba.ocn.ne.jp>
To:	dan@debian.org
Cc:	libc-ports@sourceware.org, linux-mips@linux-mips.org
Subject: Re: mips RDHWR instruction in glibc
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060614165040.GA19480@nevyn.them.org>
References: <20060615.001238.65193088.anemo@mba.ocn.ne.jp>
	<20060614165040.GA19480@nevyn.them.org>
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
X-archive-position: 11738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 14 Jun 2006 12:50:40 -0400, Daniel Jacobowitz <dan@debian.org> wrote:
> > For example, in the code below, RDHWR is placed _before_ checking the
> > error.  I suppose these instructions were reordered by gcc's
> > optimization, but the optimization would have large negative effect in
> > this case.
> 
> You'd have to figure out how to get GCC not to eagerly schedule the
> rdhwr.  This might be quite hard.  I don't know much about this part of
> the scheduler.

I really did not understand yet how errno is bound TLS.  I found some
"rdhwr" in glibc-ports source code (tls-macros.h, nptl/tls.h).  The
RDHWR instruction in the example code comes from one of them, no?

I also found a "rdhwr" in gcc's mips.md file ("tls_get_tp_<mode>").
Is this the origin?  MD is a very foreign language for me...

---
Atsushi Nemoto
