Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fARB75L13475
	for linux-mips-outgoing; Tue, 27 Nov 2001 03:07:05 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fARB5eo13385;
	Tue, 27 Nov 2001 03:05:40 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 27 Nov 2001 10:05:39 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 43500B474; Tue, 27 Nov 2001 19:05:38 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id TAA22852; Tue, 27 Nov 2001 19:05:38 +0900 (JST)
Date: Tue, 27 Nov 2001 19:10:22 +0900 (JST)
Message-Id: <20011127.191022.27957874.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: Re: new asm-mips/io.h
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011127180648.H29424@dea.linux-mips.net>
References: <20011126200946.A8408@dea.linux-mips.net>
	<20011127.130406.104026562.nemoto@toshiba-tops.co.jp>
	<20011127180648.H29424@dea.linux-mips.net>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Tue, 27 Nov 2001 18:06:48 +1100, Ralf Baechle <ralf@oss.sgi.com> said:
ralf> Well, talk to it's developers before it's too late.  Or as it
ralf> has already happened for some hardware I think we should simply
ralf> go with your suggestion and make all those functions vectors.

For me, currently it happens only in big endian and I can live happy
in a little endian world.  I will create new patch when I REALLY need
it.  Thank you.

---
Atsushi Nemoto
