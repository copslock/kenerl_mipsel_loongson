Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2003 04:27:33 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:12558
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225348AbTISD1b>; Fri, 19 Sep 2003 04:27:31 +0100
Received: from no.name.available by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 19 Sep 2003 03:27:29 UT
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.9/8.12.9) with ESMTP id h8J3REgc078367;
	Fri, 19 Sep 2003 12:27:15 +0900 (JST)
	(envelope-from nemoto@toshiba-tops.co.jp)
Date: Fri, 19 Sep 2003 12:29:40 +0900 (JST)
Message-Id: <20030919.122940.45519247.nemoto@toshiba-tops.co.jp>
To: echristo@redhat.com
Cc: dan@debian.org, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: recent binutils and mips64-linux
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <1063940280.2423.13.camel@ghostwheel.sfbay.redhat.com>
References: <20030918212727.GA24686@nevyn.them.org>
	<1063940280.2423.13.camel@ghostwheel.sfbay.redhat.com>
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
X-archive-position: 3219
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nemoto@toshiba-tops.co.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Thu, 18 Sep 2003 19:58:00 -0700, Eric Christopher <echristo@redhat.com> said:
echristo> mips-linux-gcc -mabi=32 -march=64bitarch is my suggestion.

But mips64 kernel assumes that the kernel itself is compiled with
"-mabi=64".  For example, some asm routines pass more than 4 arguments
via aN registers.

---
Atsushi Nemoto
