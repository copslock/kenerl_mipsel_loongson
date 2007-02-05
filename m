Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 02:30:46 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:35809 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S20038718AbXBECam (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Feb 2007 02:30:42 +0000
Received: from drow by nevyn.them.org with local (Exim 4.63)
	(envelope-from <drow@nevyn.them.org>)
	id 1HDtct-0001QZ-Gh; Sun, 04 Feb 2007 21:30:39 -0500
Date:	Sun, 4 Feb 2007 21:30:39 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Question about signal syscalls !
Message-ID: <20070205023039.GA5438@nevyn.them.org>
References: <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com> <45C21CFE.9060804@avtrex.com> <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com> <45C3611D.7000702@avtrex.com> <cda58cb80702020836t54ab54bam1b83dd7c1dacb4d8@mail.gmail.com> <45C36D46.5040409@avtrex.com> <cda58cb80702021158n42bdb5fbi6cca4f2c8dff6782@mail.gmail.com> <45C3A1E3.8010802@avtrex.com> <20070205005516.GA1581@nevyn.them.org> <20070205011048.GA26654@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070205011048.GA26654@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 05, 2007 at 01:10:48AM +0000, Ralf Baechle wrote:
> Not saving the s-registers into the signal frame would be a neat
> optimization.  It wouldn't only make things a little faster it would
> also free space in the signal frame which is needed for CPU
> architecture extensions that have more state to save.  I had to burn
> almost the entire available space for the DSP extensions, so I wonder
> if we could get GDB to work?  The alternative is probably a new version
> of the sigrestore.

I'm sure that, if we tried, we could get GDB to work.  Every time this
comes up I just worry about other things that we don't know about which
use the saved information.  These structures are just in too many
places to change comfortably.

If you're worried about DSP extensions, you might want to take a look
at the work Nico and I did for ARM in the past year or so; it tags
extra register sets in the ucontext.  It was a pain to get together
though.

-- 
Daniel Jacobowitz
CodeSourcery
