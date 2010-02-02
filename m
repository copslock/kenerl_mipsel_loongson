Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 16:04:27 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50297 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492258Ab0BBPEW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2010 16:04:22 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o12F4aRA021380;
        Tue, 2 Feb 2010 16:04:38 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o12F4YLx021362;
        Tue, 2 Feb 2010 16:04:34 +0100
Date:   Tue, 2 Feb 2010 16:04:31 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:     yuasa@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: txx9: remove forced serial console setting
Message-ID: <20100202150415.GA17149@linux-mips.org>
References: <20100202184004.efdff568.yuasa@linux-mips.org>
 <20100202.234150.39158143.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100202.234150.39158143.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 02, 2010 at 11:41:50PM +0900, Atsushi Nemoto wrote:

> On Tue, 2 Feb 2010 18:40:04 +0900, Yoichi Yuasa <yuasa@linux-mips.org> wrote:
> > It is not always used, even if it is available.
> > 
> > Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> > ---
> >  arch/mips/include/asm/txx9/generic.h |    1 -
> >  arch/mips/txx9/generic/setup.c       |    5 -----
> >  arch/mips/txx9/jmr3927/setup.c       |    7 -------
> >  arch/mips/txx9/rbtx4927/setup.c      |    7 -------
> >  arch/mips/txx9/rbtx4938/setup.c      |    6 ------
> >  5 files changed, 0 insertions(+), 26 deletions(-)
> 
> Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Thanks, queued for 2.6.34.

  Ralf
