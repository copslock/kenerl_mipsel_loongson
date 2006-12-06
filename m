Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 02:56:12 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:30909 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20039154AbWLFC4I (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Dec 2006 02:56:08 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 6 Dec 2006 11:56:06 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 53846417CC;
	Wed,  6 Dec 2006 11:56:03 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 4026320302;
	Wed,  6 Dec 2006 11:56:03 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id kB62u2W0084873;
	Wed, 6 Dec 2006 11:56:03 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 06 Dec 2006 11:56:02 +0900 (JST)
Message-Id: <20061206.115602.63741871.nemoto@toshiba-tops.co.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061206015818.GB27985@linux-mips.org>
References: <20061205195702.GA2097@linux-mips.org>
	<20061206.103923.71086192.nemoto@toshiba-tops.co.jp>
	<20061206015818.GB27985@linux-mips.org>
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
X-archive-position: 13362
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Wed, 6 Dec 2006 01:58:18 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> There are some other issues with the legacy IDE on the Intel PIIX which
> likely affect other systems such as Alpha as well.  I think I solved that
> so it's now time to tackle the IRQ stuff.  Even without your i8259 stuff
> there are some strange things going on currently:
> 
> [...]
> irq 7, desc: 803db360, depth: 1, count: 0, unhandled: 0
> ->handle_irq():  8014ff28, handle_bad_irq+0x0/0x318
> ->chip(): 803a3d4c, 0x803a3d4c
> ->action(): 00000000
>   IRQ_DISABLED set
> unexpected IRQ # 7

Hmm ... malta_int.c:get_int() returned 7?  I have no idea, but it
seems mips_irq_lock in malta_int.c can be replaced by i8259A_lock...

---
Atsushi Nemoto
