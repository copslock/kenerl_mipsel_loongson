Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Oct 2004 16:42:05 +0100 (BST)
Received: from p508B7FD9.dip.t-dialin.net ([IPv6:::ffff:80.139.127.217]:62
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225281AbUJXPmB>; Sun, 24 Oct 2004 16:42:01 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9OFfx4o013590;
	Sun, 24 Oct 2004 17:41:59 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9OFfnDr013572;
	Sun, 24 Oct 2004 17:41:49 +0200
Date: Sun, 24 Oct 2004 17:41:49 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: mlachwani@mvista.com, linux-mips@linux-mips.org
Subject: Re: [PATCH]Preemption patch for 2.6
Message-ID: <20041024154149.GC30735@linux-mips.org>
References: <1098468403.4266.42.camel@prometheus.mvista.com> <20041025.002850.74755987.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025.002850.74755987.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 25, 2004 at 12:28:50AM +0900, Atsushi Nemoto wrote:

> mlachwani> The attached patch incorporates preemption enable/disable
> mlachwani> in some parts of the kernel. I have tested this on the
> mlachwani> Broadcom Sibyte. Please review ...
> 
> 1. You add preempt_disable/preempt_enable to c-sb1.c and tlb-sb1.c.
>    Those are SB1 specific issue?  If not, please fix other c-*.c and
>    tlb-*.c same way.

This an SMP issue and only affects the SB1 code.

The other CPU for which CVS supports SMP is the R10000 family; thanks to
having nice caches it's immune mostly immune to this kind of issue.

  Ralf
