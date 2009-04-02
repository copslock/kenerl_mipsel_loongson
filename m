Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 14:29:53 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:25231 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20046110AbZDBN3t (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2009 14:29:49 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n32DTepW015368;
	Thu, 2 Apr 2009 15:29:41 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n32DTakG015366;
	Thu, 2 Apr 2009 15:29:36 +0200
Date:	Thu, 2 Apr 2009 15:29:36 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	Daniel Jacobowitz <dan@debian.org>,
	Brian Foster <brian.foster@innova-card.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <20090402132936.GB15021@linux-mips.org>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <200903040919.29294.brian.foster@innova-card.com> <20090304121732.GA28381@caradoc.them.org> <49AEAE1D.5030205@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49AEAE1D.5030205@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 04, 2009 at 08:36:45AM -0800, David Daney wrote:

>> That won't quite retain the ABI: you need to make sure everyone
>> locates it by using the stack pointer instead of the return pc.
>> Fortunately, GCC uses the return PC only for instruction matching
>> today.  I have a vague memory it used to use the stack pointer but
>> this was more reliable.
>
> That is correct.  Due to various errata the trampoline cannot always be  
> at a fixed offset to the signal context bits.  So we had to use the  
> return PC as you indicate.

To maintaine compatibility with old debuggers and possibly other software
that knows about the stackframe layout I wrote the signal code to only
use the larger alignment of the stackframe if a particular processor
requires it.

However one possible improvment would be to change the way a struct sigframe
or rt_sigframe is allocated on the stack such that not the beginning of
the structure is aligned but the rs_code field is kept aligned.  Would
such a change cause problems for gdb?

  Ralf
