Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAR4xTI06050
	for linux-mips-outgoing; Mon, 26 Nov 2001 20:59:29 -0800
Received: from topsns.toshiba-tops.co.jp (topsns.toshiba-tops.co.jp [202.230.225.5])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAR4xNo06047;
	Mon, 26 Nov 2001 20:59:23 -0800
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for oss.sgi.com [216.32.174.27]) with SMTP; 27 Nov 2001 03:59:23 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 17327B474; Tue, 27 Nov 2001 12:59:21 +0900 (JST)
Received: by srd2sd.toshiba-tops.co.jp (8.9.3/3.5Wbeta-srd2sd) with ESMTP
	id MAA21874; Tue, 27 Nov 2001 12:59:20 +0900 (JST)
Date: Tue, 27 Nov 2001 13:04:06 +0900 (JST)
Message-Id: <20011127.130406.104026562.nemoto@toshiba-tops.co.jp>
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
Subject: Re: new asm-mips/io.h
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20011126200946.A8408@dea.linux-mips.net>
References: <20011126.123545.41627333.nemoto@toshiba-tops.co.jp>
	<20011126200946.A8408@dea.linux-mips.net>
X-Fingerprint: EC 9D B9 17 2E 89 D2 25  CE F5 5D 3D 12 29 2A AD
X-Pgp-Public-Key: http://pgp.nic.ad.jp/cgi-bin/pgpsearchkey.pl?op=get&search=0xB6D728B1
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.1 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>>>>> On Mon, 26 Nov 2001 20:09:46 +1100, Ralf Baechle <ralf@oss.sgi.com> said:
>> By the way, I have some boards which require special I/O routines.
>> Some of these boards need byteswap on PCI I/O region but noswap on
>> ISA region.  And some of these boards do not require byteswap but
>> need swap the address ('port' values).  I added following codes to
>> support these boards.  Is it worth to apply?

ralf> Not as is - the kernel has changed, so your patch wouldn't apply
ralf> anymore.

Yes, I had not noticed that changes.  Thank you.

ralf> Aside of that I don't think we'll have any alternative to do
ralf> something along the lines of your patch.  There are for example
ralf> systems where the high 8 bits of the I/O or memory address on
ralf> the ISA bus are supplied in a separate register of the chipset,
ralf> not as part of the memory address itself.  It's really
ralf> remarkable how much bad taste some hardware designers have ...

So, what should we do for these tasteless hardware?  Is there any
suggestions? (please don't say "Do not eat" ...)

---
Atsushi Nemoto
