Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 03:03:02 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:10684 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039596AbXBHDC5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Feb 2007 03:02:57 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 8 Feb 2007 12:02:55 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 9CB4741E7F;
	Thu,  8 Feb 2007 12:02:19 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 8FF3141E7E;
	Thu,  8 Feb 2007 12:02:19 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l1832JW0067497;
	Thu, 8 Feb 2007 12:02:19 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 08 Feb 2007 12:02:19 +0900 (JST)
Message-Id: <20070208.120219.96684712.nemoto@toshiba-tops.co.jp>
To:	macro@linux-mips.org
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [MIPS] Check FCSR for pending interrupts before restoring from
 a context.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.64N.0702071725150.9744@blysk.ds.pg.gda.pl>
References: <20070207110929.GA17660@linux-mips.org>
	<20070208.012216.103777705.anemo@mba.ocn.ne.jp>
	<Pine.LNX.4.64N.0702071725150.9744@blysk.ds.pg.gda.pl>
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
X-archive-position: 13971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 7 Feb 2007 17:29:02 +0000 (GMT), "Maciej W. Rozycki" <macro@linux-mips.org> wrote:
> > If the format of FCSR was common to all CPU (I hope so), we can do
> > check it in caller of fp_restore_context(), in C language.
> 
>  The R3010, etc. use bits 23 and 17:0 the same way as the R4000 and MIPS 
> architecture processors do.  The other bits are unused and hardwired to 
> zeroes.

So we can do it in C, but it will conflicts with Franck's signal
cleanup patchset.  I hope his patchset applied first.

Also I wonder SIGSEGV is correct behavior on this case.  SIGFPE?

---
Atsushi Nemoto
