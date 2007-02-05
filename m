Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 00:58:34 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:59828 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S20038780AbXBEA63 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Feb 2007 00:58:29 +0000
Received: from drow by nevyn.them.org with local (Exim 4.63)
	(envelope-from <drow@nevyn.them.org>)
	id 1HDs8a-0000QK-3a; Sun, 04 Feb 2007 19:55:16 -0500
Date:	Sun, 4 Feb 2007 19:55:16 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: Question about signal syscalls !
Message-ID: <20070205005516.GA1581@nevyn.them.org>
References: <cda58cb80702010243y4a36026i6945f2a5cd3791d0@mail.gmail.com> <20070201135734.GB12728@linux-mips.org> <cda58cb80702010654w74527a34k4ed229b499b8f9b2@mail.gmail.com> <45C21CFE.9060804@avtrex.com> <cda58cb80702020055t6eb2578fn5d1e4370e9ebda08@mail.gmail.com> <45C3611D.7000702@avtrex.com> <cda58cb80702020836t54ab54bam1b83dd7c1dacb4d8@mail.gmail.com> <45C36D46.5040409@avtrex.com> <cda58cb80702021158n42bdb5fbi6cca4f2c8dff6782@mail.gmail.com> <45C3A1E3.8010802@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45C3A1E3.8010802@avtrex.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13918
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 02, 2007 at 12:41:07PM -0800, David Daney wrote:
> I thought you were suggesting not saving s0-s7.  If you don't save them, 
> you cannot restore them.  And they have to be restored from the 
> sigcontext in the user's address space.   This allows user space signal 
> handlers to emulate trapping instructions, and the like.

Not necessarily, because you can trust the signal handler to restore
them, and it can save them itself if it needs to.  As I said, I think
there's at least one architecture which does it this way.  I'm afraid I
don't know which one.

-- 
Daniel Jacobowitz
CodeSourcery
