Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2003 02:16:36 +0100 (BST)
Received: from p508B6792.dip.t-dialin.net ([IPv6:::ffff:80.139.103.146]:18666
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225072AbTDIBQf>; Wed, 9 Apr 2003 02:16:35 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h391GVD12954;
	Wed, 9 Apr 2003 03:16:31 +0200
Date: Wed, 9 Apr 2003 03:16:31 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Hartvig Ekner <hartvig@ekner.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: Patch to include/asm-mips/processor.h
Message-ID: <20030409031631.A12708@linux-mips.org>
References: <3E917AA1.13694D03@ekner.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E917AA1.13694D03@ekner.info>; from hartvig@ekner.info on Mon, Apr 07, 2003 at 03:18:25PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 07, 2003 at 03:18:25PM +0200, Hartvig Ekner wrote:

> I have no idea whether what I did was correct, but at least it is no less incorrect than the code currently
> in there, which coredumps now for some reason (I wonder why it never crashed before). The test-bit macro
> expects a bit-number, and not a mask which it is given in the current code.
> 
> So while fixing this, I also used the normal cpu_data macro for the cpu_has_watch() macro, instead of
> looking at CPU(0).

The plan was to make the options field a bitfield like on i386 but I
changed my mind because we still have plenty of unused bits left.  I've
put a fix into CVS.  The patch also replaces all the manual bit tests
of the options field with feature test macros.

  Ralf
