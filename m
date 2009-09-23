Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Sep 2009 23:22:57 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37645 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493518AbZIWVWt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Sep 2009 23:22:49 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8NLO1eo023167;
	Wed, 23 Sep 2009 22:24:01 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8NLO1Yt023165;
	Wed, 23 Sep 2009 22:24:01 +0100
Date:	Wed, 23 Sep 2009 22:24:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mark E Mason <mason@broadcom.com>
Cc:	Mark Mason <mmason@upwardaccess.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] When complaining about attempting to set the irq
	affinity to multiple cpus,
Message-ID: <20090923212401.GB22516@linux-mips.org>
References: <1253567604-6734-1-git-send-email-mmason@upwardaccess.com> <20090923205004.GA21971@linux-mips.org> <BD3F7F1EFBA6D54DB056C4FFA4514008037D6641C8@SJEXCHCCR01.corp.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD3F7F1EFBA6D54DB056C4FFA4514008037D6641C8@SJEXCHCCR01.corp.ad.broadcom.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 23, 2009 at 02:09:34PM -0700, Mark E Mason wrote:

> Did we ever figure out why the kernel was attempting to set the affinity to more than one CPU? The hardware certainly supports doing that (but we're not at the moment).

The hardware semantics is a bit ususual.  On Sibyte the hardware will
route an interrupt to all CPUs set in the affinity mask.  On most other
systems that I'm aware of it will route the interrupt to only one of
CPUs selected by irq_chip->set_affinity().  We don't want such an
stampede so the Sibyte interrupt code clears all but the lowest set
bit from the set_affinity() argument.  Either way, attempting to set
the mask to an arbitrary non-empty set is entirely legal so the warning
itself was a bug and the volume potencially made them a real problem for
a few users.

  Ralf
