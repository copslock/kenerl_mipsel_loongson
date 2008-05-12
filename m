Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2008 18:36:00 +0100 (BST)
Received: from www.church-of-our-saviour.org ([69.25.196.31]:59093 "EHLO
	thunker.thunk.org") by ftp.linux-mips.org with ESMTP
	id S20030609AbYELRf6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 12 May 2008 18:35:58 +0100
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1Jvbyb-00045P-Fx; Mon, 12 May 2008 13:38:17 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1Jvbw2-00053v-5I; Mon, 12 May 2008 13:35:38 -0400
Date:	Mon, 12 May 2008 13:35:38 -0400
From:	Theodore Tso <tytso@mit.edu>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org,
	linux-ext4@vger.kernel.org
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Message-ID: <20080512173537.GG7029@mit.edu>
References: <20080512130604.GA15008@deprecation.cyrius.com> <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com> <20080512143426.GB7029@mit.edu> <20080512145836.GE15866@deprecation.cyrius.com> <90edad820805120814l7ee3f5d3h7f9939854bccf0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90edad820805120814l7ee3f5d3h7f9939854bccf0@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Return-Path: <tytso@mit.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tytso@mit.edu
Precedence: bulk
X-list: linux-mips

On Mon, May 12, 2008 at 07:14:23PM +0400, Dmitri Vorobiev wrote:
> 
> It was April 29th 2008 when commit
> 093a088b76352e0a6fdca84eb78b3aa65fbe6dd1 where the ext4_ext_zeroout()
> routine was introduced (it is this routine that makes use of the
> ZERO_PAGE macro expanding to an expression that contains a reference
> to the empty_zero_page global symbol). After this commit, the patches
> similar to the one found in this thread were made for several
> architectures. Apparently, MIPS has been overlooked.
> 

Yeah, I guess no one is currently doing test builds of linux-next on
the mips architecture.  It's likely Stephen Rothwell doesn't have
access to one.

(The patch itself has been around for a while, both in the -mm tree,
the ext4 patches, and in Linux-next.)

						- Ted
