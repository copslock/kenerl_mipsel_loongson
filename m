Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 May 2008 14:39:35 +0100 (BST)
Received: from www.church-of-our-saviour.org ([69.25.196.31]:12989 "EHLO
	thunker.thunk.org") by ftp.linux-mips.org with ESMTP
	id S20034800AbYEONjc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 15 May 2008 14:39:32 +0100
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1JwdiM-0001Qf-GJ; Thu, 15 May 2008 09:41:46 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1Jwdfk-0005B1-SA; Thu, 15 May 2008 09:39:04 -0400
Date:	Thu, 15 May 2008 09:39:04 -0400
From:	Theodore Tso <tytso@mit.edu>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org,
	linux-ext4@vger.kernel.org
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Message-ID: <20080515133904.GE18825@mit.edu>
References: <20080512130604.GA15008@deprecation.cyrius.com> <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com> <20080512143426.GB7029@mit.edu> <90edad820805120746l61e67362vbd177d63e8b05dc8@mail.gmail.com> <20080513045028.GC22226@linux-mips.org> <20080513051252.GA20575@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080513051252.GA20575@linux-mips.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Return-Path: <tytso@mit.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tytso@mit.edu
Precedence: bulk
X-list: linux-mips

On Tue, May 13, 2008 at 06:12:52AM +0100, Ralf Baechle wrote:
> The ZERO_PAGE(0) call in ext4_ext_zeroout is the culprit.  Using a zero
> argument allows the compiler to eleminate the reference to zero_page_mask.
> 
> Am I reading this right that ZERO_PAGE() is being used without any
> mappings to userspace being involved?

Correct.  Ext4 supports unitialized extents; this is useful in DVR's,
for example, where there is a desire to allocate contiguous blocks
for, say, a 60 minute TV show, without having to pay the cost of
zero'ing the blocks.  But in some cases where someone seeks a few
blocks ahead, and writes into the middle of the unitialized region,
instead of splitting the unitialized extent into 3 pieces, for short
regions we will simply zero out a few blocks and then write the
requested block.  

This is better in the case of binutils, for example, where it will
write out blocks in a random order using a few close-range seeks, and
it's more efficient to do this than to bloat out the extent tree only
to have to recombine extents later.

Anyway, yes, we just need to use the zero page without any user
mapping being involved.

						- Ted
