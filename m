Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2003 01:10:26 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:27146
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225383AbTK0BKN>; Thu, 27 Nov 2003 01:10:13 +0000
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 27 Nov 2003 01:10:42 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id hAR1AOnd017384;
	Thu, 27 Nov 2003 10:10:24 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Thu, 27 Nov 2003 10:13:15 +0900 (JST)
Message-Id: <20031127.101315.74756138.nemoto@toshiba-tops.co.jp>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] TX49Lx support
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20031126155345.GA10842@linux-mips.org>
References: <20031126.150719.104026850.nemoto@toshiba-tops.co.jp>
	<20031126155345.GA10842@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <nemoto@toshiba-tops.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 26 Nov 2003 16:53:45 +0100, Ralf Baechle <ralf@linux-mips.org> said:
ralf> In general I'd like to ask people to send patches for 2.4 and
ralf> 2.6 in separate email.

Please forgive my laziness.  I will do so next time.

ralf> I applied your patch with a little change for clarity; I also
ralf> restructured the 64-bit cpu-probe.c the same way as it's 32-bit
ralf> counterpart to keep the two files more similar.

Thanks for your quick response.

---
Atsushi Nemoto
