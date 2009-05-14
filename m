Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 May 2009 14:48:45 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57222 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024098AbZENNsi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 May 2009 14:48:38 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4EDmJK0006912;
	Thu, 14 May 2009 14:48:20 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4EDmHxo006910;
	Thu, 14 May 2009 14:48:17 +0100
Date:	Thu, 14 May 2009 14:48:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] SIBYTE: fix locking in set_irq_affinity
Message-ID: <20090514134817.GC10020@linux-mips.org>
References: <20090504215155.461B2E31C1@solo.franken.de> <20090512215556.GA4774@deprecation.cyrius.com> <20090514132030.GA7926@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090514132030.GA7926@alpha.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 14, 2009 at 03:20:30PM +0200, Thomas Bogendoerfer wrote:

> > [17179570.260000] attempted to set irq affinity for irq 8 to multiple CPUs
> > [17179570.484000] attempted to set irq affinity for irq 8 to multiple CPUs
> > [17179570.500000] attempted to set irq affinity for irq 8 to multiple CPUs
> 
> I saw them as well, either the caller of set_irq_affinity does something
> illegal or the API has changed and the message just should go away...

Several things here:

- I would be interested in the caller of set_irq_affinity here.  It seems
  like the IDE code is doing this - but why?
- the message should go away or at least be changed depend on DEBUG being
  defined.  Normal usage errors should not result in error messages to the
  console.  Heck, the kernel console is not stderr.
- the kernel's idea of interrupt mask is a different one from the hardware.
  In the kernel it is the set of CPUs one of which should process an
  interrupt.  The Sibyte hardware interprets it as the set of CPUs which
  (all!) will receive the interrupt to process.

  Ralf
