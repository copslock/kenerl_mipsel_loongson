Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2009 08:28:12 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:43846 "EHLO
	localhost.localdomain" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023147AbZEPH2J (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2009 08:28:09 +0100
Date:	Sat, 16 May 2009 08:28:09 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: [PATCH] MIPS: Don't branch to eret in TLB refill.
In-Reply-To: <4A0A1E6B.6050908@caviumnetworks.com>
Message-ID: <alpine.LFD.1.10.0905160706300.12158@ftp.linux-mips.org>
References: <1242168316-4009-1-git-send-email-ddaney@caviumnetworks.com> <20090513002337.GA12536@cuplxvomd02.corp.sa.net> <4A0A1E6B.6050908@caviumnetworks.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22774
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 12 May 2009, David Daney wrote:

> > > +			/*
> > > +			 * Find the split point.
> > > +			 */
> > > +			if (uasm_insn_has_bdelay(relocs, split - 1))
> > > +				split--;
> > > +		}
> > 
> > The code itself makes sense. Does this case actually happen much, or was
> > this just an itch?
> > 
> 
> For my CPU it was happening 100% of the time when I add the soon to be
> submitted hugeTLBfs support patch.  Although I have not measured it, this code
> is so hot that keeping the normal case fitting on a single cache line should
> be a big win.

 Rather than this hack, I'd suggest microoptimising the code by shuffling 
it such that unless the handler fits in 128 bytes entirely (I'm not sure 
if that ever happens for XTLB refill) the part built by 
build_get_pgd_vmalloc64() is placed in the TLB handler slot, saving an 
unnecessary unconditional branch there.  This way the problem of an 
unconditional branch to ERET will solve automagically as a side-effect.  
Unless the vmalloc part does not fit in 128 bytes, that is, in which case 
it would have to overflow back to the XTLB slot.  It should be pretty 
straightforward to code. ;)

  Maciej
