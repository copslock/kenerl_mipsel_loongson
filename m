Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7R88AD17604
	for linux-mips-outgoing; Mon, 27 Aug 2001 01:08:10 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7R887d17599
	for <linux-mips@oss.sgi.com>; Mon, 27 Aug 2001 01:08:08 -0700
Received: from inside-ms2.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 27 Aug 2001 08:08:07 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms2.toshiba-tops.co.jp (Postfix) with ESMTP
	id 508BB54C12; Mon, 27 Aug 2001 17:08:06 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id RAA99917; Mon, 27 Aug 2001 17:08:04 +0900 (JST)
Date: Mon, 27 Aug 2001 17:12:41 +0900 (JST)
Message-Id: <20010827.171241.71082478.nemoto@toshiba-tops.co.jp>
To: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Cc: Ralf Baechle <ralf@uni-koblenz.de>
Subject: to_tm() function in arch/mips/kernel/time.c
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Mailer: Mew version 2.0 on Emacs 20.7 / Mule 4.1 (AOI)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Now new function to_tm() becomes available in arch/mips/kernel/time.c,
the calculation for tm_wday looks incorrect.

	/* Days are what is left over (+1) from all that. */
	tm->tm_mday = day + 1;

	/*
	 * Determine the day of week
	 */
	tm->tm_wday = (day + 3) % 7;

This code say that a first day of any month is Wednesday :-)
Isn't this what you expected?

	gday = day = tim / SECDAY;
	...
	tm->tm_wday = (gday + 4) % 7; /* 1970/1/1 was Thursday */

---
Atsushi Nemoto
