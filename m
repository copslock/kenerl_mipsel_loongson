Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 20:46:15 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33556 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491816AbZGASqI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Jul 2009 20:46:08 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n61IeRsC024347;
	Wed, 1 Jul 2009 19:40:27 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n61IeRiE024346;
	Wed, 1 Jul 2009 19:40:27 +0100
Date:	Wed, 1 Jul 2009 19:40:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus (v2).
Message-ID: <20090701184027.GC23121@linux-mips.org>
References: <1246294455-26866-1-git-send-email-ddaney@caviumnetworks.com> <20090629193454.GA23430@linux-mips.org> <alpine.LFD.2.00.0907010132500.23134@eddie.linux-mips.org> <4A4AB845.1030906@caviumnetworks.com> <alpine.LFD.2.00.0907010234320.23134@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0907010234320.23134@eddie.linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 01, 2009 at 02:36:31AM +0100, Maciej W. Rozycki wrote:

> > The problem with CPU_MIPS64_R2 in the kernel is that it means two unrelated
> > things:
> > 
> > 1) The cpu can execute all mips64r2 ISA instructions.
> > 
> > 2) The cpu requires that all worse case cache and execution hazards are
> > handled.
> > 
> > In the case of the Octeon processors, #1 is true, but we can get better
> > performance by omitting many of the hazard barriers because they are unneeded.
> 
>  Which is why I think a split of the semantics would be a good idea.

That's the idea since a long time.  There are far less uses of CONFIG_CPU_*
than there used to be historically - and usually they're a bug or at least
should be considered one.

  Ralf
