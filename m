Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 12:56:18 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33929 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492988AbZKWL4K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 12:56:10 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nANBuKmQ004644;
	Mon, 23 Nov 2009 11:56:20 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nANBuJ7l004641;
	Mon, 23 Nov 2009 11:56:19 GMT
Date:	Mon, 23 Nov 2009 11:56:19 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mikael Starvik <mikael.starvik@axis.com>
Cc:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	David Daney <ddaney@caviumnetworks.com>
Subject: Re: COP2 unaligned -> SIGBUS
Message-ID: <20091123115619.GB4217@linux-mips.org>
References: <4BEA3FF3CAA35E408EA55C7BE2E61D0546A5E6F9DC@xmail3.se.axis.com> <20091123113820.GA4217@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091123113820.GA4217@linux-mips.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 23, 2009 at 11:38:20AM +0000, Ralf Baechle wrote:

> > Since there are now at least two users of cop2 I propose the following:
> 
> Yes, the comment is not quite correct.  CP2 has always been available for
> application specific extensions and a few imlementations have made use of
> that.  I'll update the comment.  Oh and the Praystation has a TLB.

On 2nd thought - there is one user of CU2 in the kernel - the Cavium support.

Nothing else in the stock Linux/MIPS kernel will ever enable c0_status.cu2,
so the attempt to execute a CP2 load or store instruction would result in a
Coprocessor Unusable exception which whould result in a SIGILL being
delivered to the offending process.  On Cavium the instructions COP2 is
documented to not deliver any exceptions so there isn't really anything
that would need to be changed.

David - I think we should try to get rid of the processor specifics from
this core code so probably having notifiers to run on Address Error or
Coprocessor Unusable exceptions would be a solution?  I also want to get
rid of the Cavium #ifdef from traps.c.

  Ralf
