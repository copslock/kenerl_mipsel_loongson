Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6NA88Q17707
	for linux-mips-outgoing; Mon, 23 Jul 2001 03:08:08 -0700
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6NA86V17704
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 03:08:07 -0700
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 23 Jul 2001 10:08:08 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (8.9.3/3.7W-MailExchenger) with ESMTP id TAA58750;
	Mon, 23 Jul 2001 19:08:02 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id TAA08909; Mon, 23 Jul 2001 19:08:02 +0900 (JST)
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Subject: time_init() enables interrupt.
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com, linux-mips@fnet.fr
X-Mailer: Mew version 1.94.2 on Emacs 20.7 / Mule 4.1 (AOI)
Organization: TOSHIBA Personal Computer System Corporation
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010723191226D.nemoto@toshiba-tops.co.jp>
Date: Mon, 23 Jul 2001 19:12:26 +0900
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

There is conflict in cputype values.

in include/asm-mips/bootinfo.h:

#define CPU_AU1000              37
#define CPU_4KEC                37

---
Atsushi Nemoto
