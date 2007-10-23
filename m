Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 14:06:40 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:1770 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20030742AbXJWNGc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2007 14:06:32 +0100
Received: from localhost (p3228-ipad307funabasi.chiba.ocn.ne.jp [123.217.181.228])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 936CF9B4C; Tue, 23 Oct 2007 22:06:27 +0900 (JST)
Date:	Tue, 23 Oct 2007 22:08:20 +0900 (JST)
Message-Id: <20071023.220820.104639432.anemo@mba.ocn.ne.jp>
To:	tglx@linutronix.de
Cc:	yoichi_yuasa@tripeaks.co.jp, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] add GT641xx timer0 clockevent
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <alpine.LFD.0.9999.0710230719090.3167@localhost.localdomain>
References: <200710230214.l9N2EYBa016911@po-mbox301.hop.2iij.net>
	<20071023.114824.122622188.nemoto@toshiba-tops.co.jp>
	<alpine.LFD.0.9999.0710230719090.3167@localhost.localdomain>
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
X-archive-position: 17180
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 23 Oct 2007 07:21:28 +0200 (CEST), Thomas Gleixner <tglx@linutronix.de> wrote:
> > Thomas, clockevents_program_event() (or ->set_next_event() method for
> > clock_event_device) is supposed to be called with interrupt enabled?
> 
> Actually all call sites have interrupts disabled right now and I can
> not think of a reason why we would ever call with interrupts
> enabled. Time to add some comment.

Thanks.  Then I thought i8253 can be optimized little bit, and Ralf
has aleady sent the patch :)

---
Atsushi Nemoto
