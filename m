Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 04:12:02 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:48348 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20027600AbWJKDMA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 04:12:00 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 11 Oct 2006 12:11:58 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 909BB20578;
	Wed, 11 Oct 2006 12:11:56 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 853B820569;
	Wed, 11 Oct 2006 12:11:56 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k9B3BtW0029243;
	Wed, 11 Oct 2006 12:11:56 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 11 Oct 2006 12:11:55 +0900 (JST)
Message-Id: <20061011.121155.25910632.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	vagabon.xyz@gmail.com, ths@networkno.de, linux-mips@linux-mips.org
Subject: Re: [PATCH] setup.c: introduce __pa_symbol() and get ride of
 CPHYSADDR()
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061010215124.GA21012@linux-mips.org>
References: <20061011.002914.76462350.anemo@mba.ocn.ne.jp>
	<452BC4A5.3080706@innova-card.com>
	<20061010215124.GA21012@linux-mips.org>
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
X-archive-position: 12896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 10 Oct 2006 22:51:24 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > ok, and does the trick on KSEG0/XKPHYS really worth ? I mean what is
> > the size code gain ?
> 
> Gcc / gas generate a 6 instruction sequence to load something from a
> 64-bit address, basically lui, add, dsll16, add, dsll16, add.  It's
> just 2 instructions for 32-bit addresses.  This boils down to space
> savings in the hundred of kilobytes for a kernel.

Yes, I got ~10% smaller kernel (4.8MB to 4.4MB) with -msym32.

If modules are loaded into CKSEG2, we can use -msym32 for modules as
well.  Until then this patch can be used for workaroung:

http://www.linux-mips.org/archives/linux-mips/2006-10/msg00111.html

---
Atsushi Nemoto
