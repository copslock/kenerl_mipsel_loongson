Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 14:55:24 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:47044 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023378AbXILNzW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Sep 2007 14:55:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8CDtHnv026066;
	Wed, 12 Sep 2007 14:55:17 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8CDt6g0026052;
	Wed, 12 Sep 2007 14:55:06 +0100
Date:	Wed, 12 Sep 2007 14:55:06 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Matteo Croce <technoboy85@gmail.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	linux-mips@linux-mips.org, florian@openwrt.org, nbd@openwrt.org,
	ejka@imfi.kspu.ru, nico@openwrt.org,
	openwrt-devel@lists.openwrt.org, akpm@linux-foundation.org
Subject: Re: [PATCH][MIPS][1/7] AR7: core support
Message-ID: <20070912135506.GF4571@linux-mips.org>
References: <200709080143.12345.technoboy85@gmail.com> <200709080218.50236.technoboy85@gmail.com> <20070909.024020.61508994.anemo@mba.ocn.ne.jp> <200709120043.43452.technoboy85@gmail.com> <20070912112204.GA7197@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070912112204.GA7197@alpha.franken.de>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 12, 2007 at 01:22:04PM +0200, Thomas Bogendoerfer wrote:

> probably nothing, but having a generic decision whether we need
> a version with j or jr will help other platforms as well. Why make
> AR7 a special case ?

The destination is potencially outside the range of the j instruction.
Which is something that reasonably be expected on other systems as
well.  One scenario for example is having a few k of RAM at phys 0
then the rest starting at 256MB phys.

It's somewhat easier with an ebase register of course but older cores
don't have that.

  Ralf
