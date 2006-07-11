Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2006 04:20:37 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:28841 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8126484AbWGKDU2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Jul 2006 04:20:28 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 11 Jul 2006 12:20:25 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 608FC203F1;
	Tue, 11 Jul 2006 12:20:15 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 53E7D203E9;
	Tue, 11 Jul 2006 12:20:15 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k6B3KEW0022064;
	Tue, 11 Jul 2006 12:20:14 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 11 Jul 2006 12:20:14 +0900 (JST)
Message-Id: <20060711.122014.52129937.nemoto@toshiba-tops.co.jp>
To:	dan@debian.org
Cc:	macro@linux-mips.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060711025342.GA6898@nevyn.them.org>
References: <Pine.LNX.4.64N.0607071715360.25285@blysk.ds.pg.gda.pl>
	<20060710.235553.48797818.anemo@mba.ocn.ne.jp>
	<20060711025342.GA6898@nevyn.them.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 10 Jul 2006 22:53:42 -0400, Daniel Jacobowitz <dan@debian.org> wrote:
> > I noticed that checking for CP0_CAUSE.BD is unneeded, since we are
> > checking the instruction code anyway and "rdhwr" does not have a delay
> > slot.  I removed the checking on the "take 2" patch I just sent.
> 
> Isn't BD "this instruction is in a delay slot", not "this instruction
> has a delay slot"?  It affects where we go when we return.
 
Well, the BD means "the exception occurred on a delay slot of this
(which EPC points) instruction".  If rdhwr was in a delay slot, EPC
points the preceding jump/branch instruction.  This fast path is
reading a instruction at the EPC (regardless BD), so it must not be
"rdhwr" and fall back to slow path.

> BTW, if the fast emulation can't handle rdhwr in a delay slot, please
> report a bug on GCC asking it not to put rdhwr in delay slots by
> default.  It's probably worthwhile.

If rdhwr was on a delay slot, the slow emulation will be more slower.
So I think rdhwr should not be put on delay slot anyway regardless
fast emulation.

I asked on GCC bugzilla a few days ago but can not got feedback yet.
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=28126

---
Atsushi Nemoto
