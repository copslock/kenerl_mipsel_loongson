Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Sep 2006 13:51:02 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:52695 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037888AbWIJMu6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 10 Sep 2006 13:50:58 +0100
Received: from localhost (p1239-ipad27funabasi.chiba.ocn.ne.jp [220.107.192.239])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2ABDF94CA; Sun, 10 Sep 2006 21:50:54 +0900 (JST)
Date:	Sun, 10 Sep 2006 21:52:52 +0900 (JST)
Message-Id: <20060910.215252.108307097.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	linux-mips@linux-mips.org
Subject: Re: cpu_idle and cpu_wait
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060910001803.GA826@linux-mips.org>
References: <20051118.122242.07017522.nemoto@toshiba-tops.co.jp>
	<20060608.010901.108121387.anemo@mba.ocn.ne.jp>
	<20060910001803.GA826@linux-mips.org>
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
X-archive-position: 12548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Sun, 10 Sep 2006 02:18:03 +0200, Ralf Baechle <ralf@linux-mips.org> wrote:
> Applied but based on feedback from the 4K and 5K CPU designers I modified
> your patch to continue using the old code.

Thanks!  IIRC MIPS4K? and MIPS5Kc datasheets state that any masked
interrupts can break WAIT instruction, but I could not test by myself
since I do not have any of them.  I believe feedback from CPU
designers of course :-)

---
Atsushi Nemoto
