Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jul 2006 17:11:56 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:49871 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133540AbWGHQLq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 8 Jul 2006 17:11:46 +0100
Received: from localhost (p5177-ipad202funabasi.chiba.ocn.ne.jp [222.146.76.177])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 783C09B55; Sun,  9 Jul 2006 01:11:42 +0900 (JST)
Date:	Sun, 09 Jul 2006 01:12:59 +0900 (JST)
Message-Id: <20060709.011259.92587435.anemo@mba.ocn.ne.jp>
To:	macro@linux-mips.org
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0607071715360.25285@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0607071607520.25285@blysk.ds.pg.gda.pl>
	<20060708.011245.82794581.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0607071715360.25285@blysk.ds.pg.gda.pl>
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
X-archive-position: 11946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 7 Jul 2006 17:58:44 +0100 (BST), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > Thanks, now I understand the problem.  Are there any good solutions?
> > Only I can think now is using handle_ri_slow for such CPUs.
> 
>  I have implemented an appropriate update to the TLB handlers (or actually 
> it's enough to care for this case for the TLBL exception), but it predates 
> the current synthesized ones.  There is a small impact resulting from 
> this change and the synthesized handlers have the advantage of making it 
> only necessary for these chips that do need such handling.

Do you still have the code?  Could you post it for reference?

>  I'd restructure the code more or less like this, taking care for (almost) 
> all stalls resulting from interlocks on coprocessor moves and memory loads 
> and likewise avoiding the need for "nop" fillers there for MIPS I 
> processors:

Thanks.  I'll look it deeply.

> 	bne	k0, k1, handle_ri_slow	/* if not ours */
> 	 get_saved_sp			/* k1 := current_thread_info */

Unfortunately, get_saved_sp is not a single instruction...

---
Atsushi Nemoto
