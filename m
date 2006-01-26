Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 00:00:18 +0000 (GMT)
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50130
	"EHLO sunset.davemloft.net") by ftp.linux-mips.org with ESMTP
	id S8133496AbWAZAAB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 00:00:01 +0000
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.60)
	(envelope-from <davem@davemloft.net>)
	id 1F1uct-0004Yq-LX; Wed, 25 Jan 2006 16:04:35 -0800
Date:	Wed, 25 Jan 2006 16:04:30 -0800 (PST)
Message-Id: <20060125.160430.94334986.davem@davemloft.net>
To:	paulus@samba.org
Cc:	mita@miraclelinux.com, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	spyro@f2s.com, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
	gerg@uclinux.org, sparclinux@vger.kernel.org,
	uclinux-v850@lsi.nec.co.jp, torvalds@osdl.org,
	ysato@users.sourceforge.jp, takata@linux-m32r.org,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru,
	rth@twiddle.net, chris@zankel.net, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, ak@suse.de,
	linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
	rmk@arm.linux.org.uk, parisc-linux@parisc-linux.org
Subject: Re: [PATCH 5/6] fix warning on test_ti_thread_flag()
From:	"David S. Miller" <davem@davemloft.net>
In-Reply-To: <17367.64370.844350.972910@cargo.ozlabs.ibm.com>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113446.GF18584@miraclelinux.com>
	<17367.64370.844350.972910@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 26 Jan 2006 09:28:02 +1100

> Akinobu Mita writes:
> 
> > If the arechitecture is
> > - BITS_PER_LONG == 64
> > - struct thread_info.flag 32 is bits
> > - second argument of test_bit() was void *
> > 
> > Then compiler print error message on test_ti_thread_flags()
> > in include/linux/thread_info.h
> 
> And correctly so.  The correct fix is to make thread_info.flag an
> unsigned long.  This patch is NAKed.

I agree.
