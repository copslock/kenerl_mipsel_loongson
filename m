Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 21:30:03 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:50095 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S3466984AbVKHV3p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Nov 2005 21:29:45 +0000
Received: from drow by nevyn.them.org with local (Exim 4.54)
	id 1EZb3X-0007mE-LK; Tue, 08 Nov 2005 16:31:03 -0500
Date:	Tue, 8 Nov 2005 16:31:03 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Franck <vagabon.xyz@gmail.com>, linux-mips@linux-mips.org
Subject: Re: git and tags...
Message-ID: <20051108213103.GA29835@nevyn.them.org>
References: <cda58cb80511080249w7d902821n@mail.gmail.com> <20051108110134.GA2689@linux-mips.org> <cda58cb80511080925l2d441604i@mail.gmail.com> <20051108184521.GB2689@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108184521.GB2689@linux-mips.org>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9453
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 08, 2005 at 06:45:21PM +0000, Ralf Baechle wrote:
> On Tue, Nov 08, 2005 at 06:25:06PM +0100, Franck wrote:
> 
> > OK, so tags have been renamed into "linux-2.6.x". Why not using the
> > same mainline name convention (v2.6.x) ?
> 
> The same reason that some people like blue and others prefer green ;-)
> 
> > I have another question (which is the first one in my previous email),
> > how can I make my working tree a kernel version 2.6.9 for example ?
> 
> git-read-tree $(cat .git/refs/tags/linux-2.6.9)
> git-checkout-index -f -a -u -q

IIUC, this is just "git checkout linux-2.6.9" nowadays.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
