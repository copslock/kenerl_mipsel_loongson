Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Sep 2005 21:35:00 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:51893 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S3465592AbVI3Uei (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Sep 2005 21:34:38 +0100
Received: from drow by nevyn.them.org with local (Exim 4.52)
	id 1ELRaU-0004rx-35; Fri, 30 Sep 2005 16:34:34 -0400
Date:	Fri, 30 Sep 2005 16:34:34 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Dominic Sweetman <dom@mips.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: RFC: Revise n32 ptrace interface
Message-ID: <20050930203434.GA18321@nevyn.them.org>
References: <20050922182601.GA10829@nevyn.them.org> <20050930000550.GE3983@linux-mips.org> <17213.38447.42728.297338@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17213.38447.42728.297338@mips.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 30, 2005 at 08:46:55PM +0100, Dominic Sweetman wrote:
> 
> Ralf Baechle (ralf@linux-mips.org) writes:
> 
> > I quite deliberately did omit DSP support from 64-bit ptrace(2); there
> > is currently no MIPS64 processor with DSP support that I know of.
> 
> This is true so far. 
> 
> But assuming that 64-bit processing becomes increasingly interesting
> (which seems certain) and that some kind of DSP support with extra
> registers remains attractive (which seems fairly likely)... well, I'd
> have said that any 64-bit MIPS CPU configured from now on is quite
> likely to have extra DSP registers.
> 
> So while "you aren't going to need it" for a while, anyone thinking of
> doing a non-compatible change to ptrace might want to reserve some
> space for these registers.

In the future they should be added using PTRACE_GETDSPREGS, or
something similar.  No one's designed that yet, so the first person to
need it gets to do it right.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
