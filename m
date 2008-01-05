Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jan 2008 14:40:43 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:25043 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20030589AbYAEOke (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 5 Jan 2008 14:40:34 +0000
Received: from localhost (p8226-ipad401funabasi.chiba.ocn.ne.jp [123.217.242.226])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id CAF8C990D; Sat,  5 Jan 2008 23:40:28 +0900 (JST)
Date:	Sat, 05 Jan 2008 23:42:56 +0900 (JST)
Message-Id: <20080105.234256.25910407.anemo@mba.ocn.ne.jp>
To:	gregor.waltz@raritan.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <477EB2EA.7060009@raritan.com>
References: <477E7DAE.2080005@raritan.com>
	<20080104192310.GE22809@networkno.de>
	<477EB2EA.7060009@raritan.com>
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
X-archive-position: 17925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 04 Jan 2008 17:27:54 -0500, Gregor Waltz <gregor.waltz@raritan.com> wrote:
> Our 2.4.12 kernel uses -mcpu=r3000 -mips1 to build the kernel. I tried 
> switching the arch to r3000 from r3900 in 2.6.23.9, but that did not 
> help. Perhaps -mips1 or an equivalent could help? I will try on Monday.

I think both mcpu=r3000 and r3900 should work.  But I believe at least
one kernel patch is required for all MIPS I platforms including JMR3927.

http://www.linux-mips.org/archives/linux-mips/2007-02/msg00320.html

---
Atsushi Nemoto
