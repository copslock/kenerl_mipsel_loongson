Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAL7EJ404616
	for linux-mips-outgoing; Tue, 20 Nov 2001 23:14:19 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAL7E6o04613;
	Tue, 20 Nov 2001 23:14:08 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 21 Nov 2001 06:14:05 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id D5E47B46B; Wed, 21 Nov 2001 15:14:03 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id PAA04964; Wed, 21 Nov 2001 15:14:03 +0900 (JST)
Date: Wed, 21 Nov 2001 15:18:48 +0900 (JST)
Message-Id: <20011121.151848.18315322.nemoto@toshiba-tops.co.jp>
To: linux-mips@oss.sgi.com
Cc: ralf@oss.sgi.com
Subject: latest checksum.h
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Is it something wrong in latest checksum.h?

a __asm__ statement in csum_fold() has two "r" operands but there are
no "%1" in the assembler template.  Is this OK?

# No patch because I'm not a __asm__ hacker :-)
---
Atsushi Nemoto
