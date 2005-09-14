Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2005 13:38:13 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:4637 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225007AbVINMh4>; Wed, 14 Sep 2005 13:37:56 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j8ECboTI022364
	for <linux-mips@linux-mips.org>; Wed, 14 Sep 2005 13:37:50 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j8ECboIh022363
	for linux-mips@linux-mips.org; Wed, 14 Sep 2005 13:37:50 +0100
Date:	Wed, 14 Sep 2005 13:37:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: Git
Message-ID: <20050914123750.GL3224@linux-mips.org>
References: <20050913124544.GC3224@linux-mips.org> <20050913133126.GO23161@lug-owl.de> <20050913152038.GE3224@linux-mips.org> <20050914095858.GD23161@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914095858.GD23161@lug-owl.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 14, 2005 at 11:58:58AM +0200, Jan-Benedict Glaw wrote:

> To:	linux-mips@linux-mips.org

If you actually expect finite time answer, don't delete the cc list ...

> monotone
> 	Is quite nice'n'easy to use for CVS users, you'll have quite a
> 	fast start. The network sync protocol can be a bit lengthy at
> 	a time, but it works. It's acceptable in speed, but not
> 	exactly "fast". Written in C, code can easily be read and
> 	hacked.

Git has taken some ideas from Monotone.

> darcs
> 	Is easy to use, too, and quite some helpful. Network
> 	operations are a bit slower than those of monotone, but the
> 	real point is that it's merging algorithms are awfully slow.
> 	Also, it's written in Haskell (and getting a working compiler
> 	isn't exactly trivial), so the code is hard to read (for a C
> 	person), mostly because Haskell's concept are so different
> 	(it's a function programming language, after all.)

In my tests at the beginning of the year darcs's performance was
undescribably low.  The speedup factor needed to make it useful for any
large project probably cannot be described in a floating point number.

> arch
> 	Arch can do almost everything; it's network sync protocol is
> 	quite fast (can use several transports and will make use of
> 	caches). However, it's not exactly easy to use because of it's
> 	thousands of commands and it's project name conventions are,
> 	um, ugly. It has very good merging capabilities, but it's
> 	heavy use of local caches forces you to have loads of free HDD
> 	space.

Git is a huge diskspace consumer also unless repositories are converted.
For example, the Linux kernel repository from CVS did inflate itself to
over 4GB and over 340,000 files.  After packing I got that down to like
170MB.  Not bad compared to the some 770MB of RCS files it's using
currently and < 11s checkout from git can't be wrong either ;-)

> SVN
> 	Not distributed, easy to use.  Though there's a different
> 	frontend with distribution capabilities. Personally, SVN feels
> 	like CVS with it's major conceptual problems fixed.

And plenty of reports about database corruption that are not terribly old
so I'd feel uneasy to keep the crown jewels there.

> To get fixes/port updates/subsystem updates upstream to Linus, GIT is
> the way[tm] to go, so we'd try to get familiar with it.

The other accepted currency of the trade are still simple patches, see
http://www.linux-mips.org/wiki/The_perfect_patch.

  Ralf
