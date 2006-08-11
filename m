Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Aug 2006 23:32:20 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:63968 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20045166AbWHKWcS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Aug 2006 23:32:18 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7BMWF4X006301;
	Fri, 11 Aug 2006 23:32:15 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7BMWEWT006300;
	Fri, 11 Aug 2006 23:32:14 +0100
Date:	Fri, 11 Aug 2006 23:32:14 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kaz Kylheku <kaz@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Version control question.
Message-ID: <20060811223214.GA5811@linux-mips.org>
References: <66910A579C9312469A7DF9ADB54A8B7D33AFE9@exchange.ZeugmaSystems.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66910A579C9312469A7DF9ADB54A8B7D33AFE9@exchange.ZeugmaSystems.local>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Aug 11, 2006 at 02:31:49PM -0700, Kaz Kylheku wrote:

> Is there any document that makes the linux-mips configuration management
> structure more obvious?

There is http://www.linux-mips.org/wiki/Git.  If that doesn't answer
your questions, let me know what you're missing and if I find the time
I'll add it.  Or just add it yourself to the wiki.

> I see that the 2.6.16 and 2.6.17 lines are in fact parallel branches, so
> that 2.6.16.27 is newer than 2.6.17.

Right.

> If something is broken in 2.6.17 but isn't in 2.6.16.27, what's the best
> way to find it?

You can use git bisect to do that on a clean that is unmodified tree:

$ git bisect start
$ git bisect bad linux-2.6.17
$ git bisect good linux-2.6.16.27

git will then checkout a tree that is about in the middle between the
good and bad version.  Build and test it, then either tell git

$ git bisect good

or

$ git bisect bad

depending on the outcome of your test.  Continue you've shurnk the
interval to a single version which is when git will tell you which
commit broke things.

Once you're finished you tell git to cleanup the tree from all the
bisecting stuff:

$ git bisect reset

> Just compare 2.6.16.27 to the closest parallel 2.6.17.x to see what the
> differences are?

git bisect is handy for finding a change even for relative beginners,
while starring at a diff is often much faster.  You can get a diff
between two tagged versions in git like:

$ git diff linux-2.6.16.27..linux-2.6.17

  Ralf
