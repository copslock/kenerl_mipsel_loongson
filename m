Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2009 21:53:30 +0000 (GMT)
Received: from mail.codesourcery.com ([65.74.133.4]:36538 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S21366316AbZCEVxW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Mar 2009 21:53:22 +0000
Received: (qmail 10224 invoked from network); 5 Mar 2009 21:53:19 -0000
Received: from unknown (HELO digraph.polyomino.org.uk) (joseph@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 5 Mar 2009 21:53:19 -0000
Received: from jsm28 (helo=localhost)
	by digraph.polyomino.org.uk with local-esmtp (Exim 4.69)
	(envelope-from <joseph@codesourcery.com>)
	id 1LfLVG-0003aR-MS; Thu, 05 Mar 2009 21:53:18 +0000
Date:	Thu, 5 Mar 2009 21:53:18 +0000 (UTC)
From:	"Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
	David Daney <ddaney@caviumnetworks.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
In-Reply-To: <20090305213653.GB12355@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0903052148500.12710@digraph.polyomino.org.uk>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk>
 <49AD6139.60209@caviumnetworks.com> <alpine.DEB.1.10.0903051530080.6558@tp.orcam.me.uk>
 <49B004AA.8050006@caviumnetworks.com> <FF038EB85946AA46B18DFEE6E6F8A289BE0DC1@xmb-rtp-218.amer.cisco.com>
 <20090305213653.GB12355@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <joseph@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
Precedence: bulk
X-list: linux-mips

On Thu, 5 Mar 2009, Ralf Baechle wrote:

> stillborn EABI and NUBI variants.  Add various Linux and GNU specific
> enhancements and deviations from the previously mentioned documents for
> example for TLS.  Frequently the documentation really is just in the code,
> a mailing list archive or in the back of somebody's brain ...

(Although it took a while for the documentation to catch up with the 
implementation and changes made in the course of patch review, as far as I 
know <http://www.linux-mips.org/wiki/NPTL> is now an accurate description 
of TLS for MIPS.)

> Somebody could probably earn a medal by writing a single consolidated
> and readable piece of documentation.

Anyone seriously wishing to produce a complete and current and 
copyright-clean description of what the MIPS ABIs now are might wish to 
note that a similar project for (32-bit) Power Architecture has been going 
on since late 2006 and we still haven't quite got to the point of 
releasing a public review draft.  There is a lot of work involved.

-- 
Joseph S. Myers
joseph@codesourcery.com
