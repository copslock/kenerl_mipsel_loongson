Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 19:39:13 +0100 (BST)
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:39309 "EHLO
	biscayne-one-station.mit.edu") by ftp.linux-mips.org with ESMTP
	id S20024061AbYFESjL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jun 2008 19:39:11 +0100
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m55IcvTU003603;
	Thu, 5 Jun 2008 14:38:57 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m55IcsjQ008235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 5 Jun 2008 14:38:55 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1K4KMQ-0007dv-Eh; Thu, 05 Jun 2008 14:38:54 -0400
Date:	Thu, 5 Jun 2008 14:38:54 -0400
From:	Theodore Tso <tytso@MIT.EDU>
To:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Cc:	Martin Michlmayr <tbm@cyrius.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	linux-mips@linux-mips.org, linux-ext4@vger.kernel.org
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Message-ID: <20080605183854.GN25477@mit.edu>
References: <20080512130604.GA15008@deprecation.cyrius.com> <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com> <20080512143426.GB7029@mit.edu> <90edad820805120746l61e67362vbd177d63e8b05dc8@mail.gmail.com> <20080513045028.GC22226@linux-mips.org> <20080528070637.GA10393@deprecation.cyrius.com> <20080605111148.GA4483@deprecation.cyrius.com> <1212664977.4840.6.camel@sd048.hel.movial.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1212664977.4840.6.camel@sd048.hel.movial.fi>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
Return-Path: <tytso@MIT.EDU>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tytso@MIT.EDU
Precedence: bulk
X-list: linux-mips

On Thu, Jun 05, 2008 at 02:22:57PM +0300, Dmitri Vorobiev wrote:
> 
> It looks like the discussion related to this issue has faded out. Ralf
> seemed to have some objections to using ZERO_PAGE() outside of the
> context of getting a user-mapped page, but I think that ext4 driver is
> still doing that.
> 

I thought I had sent a reply indicating that yes, we are using
ZERO_PAGE outside of getting a user-mapped page, because this is
happening when we need to write zero's to directly to a filesystem
block.  This case arises when we have a file which contains
preallocated space that has not yet been initialized, and the user
program seeks into the middle of the unitialized extent range, and
writes into the middle of that space.

In some cases, it is more efficient to zero out a small range of
blocks on disk rather than splitting the extent in the middle.  We
could explicitly allocate a page, and zero it out, and use it to write
zeros from the ext4 filesystem, code, but that seems silly, given that
ZERO_PAGE exists and is available on all other architectures.

Cristoph Hellwig had complained about the use of ZERO_PAGE, but when I
gave him the above explanation, he agreed that this was indeed
probably the best way to do things.

If you really insist I suppose we could have a MIPS specific patch
where we allocate a 4k page and zero it, so we can use it from our
kernel code because you don't want to export and make available the
ZERO_PAGE that gets used by the rest of the kernel, but that seems
awfully silly, and would be a waste of 4k of memory.....  Someone from
MIPS land would have to test it, as well, as I dont think any of the
ext4 developers have access to a MIPS platform.

						- Ted
