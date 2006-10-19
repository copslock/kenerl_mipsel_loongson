Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Oct 2006 08:51:27 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:28315 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20037492AbWJSHvZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 19 Oct 2006 08:51:25 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 19 Oct 2006 16:51:22 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 3A01941B8A;
	Thu, 19 Oct 2006 16:51:11 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 2D1224180E;
	Thu, 19 Oct 2006 16:51:11 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9J7pAW0069658;
	Thu, 19 Oct 2006 16:51:10 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 19 Oct 2006 16:51:10 +0900 (JST)
Message-Id: <20061019.165110.21957261.nemoto@toshiba-tops.co.jp>
To:	vagabon.xyz@gmail.com
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org
Subject: Re: [PATCH 6/7] setup.c: clean up initrd related code
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <4537296C.50702@innova-card.com>
References: <cda58cb80610182337h611f1cf0vd489b5828dfd269f@mail.gmail.com>
	<20061019.155124.96684956.nemoto@toshiba-tops.co.jp>
	<4537296C.50702@innova-card.com>
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
X-archive-position: 13014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 19 Oct 2006 09:29:48 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > But we need sign extension for values comes from the initrd_header
> > anyway.  The initrd_header is fixed-size and can not hold 64-bit
> > address.
> > 
> 
> initrd_header gives only 2 numbers: size of initrd, and a magic number,
> well it's what I understood when rewriting the code.
> 
> the start address of initrd is given by:
> 
> 	initrd_header = __va(PAGE_ALIGN(__pa_symbol(&_end) + 8)) - 8;
> 	initrd_start = (unsigned long)&initrd_header[2];
> 
> I don't think we need any sign extension here, do we ?

Oh I was confused.  You are right.

BTW, we can just ignore initrd instead of panic() if invalid values
given.  This place around is too early to print panic message.
Continuing with printk(KERN_ERR) will give us a chance to see what's
wrong.

---
Atsushi Nemoto
