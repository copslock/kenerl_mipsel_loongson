Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2009 21:37:16 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:28367 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20808998AbZCEVhM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 5 Mar 2009 21:37:12 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n25LaxP7023892;
	Thu, 5 Mar 2009 22:36:59 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n25Lars9023882;
	Thu, 5 Mar 2009 22:36:53 +0100
Date:	Thu, 5 Mar 2009 22:36:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <20090305213653.GB12355@linux-mips.org>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <alpine.DEB.1.10.0903051530080.6558@tp.orcam.me.uk> <49B004AA.8050006@caviumnetworks.com> <FF038EB85946AA46B18DFEE6E6F8A289BE0DC1@xmb-rtp-218.amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FF038EB85946AA46B18DFEE6E6F8A289BE0DC1@xmb-rtp-218.amer.cisco.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 05, 2009 at 01:23:31PM -0500, David VomLehn (dvomlehn) wrote:

> > >  I do hope it was agreed upon at some point.
> > 
> > As with many things, there was no formal agreement.
> 
> To the best of my knowledge, there is no formal ABI for MIPS Linux,
> period. The closest we have is the MIPS psABI, which documented the o32
> ABI as it stood ten years ago. What we have now does not conform to that
> document in some subtle, but non-trivial, ways. If I'm wrong, I'd love
> to know where I could find documentation.

This is correct.  The documentation situation is a bit chaotic.  ELF was
specified by System V ABI and later by the Tool Interface Standard.  There
is a MIPS psABI to cover the MIPS specifics of the Sys V ABI.  SGI did
some enhancements and came up with their own ELF variant which is
incompatible with ABI ELF in subtle ways.  In addition SGI came up with
the over-engineered NABI (New ABI) variants for N32 and N64 which are
partially documented in antique postscript files floating around on the
net and partially in some IRIX specs on techpubs.sgi.com.  Add the
stillborn EABI and NUBI variants.  Add various Linux and GNU specific
enhancements and deviations from the previously mentioned documents for
example for TLS.  Frequently the documentation really is just in the code,
a mailing list archive or in the back of somebody's brain ...

Somebody could probably earn a medal by writing a single consolidated
and readable piece of documentation.

  Ralf
