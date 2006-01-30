Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 22:59:00 +0000 (GMT)
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62932
	"EHLO sunset.davemloft.net") by ftp.linux-mips.org with ESMTP
	id S8133409AbWA3W6m (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 22:58:42 +0000
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.60)
	(envelope-from <davem@davemloft.net>)
	id 1F3i2m-0004sw-S4; Mon, 30 Jan 2006 15:02:44 -0800
Date:	Mon, 30 Jan 2006 15:02:44 -0800 (PST)
Message-Id: <20060130.150244.81476469.davem@davemloft.net>
To:	sdbrady@ntlworld.com
Cc:	ralf@linux-mips.org, grundler@parisc-linux.org,
	mita@miraclelinux.com, linux-kernel@vger.kernel.org,
	ink@jurassic.park.msu.ru, spyro@f2s.com, dev-etrax@axis.com,
	dhowells@redhat.com, ysato@users.sourceforge.jp, torvalds@osdl.org,
	linux-ia64@vger.kernel.org, takata@linux-m32r.org,
	linux-m68k@vger.kernel.org, gerg@uclinux.org,
	linux-mips@linux-mips.org, parisc-linux@parisc-linux.org,
	linuxppc-dev@ozlabs.org, linux390@de.ibm.com,
	linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	uclinux-v850@lsi.nec.co.jp, ak@suse.de, chris@zankel.net
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of
 include/asm-*/bitops.h
From:	"David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060130195004.GA25860@miranda.arrow>
References: <20060129071242.GA24624@miranda.arrow>
	<20060130170647.GC3816@linux-mips.org>
	<20060130195004.GA25860@miranda.arrow>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Stuart Brady <sdbrady@ntlworld.com>
Date: Mon, 30 Jan 2006 19:50:04 +0000

> Shame about popc on SPARC.  However, ffz is cheese, regardless of pops.
> (On sparc64, ffs is too.)  I'll wait for the generic bitops patches to
> be dealt with (or not) and then submit a patch fixing this if needed.

I'm happy with any improvement you might make here, for sure.

The sparc64 ffz() implementation was done so dog stupid like that
so that the code would be small since this gets inlined all over
the place.

So if you can keep it small and improve it, or make it a bit larger
and uninline it, that's great.
