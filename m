Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 16:57:14 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:61630 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S20039212AbXBBQ5K (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2007 16:57:10 +0000
Received: from drow by nevyn.them.org with local (Exim 4.63)
	(envelope-from <drow@nevyn.them.org>)
	id 1HD1fg-00080G-IA; Fri, 02 Feb 2007 11:53:56 -0500
Date:	Fri, 2 Feb 2007 11:53:56 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	David Daney <ddaney@avtrex.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Question about signal syscalls !
Message-ID: <20070202165356.GA30584@nevyn.them.org>
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com> <20070201135734.GB12728@linux-mips.org> <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com> <45C21CFE.9060804@avtrex.com> <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com> <45C3611D.7000702@avtrex.com> <cda58cb80702020836t54ab54bam1b83dd7c1dacb4d8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80702020836t54ab54bam1b83dd7c1dacb4d8@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 02, 2007 at 05:36:30PM +0100, Franck Bui-Huu wrote:
> And now I'm starting to think that we don't need to save static regs in
> setup_sigcontext() either...

It's possible not to (iirc at least one arch does that) but please
don't change it now.  This is a userland ABI issue; GDB knows that the
registers are saved, and there are slots for them in
sigcontext/ucontext so it would be unexpected if they were not filled
in.  Could break things like pth.

-- 
Daniel Jacobowitz
CodeSourcery
