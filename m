Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6NA1kO17512
	for linux-mips-outgoing; Mon, 23 Jul 2001 03:01:46 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6NA1hV17509
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 03:01:44 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 23 Jul 2001 10:01:45 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (8.9.3/3.7W-MailExchenger) with ESMTP id TAA58671;
	Mon, 23 Jul 2001 19:01:21 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id TAA08890; Mon, 23 Jul 2001 19:01:21 +0900 (JST)
To: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: time_init() enables interrupt.
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 1.94.2 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010723190544N.nemoto@toshiba-tops.co.jp>
Date: Mon, 23 Jul 2001 19:05:44 +0900
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

arch/mips/kernel/time.c:time_init() in current CVS contains following codes:

	/* setup xtime */
	write_lock_irq(&xtime_lock);
	xtime.tv_sec = rtc_get_time();
	xtime.tv_usec = 0;
	write_unlock_irq(&xtime_lock);

The write_unlock_irq() macro calls __sti(), but it is too early to
enable interrupts.

I think this write_lock_irq/write_unlock_irq pair should be removed
(or replaced with write_lock_irqsave/write_unlock_irqrestore pair).

---
Atsushi Nemoto
