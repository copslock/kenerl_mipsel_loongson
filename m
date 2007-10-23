Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2007 02:07:04 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:34496 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20025822AbXJWBGz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Oct 2007 02:06:55 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 23 Oct 2007 10:06:53 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 0BC734249D;
	Tue, 23 Oct 2007 10:06:46 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id F3C3B42449;
	Tue, 23 Oct 2007 10:06:45 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l9N16jAF081071;
	Tue, 23 Oct 2007 10:06:45 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 23 Oct 2007 10:06:45 +0900 (JST)
Message-Id: <20071023.100645.74754145.nemoto@toshiba-tops.co.jp>
To:	yoichi_yuasa@tripeaks.co.jp
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] add GT641xx timer0 clockevent
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <200710230054.l9N0sVv7031267@po-mbox301.hop.2iij.net>
References: <20071022194315.f75738ba.yoichi_yuasa@tripeaks.co.jp>
	<20071022.234755.45745247.anemo@mba.ocn.ne.jp>
	<200710230054.l9N0sVv7031267@po-mbox301.hop.2iij.net>
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
X-archive-position: 17166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 23 Oct 2007 09:55:55 +0900, Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> > These clockevent routines are always called with interrupt disabled,
> > so I suppose those spin_lock_irqsave/spin_unlock_irqrestore pairs can
> > be omitted. (or this timer can be used on SMP?)
> 
> Yes, it can be used on Malta(SMP).

Then spin_lock()/spin_unlock() is enough, isn't it?

---
Atsushi Nemoto
