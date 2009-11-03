Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 10:36:28 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:40477 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492462AbZKCJgW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 10:36:22 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA39bjv4023602;
	Tue, 3 Nov 2009 10:37:46 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA39bhNF023600;
	Tue, 3 Nov 2009 10:37:43 +0100
Date:	Tue, 3 Nov 2009 10:37:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Make collection of FPU emulator statistics
	optional.
Message-ID: <20091103093743.GA23235@linux-mips.org>
References: <1257207155-14517-1-git-send-email-ddaney@caviumnetworks.com> <20091103093024.GA6425@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091103093024.GA6425@alpha.franken.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 03, 2009 at 10:30:24AM +0100, Thomas Bogendoerfer wrote:

> On Mon, Nov 02, 2009 at 04:12:35PM -0800, David Daney wrote:
> > On SMP systems, the collection of statistics can cause cache line
> > bouncing in the lines associated with the counters.  Make the
> > statistics configurable so this can be avoided.  Also we need to make
> > the counters atomic_t so that they can be reliably modified on SMP
> > systems.
> 
> how about making it a per_cpu thing and avoid the atomic instructions ?

Working on that.  The tricky part is that statistics may end up somewhat
inaccurate when a reader iterates over the per-CPU array of stats to add
them all up.  I've not found a solution for that yet but then again it
should not be something which actually would cause pain.

  Ralf
