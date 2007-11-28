Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2007 14:48:20 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:22694 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025720AbXK1OsR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Nov 2007 14:48:17 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lASEmF2L002893;
	Wed, 28 Nov 2007 14:48:15 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lASEmE8V002866;
	Wed, 28 Nov 2007 14:48:14 GMT
Date:	Wed, 28 Nov 2007 14:48:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	tsbogend@alpha.franken.de, linux-mips@linux-mips.org
Subject: Re: [PATCH] IP28: added cache barrier to assembly routines
Message-ID: <20071128144814.GA29715@linux-mips.org>
References: <20071126223955.9BAAAC2B26@solo.franken.de> <20071128.234142.106261815.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071128.234142.106261815.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 28, 2007 at 11:41:42PM +0900, Atsushi Nemoto wrote:

> On Sun, 25 Nov 2007 11:47:56 +0100, Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> > IP28 needs special treatment to avoid speculative accesses. gcc
> > takes care for .c code, but for assembly code we need to do it
> > manually.
> > 
> > This is taken from Peter Fuersts IP28 patches.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > ---
> >  arch/mips/lib/memcpy.S       |   10 ++++++++++
> >  arch/mips/lib/memset.S       |    5 +++++
> >  arch/mips/lib/strncpy_user.S |    1 +
> >  include/asm-mips/asm.h       |    8 ++++++++
> >  4 files changed, 24 insertions(+), 0 deletions(-)
> 
> I do not know details of this patch at all, but in general,
> memcpy-inatomic.S and csum_pertial.S are candidates if you changed
> memcpy.S.

tlbex.c may also need modifications.

  Ralf
