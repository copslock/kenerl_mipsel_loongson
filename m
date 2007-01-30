Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2007 16:43:00 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:22736 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038516AbXA3Qmz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 30 Jan 2007 16:42:55 +0000
Received: from localhost (p6132-ipad32funabasi.chiba.ocn.ne.jp [221.189.138.132])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2A91BB63E; Wed, 31 Jan 2007 01:41:34 +0900 (JST)
Date:	Wed, 31 Jan 2007 01:41:33 +0900 (JST)
Message-Id: <20070131.014133.75185230.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	macro@linux-mips.org, dan@debian.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: RFC: Sentosa boot fix
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <cda58cb80701290827i1892e74dlb60651847982f77f@mail.gmail.com>
References: <Pine.LNX.4.64N.0701291527130.26916@blysk.ds.pg.gda.pl>
	<20070130.011442.21365159.anemo@mba.ocn.ne.jp>
	<cda58cb80701290827i1892e74dlb60651847982f77f@mail.gmail.com>
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
X-archive-position: 13860
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 29 Jan 2007 17:27:04 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> It may be interesting to have a look to the assembly code in this case
> to see what the compiler does exactly.

I compiled ip27 kernel and really confused...

head.S:
	PTR_LA		t0, __bss_start		# clear .bss
	LONG_S		zero, (t0)

System.map:
a8000000003b6000 A __bss_start

vmlinux:
a800000000385058:	3c0c003b 	lui	t0,0x3b
a80000000038505c:	658c6000 	daddiu	t0,t0,24576
a800000000385060:	fd800000 	sd	zero,0(t0)

vmlinux.32:
80385058:	3c0c003b 	lui	t4,0x3b
8038505c:	658c6000 	daddiu	t4,t4,24576
80385060:	fd800000 	sd	zero,0(t4)

How does this code work?  Isn't address 0x3b6000 in user space?

---
Atsushi Nemoto
