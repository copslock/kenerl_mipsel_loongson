Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 12:46:51 +0100 (BST)
Received: from p508B6081.dip.t-dialin.net ([IPv6:::ffff:80.139.96.129]:27361
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225207AbTGaLqt>; Thu, 31 Jul 2003 12:46:49 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h6VBkjx6004210;
	Thu, 31 Jul 2003 13:46:45 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h6VBkda4004209;
	Thu, 31 Jul 2003 13:46:39 +0200
Date: Thu, 31 Jul 2003 13:46:39 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: Re: RM7k cache_flush_sigtramp
Message-ID: <20030731114639.GC2718@linux-mips.org>
References: <3F287738.1040203@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F287738.1040203@ict.ac.cn>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 31, 2003 at 09:56:08AM +0800, Fuxin Zhang wrote:
> Date:	Thu, 31 Jul 2003 09:56:08 +0800
> From:	Fuxin Zhang <fxzhang@ict.ac.cn>
> To:	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
        ^^^^^^^^^^^^^^^^^^^^

Funny name for the list :-)

> r4k_cache_flush_sigtrap seems not enough for RM7000 cpus because
> there is a writebuffer between L1 dcache & L2 cache,so the written back
> block may not be seen by icache. This small patch fixes crashes of my
> Xserver on ev64240.

It would seem a similar fix is also needed in other places then?

  Ralf
