Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jan 2008 13:51:04 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:3048 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28577861AbYA2Nuz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jan 2008 13:50:55 +0000
Received: from localhost (p2059-ipad206funabasi.chiba.ocn.ne.jp [222.145.76.59])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C050DA265; Tue, 29 Jan 2008 22:50:49 +0900 (JST)
Date:	Tue, 29 Jan 2008 22:50:56 +0900 (JST)
Message-Id: <20080129.225056.104639500.anemo@mba.ocn.ne.jp>
To:	gregor.waltz@raritan.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <479E0488.7070408@raritan.com>
References: <479A134D.7090206@ucsd.edu>
	<20080126.140802.126142689.anemo@mba.ocn.ne.jp>
	<479E0488.7070408@raritan.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 28 Jan 2008 11:36:24 -0500, Gregor Waltz <gregor.waltz@raritan.com> wrote:
> The change does appear to work for me also, however, I still see no 
> kernel messages at all. The only way that I can get any output is via 
> puts() and prom_putchar() (the latter I put into emit_log_char(char c) 
> of printk.c).

If you were using ttyS1, did you try CONFIG_SERIAL_TXX9_STDSERIAL=y ?

Also, as http://www.linux-mips.org/wiki/JMR-TX3927 said, PCI support
is broken...

---
Atsushi Nemoto
