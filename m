Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Oct 2009 18:59:56 +0200 (CEST)
Received: from mba.ocn.ne.jp ([122.28.14.163]:55333 "HELO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with SMTP
	id S1492766AbZJKQ7t (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Oct 2009 18:59:49 +0200
Received: from localhost (p4056-ipad209funabasi.chiba.ocn.ne.jp [58.88.115.56])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 0FAD166F0; Mon, 12 Oct 2009 01:59:38 +0900 (JST)
Date:	Mon, 12 Oct 2009 01:59:39 +0900 (JST)
Message-Id: <20091012.015939.165860325.anemo@mba.ocn.ne.jp>
To:	wuzhangjin@gmail.com
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	linux-pm@lists.linux-foundation.org, ralf@linux-mips.org,
	rjw@sisk.pl, yuasa@linux-mips.org
Subject: Re: [PATCH -v1] MIPS: add IRQF_TIMER flag for Timer Interrupts
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1255103450-12537-1-git-send-email-wuzhangjin@gmail.com>
References: <1255103450-12537-1-git-send-email-wuzhangjin@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri,  9 Oct 2009 23:50:50 +0800, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> This patch add IRQF_TIMER flag for all Timer interrupts in linux-MIPS,
> which will help to not disable the Timer IRQ when suspending to ensure
> resuming normally(d6c585a4342a2ff627a29f9aea77c5ed4cd76023) and not
> thread them when enabled PREEMPT_RT.
> 
> NOTE: Perhaps there are also some board-specific Timer interrupts
> missing here!
> 
> (This -v1 version Incorporated the feedback from Atsushi Nemoto
>  <anemo@mba.ocn.ne.jp>.)
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> ---
>  arch/mips/jazz/irq.c                |    2 +-
>  arch/mips/kernel/cevt-bcm1480.c     |    2 +-
>  arch/mips/kernel/cevt-ds1287.c      |    2 +-
>  arch/mips/kernel/cevt-gt641xx.c     |    2 +-
>  arch/mips/kernel/cevt-r4k.c         |    2 +-
>  arch/mips/kernel/cevt-sb1250.c      |    2 +-
>  arch/mips/kernel/cevt-txx9.c        |    2 +-
>  arch/mips/kernel/i8253.c            |    2 +-
>  arch/mips/nxp/pnx8550/common/int.c  |    2 +-
>  arch/mips/nxp/pnx8550/common/time.c |    4 ++--
>  arch/mips/sgi-ip27/ip27-timer.c     |    2 +-
>  arch/mips/sni/time.c                |    2 +-
>  12 files changed, 13 insertions(+), 13 deletions(-)

Thank you.

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

---
Atsushi Nemoto
