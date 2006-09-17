Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2006 14:43:33 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:46031 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037619AbWIQNnb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 17 Sep 2006 14:43:31 +0100
Received: from localhost (p8015-ipad204funabasi.chiba.ocn.ne.jp [222.146.95.15])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 5CD58A6B3; Sun, 17 Sep 2006 22:43:26 +0900 (JST)
Date:	Sun, 17 Sep 2006 22:45:28 +0900 (JST)
Message-Id: <20060917.224528.93022156.anemo@mba.ocn.ne.jp>
To:	imipak@yahoo.com
Cc:	linux-mips@linux-mips.org
Subject: Re: Kernel debugging contd.
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060915221141.69174.qmail@web31504.mail.mud.yahoo.com>
References: <20060915221141.69174.qmail@web31504.mail.mud.yahoo.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 15 Sep 2006 15:11:40 -0700 (PDT), Jonathan Day <imipak@yahoo.com> wrote:
> Ok, here's the console output with virtually every
> Linux debug option I could find enabled. It softlocks
> (no console activity, but kernel pings) after freeing
> memory. Any thoughts on using the magic key over
> minicom would also be welcome. The thing that stands
> out the most is line 864000, where we have an IRQ
> handler mismatch and a call trace.

I suppose the "IRQ handler mismatch" happened just because you enabled
wrong rtc driver(s).  It would be irrelevant.

In general, softlock just after "Freeing unused kernel memory" can
happen because /sbin/init crashed for some reason (kernel keep sending
signals to /sbin/init).

1. Enable second and third "#if 0" blocks in arch/mips/mm/fault.c
2. Add printk() before each force_sig() in arch/mips/kernel/traps.c,
   branch.c, unaligned.c

might show you what's going on.

Also, SYSRQ-p or SYSRQ-t (BRK + p or BRK + t for serial console) might
be helpful, but it seems UART driver of your target board does not
support the MAGIC_SYSRQ feature...

---
Atsushi Nemoto
