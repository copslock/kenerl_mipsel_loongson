Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Oct 2006 16:26:49 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:8685 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20039479AbWJWP0q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 23 Oct 2006 16:26:46 +0100
Received: from localhost (p7236-ipad31funabasi.chiba.ocn.ne.jp [221.189.131.236])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 12CB9B421; Tue, 24 Oct 2006 00:26:41 +0900 (JST)
Date:	Tue, 24 Oct 2006 00:29:05 +0900 (JST)
Message-Id: <20061024.002905.75184984.anemo@mba.ocn.ne.jp>
To:	sshtylyov@ru.mvista.com
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org, tglx@linutronix.de,
	johnstul@us.ibm.com
Subject: Re: [PATCH] rest of works for migration to GENERIC_TIME
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <453CB658.9030307@ru.mvista.com>
References: <453BC5B4.50005@ru.mvista.com>
	<20061023.120059.63742109.nemoto@toshiba-tops.co.jp>
	<453CB658.9030307@ru.mvista.com>
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
X-archive-position: 13067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 23 Oct 2006 16:32:24 +0400, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> > This trick is due to range of TRR register.  The width of the counter
> > field is 24bit, but the range is not 0 - 0xffffff.  It wraps at some
> > non-all-F value.  So mips_hpt_mask can not help this.
> 
>     This happens not due to a nature of this timer itself but due to
> the fact that it's used to generate the jiffy interrupt, and
> therefore the comparator register (which is obviously set to
> non-0xFFFFFF value) guiding its behavior.  There's no sense (or even
> need) in using it as a clock source -- TX3927 has 3 timers! So, you
> need to just use some other timer than #0 and set the comparator A
> to 0xFFFFFF for it...
> 
> > But this loop is not correct indeed.  If it called without xtime_lock
> > and interrupt disabled, it would return wrong value.  I should think
> > again ...
> 
>     The whole idea of using such timer as TX39 has for both
> generating the interrupts and as a clocksource was wrong, I'm
> afraid.  You only can use a something similar to the MIPS counter
> which doesn't ever get auto-reloaded for both purposes at once.

Sure, we can do this improvement and it would be a right direction.
But for now I just want to get previous facility back again.  And
anyway I think someone who still have interest on this platform should
make it buildable and bootable before further improvement ;-)

---
Atsushi Nemoto
