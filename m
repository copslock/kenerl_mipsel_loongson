Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 02:50:36 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:34983 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S8133740AbWBWCu0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 02:50:26 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Thu, 23 Feb 2006 11:57:37 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 444F6204C2;
	Thu, 23 Feb 2006 11:57:34 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 38744204A8;
	Thu, 23 Feb 2006 11:57:34 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id k1N2vX4D021531;
	Thu, 23 Feb 2006 11:57:33 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 23 Feb 2006 11:57:33 +0900 (JST)
Message-Id: <20060223.115733.82087750.nemoto@toshiba-tops.co.jp>
To:	geoffrey.levand@am.sony.com
Cc:	linux-mips@linux-mips.org
Subject: Re: SERIAL_TXX9 && BROKEN
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <43FD20F7.4090401@am.sony.com>
References: <43FD20F7.4090401@am.sony.com>
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
X-archive-position: 10609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 22 Feb 2006 18:41:59 -0800, Geoff Levand <geoffrey.levand@am.sony.com> said:
geoffrey> I see this in the 2.6.15 drivers/serial/Kconfig:

geoffrey> config SERIAL_TXX9
geoffrey> 	bool "TMPTX39XX/49XX SIO support"
geoffrey> 	depends HAS_TXX9_SERIAL && BROKEN

geoffrey> What's needed to get this to work?

The BROKEN tags was added by temporary breakage.  It was resolved
soon at that time but I forgot to remove the tag.  So do not care.
Just remove it.

Also, the updated patch including some other minor fixes are already
in -mm tree.  It was once in 2.6.16-rc1-mm5, but it seems lost by
accident.  Now it is in -mm tree again so the next -mm release will
contain it.  You can get it from:

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm5/broken-out/serial-serial_txx9-driver-update.patch

---
Atsushi Nemoto
