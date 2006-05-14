Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 May 2006 18:08:14 +0200 (CEST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:60103 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133616AbWENQIH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 May 2006 18:08:07 +0200
Received: from localhost (p5058-ipad30funabasi.chiba.ocn.ne.jp [221.184.80.58])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D9379B677; Mon, 15 May 2006 01:08:02 +0900 (JST)
Date:	Mon, 15 May 2006 01:08:46 +0900 (JST)
Message-Id: <20060515.010846.25910142.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	Thiemo Seufer <ths@networkno.de>
Subject: kernel patch for QEMU ?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 11417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Now I'm trying QEMU 0.8.1 on mips.

I found mips-test-0.1.tar.gz on QEMU download page and can run it
(thanks ths!), but I still can not run a kernel (current lmo git)
compiled by myself.  My kernel stops after the famous "Checking for
'wait' instruction...  available." message.

The mips-test-0.1 contains kernel 2.6.16-rc6.  Is this a stock
kernel.org's kernel or lmo's kernel?  Or is there any patch to make
kernel run on QEMU?

---
Atsushi Nemoto
