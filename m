Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 03:55:25 +0200 (CEST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:45943 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133767AbWEOBzR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 May 2006 03:55:17 +0200
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Mon, 15 May 2006 10:55:16 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 86C892058D;
	Mon, 15 May 2006 10:55:14 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 7B69B20579;
	Mon, 15 May 2006 10:55:14 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k4F1tD4D026479;
	Mon, 15 May 2006 10:55:13 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Mon, 15 May 2006 10:55:13 +0900 (JST)
Message-Id: <20060515.105513.27954532.nemoto@toshiba-tops.co.jp>
To:	ths@networkno.de
Cc:	linux-mips@linux-mips.org
Subject: Re: kernel patch for QEMU ?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060514182151.GB800@networkno.de>
References: <20060515.010846.25910142.anemo@mba.ocn.ne.jp>
	<20060514182151.GB800@networkno.de>
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
X-archive-position: 11427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 14 May 2006 19:21:51 +0100, Thiemo Seufer <ths@networkno.de> wrote:
> > The mips-test-0.1 contains kernel 2.6.16-rc6.  Is this a stock
> > kernel.org's kernel or lmo's kernel?  Or is there any patch to make
> > kernel run on QEMU?
> 
> This kernel is stock lmo except for a small patch which allows clean
> system shutdown (qemu 0.8.1 does not have the counterpart to it).
> The patch should be completely irrelevant otherwise.
> 
> However, later kernels try to access the CP0 pagemask register which
> is R10000 specific, IIRC Qemu throws an Reserved Instruction exception
> on accessing it.

Thanks.  I'm looking output of "git-diff linux-2.6.16-rc6" but still
failed to find relevant changes...

The stock QEMU 0.8.1 works ok with vmlinux-r1 in mips-test-0.1 so it
should be something different on kernel side.  Hmm...

---
Atsushi Nemoto
