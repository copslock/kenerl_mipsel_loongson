Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 19:28:20 +0000 (GMT)
Received: from verein.lst.de ([213.95.11.210]:36309 "EHLO verein.lst.de")
	by ftp.linux-mips.org with ESMTP id S22676088AbYJ2T2G (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2008 19:28:06 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id m9TJRvIF002608
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 29 Oct 2008 20:27:57 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id m9TJRuWt002606;
	Wed, 29 Oct 2008 20:27:56 +0100
Date:	Wed, 29 Oct 2008 20:27:56 +0100
From:	Christoph Hellwig <hch@lst.de>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 06/36] Add Cavium OCTEON processor CSR definitions
Message-ID: <20081029192756.GA2449@lst.de>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com> <20081029184552.GB32500@lst.de> <4908B717.3010603@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4908B717.3010603@caviumnetworks.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Wed, Oct 29, 2008 at 12:18:47PM -0700, David Daney wrote:
> Christoph Hellwig wrote:
> >On Mon, Oct 27, 2008 at 05:02:38PM -0700, David Daney wrote:
> >>Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
> >>Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> >>---
> >> .../cavium-octeon/executive/cvmx-csr-addresses.h   | 8391 ++++++
> >> arch/mips/cavium-octeon/executive/cvmx-csr-enums.h |   86 +
> >> .../cavium-octeon/executive/cvmx-csr-typedefs.h    |27517 
> >> ++++++++++++++++++++
> >
> >27517 lines in a header and it's all junk?  
> >
> 
> I'm glad you asked.  No it is not all junk.
> 
> That file contains the bit definitions for all on-chip registers.
> 
> We are interested in transforming this information into a form suitable 
> for inclusion in the kernel.  Any specific suggestions as to improve the 
> patch will be considered.
> 
> Several possibilities are:
> 
> 1) Don't typedef all the unions in  cvmx-csr-typedefs.h.  An rename the 
> file so it doesn't contain the reprehensible word 'typedef'
> 
> 2) Break cvmx-csr-addresses.h and cvmx-csr-typedefs.h into several 
> parts, one for each functional block in the processor.

The two are very good ideas, but not really the important part.

Adding a massive inline for every single bit somewhere in a register
just doesn't make sense.  Take a look at normal hardware defintion
headers in the tree.

Have a simple define for each _register_ (applied relative to a bank/chip
or whatever is appropriate) and if the individual bits in it are
important add bit defintions, too - leaving the arithmetics for it to
the caller.

Also please don't add defintions for those blocks of the chip that
aren't actually used in your submission.  That's best done with one
header per block that can be added with the driver supporting that
block.

And yes, we had this a few times.  Eventually I'll make a fortune
by selling a perl script generating proper headers out of common HDLs..
