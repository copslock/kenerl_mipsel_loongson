Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Feb 2003 12:58:06 +0000 (GMT)
Received: from p508B7B46.dip.t-dialin.net ([IPv6:::ffff:80.139.123.70]:52695
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225073AbTB1M6F>; Fri, 28 Feb 2003 12:58:05 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h1SCvmJ07668;
	Fri, 28 Feb 2003 13:57:48 +0100
Date: Fri, 28 Feb 2003 13:57:48 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Dominic Sweetman <dom@mips.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Mike Uhler <uhler@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Nigel Stephens <nigel@mips.com>
Subject: Re: The MIPS' statement on R_MIPS_PC16 relocations
Message-ID: <20030228135748.A7285@linux-mips.org>
References: <Pine.GSO.3.96.1030227130833.19733D-100000@delta.ds2.pg.gda.pl> <15967.10141.166760.373070@arsenal.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15967.10141.166760.373070@arsenal.mips.com>; from dom@mips.com on Fri, Feb 28, 2003 at 09:10:53AM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1589
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 28, 2003 at 09:10:53AM +0000, Dominic Sweetman wrote:

> The existing definition is nonsense - I won't guess how it happened,
> but there's no reason to keep it.  Thiemo has MIPS Technologies'
> thanks and blessing in making this change.  Please let our Nigel
> Stephens know when it's done (mailto:nigel@mips.com) and he'll
> double-check it.
> 
> I'm sure you'll put comments in the code noting that this is different
> from the document.
> 
> There's a more tricky question, which is how we're going to document
> this.  I'm currently trying to create a more user-friendly (and
> accurate) ABI document, but had not yet got to the relocation types...

I think for the moment all typo fixed version of the old ABI document would
already be great - and producable at minimal effort.

In the longer run I'd be happy to see the 32-bit and 64-bit ABI documents
unified as it was already happening on www.mipsabi.org when the site and
the MIPS ABI group was shutdown; I think I did save the few bits I was
able to save.

Btw - www.mipsabi.org is on air again.  But this time it's a porn site.  I
may be tolerant but imho that's really a trademark case for the lawyers.

  Ralf
