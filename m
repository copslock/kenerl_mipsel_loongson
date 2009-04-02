Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Apr 2009 21:07:10 +0100 (BST)
Received: from NaN.false.org ([208.75.86.248]:39129 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S20029457AbZDBUHA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Apr 2009 21:07:00 +0100
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 67A2910DD5;
	Thu,  2 Apr 2009 20:06:58 +0000 (GMT)
Received: from caradoc.them.org (209.195.188.212.nauticom.net [209.195.188.212])
	by nan.false.org (Postfix) with ESMTP id 22D5A10AD6;
	Thu,  2 Apr 2009 20:06:58 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1LpTBg-000489-Vb; Thu, 02 Apr 2009 16:06:56 -0400
Date:	Thu, 2 Apr 2009 16:06:56 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Brian Foster <brian.foster@innova-card.com>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
Message-ID: <20090402200656.GA15821@caradoc.them.org>
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <200903040919.29294.brian.foster@innova-card.com> <20090304121732.GA28381@caradoc.them.org> <49AEAE1D.5030205@caviumnetworks.com> <20090402132936.GB15021@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090402132936.GB15021@linux-mips.org>
User-Agent: Mutt/1.5.17 (2008-05-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22251
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 02, 2009 at 03:29:36PM +0200, Ralf Baechle wrote:
> To maintaine compatibility with old debuggers and possibly other software
> that knows about the stackframe layout I wrote the signal code to only
> use the larger alignment of the stackframe if a particular processor
> requires it.
> 
> However one possible improvment would be to change the way a struct sigframe
> or rt_sigframe is allocated on the stack such that not the beginning of
> the structure is aligned but the rs_code field is kept aligned.  Would
> such a change cause problems for gdb?

If you don't change the internal layout of the structure, I don't
think GDB will even notice - it does not know about the more-aligned variant.

-- 
Daniel Jacobowitz
CodeSourcery
