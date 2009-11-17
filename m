Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2009 00:22:00 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40025 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493922AbZKQXV5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Nov 2009 00:21:57 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAHNM66w008277;
	Wed, 18 Nov 2009 00:22:06 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAHNM5GN008275;
	Wed, 18 Nov 2009 00:22:05 +0100
Date:	Wed, 18 Nov 2009 00:22:05 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Gleixner <tglx@linutronix.de>
Cc:	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	linux-mips@linux-mips.org
Subject: Re: [patch 08/13] mips: Fixup last users of irq_chip->typename
Message-ID: <20091117232205.GB1866@linux-mips.org>
References: <20091117224852.846805939@linutronix.de> <20091117224916.642102675@linutronix.de> <20091117230544.GA1866@linux-mips.org> <alpine.LFD.2.00.0911180007340.24119@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0911180007340.24119@localhost.localdomain>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 18, 2009 at 12:09:19AM +0100, Thomas Gleixner wrote:

> > > The typename member of struct irq_chip was kept for migration purposes
> > > and is obsolete since more than 2 years. Fix up the leftovers.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ralf Baechle <ralf@linux-mips.org>
> > > Cc: linux-mips@linux-mips.org
> > 
> > Looks good.  I assume you want to merge the whole series via tip, so
> > 
> > Acked-by: Ralf Baechle <ralf@linux-mips.org>
> 
> You can pick it up as well. The patches are independent, just the last
> one which removes typename from irq_chip depends on the arch patches
> being merged. Either way works fine.

Okay, queued for 2.6.33 then.

Thanks!

  Ralf
