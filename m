Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 01:10:57 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:61373 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039067AbXBEBKz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 Feb 2007 01:10:55 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l151AouQ026750;
	Mon, 5 Feb 2007 01:10:50 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l151AmFV026749;
	Mon, 5 Feb 2007 01:10:48 GMT
Date:	Mon, 5 Feb 2007 01:10:48 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	David Daney <ddaney@avtrex.com>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Question about signal syscalls !
Message-ID: <20070205011048.GA26654@linux-mips.org>
References: <20070201135734.GB12728@linux-mips.org> <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com> <45C21CFE.9060804@avtrex.com> <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com> <45C3611D.7000702@avtrex.com> <cda58cb80702020836t54ab54bam1b83dd7c1dacb4d8@mail.gmail.com> <45C36D46.5040409@avtrex.com> <cda58cb80702021158n42bdb5fbi6cca4f2c8dff6782@mail.gmail.com> <45C3A1E3.8010802@avtrex.com> <20070205005516.GA1581@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070205005516.GA1581@nevyn.them.org>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 04, 2007 at 07:55:16PM -0500, Daniel Jacobowitz wrote:

> On Fri, Feb 02, 2007 at 12:41:07PM -0800, David Daney wrote:
> > I thought you were suggesting not saving s0-s7.  If you don't save them, 
> > you cannot restore them.  And they have to be restored from the 
> > sigcontext in the user's address space.   This allows user space signal 
> > handlers to emulate trapping instructions, and the like.
> 
> Not necessarily, because you can trust the signal handler to restore
> them, and it can save them itself if it needs to.  As I said, I think
> there's at least one architecture which does it this way.  I'm afraid I
> don't know which one.

Not saving the s-registers into the signal frame would be a neat
optimization.  It wouldn't only make things a little faster it would
also free space in the signal frame which is needed for CPU
architecture extensions that have more state to save.  I had to burn
almost the entire available space for the DSP extensions, so I wonder
if we could get GDB to work?  The alternative is probably a new version
of the sigrestore.

  Ralf
