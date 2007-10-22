Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Oct 2007 18:33:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:12260 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025782AbXJVRdd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 22 Oct 2007 18:33:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9MHW9hI004677;
	Mon, 22 Oct 2007 18:32:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9MHW8Be004676;
	Mon, 22 Oct 2007 18:32:08 +0100
Date:	Mon, 22 Oct 2007 18:32:08 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] add GT641xx timer0 clockevent
Message-ID: <20071022173208.GA29726@linux-mips.org>
References: <20071022194315.f75738ba.yoichi_yuasa@tripeaks.co.jp> <20071022121451.GA31041@linux-mips.org> <Pine.LNX.4.64N.0710221605380.988@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710221605380.988@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 22, 2007 at 04:06:55PM +0100, Maciej W. Rozycki wrote:

> > > Add GT641xx timer0 clockevent.
> > 
> > Thanks, applied.
> 
>  Ah, we could use this one with the Malta and some CoreLV cards too. ;-)

We could.  The other question is of course if it is a good idea.  It isn't
always, there might be a better timer available.

Honestly, no idea about the Cobalt.  Afair the compare interrupt was usable
there so cevt-gt641xx.c isn't necessarily needed or a good idea there.
Too long :-)

  Ralf
