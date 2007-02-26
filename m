Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Feb 2007 11:06:25 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:34842 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20038592AbXBZLGV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Feb 2007 11:06:21 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 26 Feb 2007 20:06:19 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 2ECA441DF1;
	Mon, 26 Feb 2007 20:05:56 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 2216C203A7;
	Mon, 26 Feb 2007 20:05:56 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l1QB5sW0049590;
	Mon, 26 Feb 2007 20:05:55 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 26 Feb 2007 20:05:54 +0900 (JST)
Message-Id: <20070226.200554.125898248.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	jeff@garzik.org, michal.k.k.piotrowski@gmail.com,
	pg@cs.stanford.edu, ahennessy@mvista.com, netdev@vger.kernel.org,
	linux-mips@linux-mips.org,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: possible bug in net/tc35815.c in linux-2.6.19
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070226102659.GA28439@linux-mips.org>
References: <45E031A3.806@googlemail.com>
	<45E0B651.2050601@garzik.org>
	<20070226102659.GA28439@linux-mips.org>
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
X-archive-position: 14246
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 26 Feb 2007 10:26:59 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > I created my own patch for this (and one other bug), and checked it in.
> > 
> > Really, though, someone in MIPS-land should give this driver some loving 
> > care.  It is filled with bugs and 2.4-era anachronisms.
> 
> Took a look at it.  It's sort of a non-bug because the driver cannot be
> compiled as module, so the module_exit function cannot possibly be
> executed.  The board support code is calling into the driver which makes
> it impossible to build this driver as a module, yet it's possible to
> select building this driver as a module ...  Oh yeah, that root_tc35815_dev
> stuff is also pretty ugly.

Yes, the driver is quite obsoleted.  It was added long ago with
arch/mips/jmr3927 and not maintained long time, as like as the board
itself.

I know both MontaVista and CELF have new driver for the chip.  If
anybody in MontaVista did not complain I can send CELF's one available
at http://tree.celinuxforum.org/pubwiki/moin.cgi/PatchArchive.  (it
needs some changes for recent kernel, for example pt_regs removal, but
it would be easy).

Sergei?

---
Atsushi Nemoto
