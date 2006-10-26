Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Oct 2006 15:14:25 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:50642 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038512AbWJZOOU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Oct 2006 15:14:20 +0100
Received: from localhost (p7132-ipad209funabasi.chiba.ocn.ne.jp [58.88.118.132])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id A644CB7AB; Thu, 26 Oct 2006 23:14:15 +0900 (JST)
Date:	Thu, 26 Oct 2006 23:16:42 +0900 (JST)
Message-Id: <20061026.231642.126142599.anemo@mba.ocn.ne.jp>
To:	m_lachwani@yahoo.com
Cc:	creideiki+linux-mips@ferretporn.se, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: Extreme system overhead on large IP27
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20061026074216.68000.qmail@web37504.mail.mud.yahoo.com>
References: <20061026.130552.11963152.nemoto@toshiba-tops.co.jp>
	<20061026074216.68000.qmail@web37504.mail.mud.yahoo.com>
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
X-archive-position: 13103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 26 Oct 2006 00:42:16 -0700 (PDT), Manish Lachwani <m_lachwani@yahoo.com> wrote:
> It could be that I am seeing a similar issue on the
> SWARM board (sb1250) as well. Your patch removed the
> shifts for mip_hpt_frequency from
> arch/mips/sibyte/sb1250/time.c and in the
> sb1250_hpt_read(). The Sibyte HPT is 1 Mhz. However,
> when I added those shifts back, I did not see any
> issues with the system clock. I could possibly try out
> your patch with lower clocksource shift values and see
> if the system clock is still wrong.

I just sent the patch.  Please try it.

> Btw, the clocksource changes seem to work well on the
> BCM 1480 based board. 

Thanks, good news!

As Ralf pointed out, current code still problematic on some SMP
system, but I think IP27, SB1250, BCM1480 should be OK now while their
mips_hpt_read are not using per-CPU cp0 timers.

---
Atsushi Nemoto
