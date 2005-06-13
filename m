Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jun 2005 21:56:19 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:20930 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225893AbVFMU4D>;
	Mon, 13 Jun 2005 21:56:03 +0100
Received: from drow by nevyn.them.org with local (Exim 4.50)
	id 1DhvyQ-0006zr-WE; Mon, 13 Jun 2005 16:55:59 -0400
Date:	Mon, 13 Jun 2005 16:55:58 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Christoph Hellwig <hch@lst.de>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Jim Gifford <maillist@jg555.com>,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: Building o32 glibc on mips64
Message-ID: <20050613205558.GA26829@nevyn.them.org>
References: <42AB3366.8030206@jg555.com> <20050613195602.GA3739@nevyn.them.org> <Pine.LNX.4.61L.0506132100080.1725@blysk.ds.pg.gda.pl> <20050613200820.GA29872@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613200820.GA29872@lst.de>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 13, 2005 at 10:08:20PM +0200, Christoph Hellwig wrote:
> Btw, what is the chance to see a biarch toolchain for mips?  It seems
> all linux architectures with 32bit and 64bit variants seem to have one
> these days, except mips.

As Maciej wrote, mips64-linux is already triarch.  It's possible to
build a multiarch mips-linux toolchain, or a mips64-linux toolchain
which supports multilibs but defaults to o32, but neither's real easy.
I build mips64-linux toolchains all the time, though.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
