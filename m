Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jun 2005 01:15:39 +0100 (BST)
Received: from swordfish.cs.caltech.edu ([IPv6:::ffff:131.215.44.124]:50881
	"EHLO swordfish.cs.caltech.edu") by linux-mips.org with ESMTP
	id <S8225551AbVF2APW>; Wed, 29 Jun 2005 01:15:22 +0100
Received: from orchestra.cs.caltech.edu (orchestra.cs.caltech.edu [131.215.44.20])
	by swordfish.cs.caltech.edu (Postfix) with ESMTP
	id BA3FCDF329; Tue, 28 Jun 2005 17:14:56 -0700 (PDT)
Received: by orchestra.cs.caltech.edu (Postfix, from userid 20310)
	id BE4BC1880C5; Tue, 28 Jun 2005 17:14:52 -0700 (PDT)
Date:	Tue, 28 Jun 2005 17:14:52 -0700
From:	Noah Misch <noah@cs.caltech.edu>
To:	Andy Shepard <vox_soli@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Linux on SGI Challenge L R10000 (IP25)
Message-ID: <20050629001452.GA15356@orchestra.cs.caltech.edu>
Mail-Followup-To: Andy Shepard <vox_soli@yahoo.com>,
	linux-mips@linux-mips.org
References: <20050628220412.79755.qmail@web31615.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628220412.79755.qmail@web31615.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.5.1i
Return-Path: <noah@cs.caltech.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8239
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noah@cs.caltech.edu
Precedence: bulk
X-list: linux-mips

On Tue, Jun 28, 2005 at 03:04:12PM -0700, Andy Shepard wrote:
> Greetings.  I happen to own one of these machines (12x R10000) and I'm
> interested in doing a port for it.  Does anyone out there have any
> hardware information about this machine?

The SGI owner's guide has some high-level information:
http://www.sgi.com/products/legacy/pdf/challenge_owners_guide.pdf

/usr/include/sys/EVEREST/* from IRIX offer technical facts.

I have an R4400 Challenge (IP19), which is architecturally similar.  Hacking
Linux to boot and run simple userspace from initramfs was trivial, but I do not
yet have drivers for any of the peripheral hardware.
