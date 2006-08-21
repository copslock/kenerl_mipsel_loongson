Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Aug 2006 16:02:31 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:3999 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20037551AbWHUPC3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 21 Aug 2006 16:02:29 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7LF2kFZ019584;
	Mon, 21 Aug 2006 16:02:46 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7LF2kKI019583;
	Mon, 21 Aug 2006 16:02:46 +0100
Date:	Mon, 21 Aug 2006 16:02:46 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, macro@linux-mips.org,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] qemu does not have dcache aliases
Message-ID: <20060821150245.GA18963@linux-mips.org>
References: <20060820.003338.25478178.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0608211340120.17504@blysk.ds.pg.gda.pl> <20060821.225910.108307053.anemo@mba.ocn.ne.jp> <20060821144605.GA19032@linux-mips.org> <Pine.LNX.4.62.0608211651010.6328@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0608211651010.6328@pademelon.sonytel.be>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12382
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 21, 2006 at 04:51:40PM +0200, Geert Uytterhoeven wrote:

> Or become fully configurable, to make it match every single MIPS core ever
> build?

I imagine a special debug CPU type that throws exception when particular
problems such as cache aliases, stale I-cache lines, back-to-back cp0
operations and other dangerous or suspisious instructions are detected
or more complex and detailed profiling that a processor can offer.

  Ralf
