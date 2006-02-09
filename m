Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 11:37:43 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:4868 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133571AbWBJLh1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Feb 2006 11:37:27 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1ABh8PT005779;
	Fri, 10 Feb 2006 11:43:10 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k19KrcV2003597;
	Thu, 9 Feb 2006 20:53:38 GMT
Date:	Thu, 9 Feb 2006 20:53:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix build error by removal of obsoleted au1x00_uart driver.
Message-ID: <20060209205338.GA3508@linux-mips.org>
References: <20060210.004302.96686142.anemo@mba.ocn.ne.jp> <20060209154959.GA3558@linux-mips.org> <20060210.012559.89066702.anemo@mba.ocn.ne.jp> <20060209164412.GB3558@linux-mips.org> <cda58cb80602090954s46ba0d78s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80602090954s46ba0d78s@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 09, 2006 at 06:54:05PM +0100, Franck Bui-Huu wrote:

> 2006/2/9, Ralf Baechle <ralf@linux-mips.org>:
> > When cloning such a repository git isn't actually downloading the
> > .git/info/grafts file.  This results in such errors.  I don't know of a
> > way to get git to do this right.  You may download the file manually
> 
> you can't. It seems that graft thing is, for now, only used to change
> your _own_ repository's history. Fetching from a "cautorized"
> repository is a risky job and you might have bad results.

It works for me (TM).

> It's going to change with the "shallow-clone" thing, but I don't know
> when it will come out...

There are many problems with "cautorized" repositories, some with the
current implementation, some more fundamental ones.  Such as what is
the cut-off criterium?  The MIPS git repository also contains the objects
of Linus's tree [1].  So a tag like linux-2.6.15 as the line for truncation
isn't working too well because I'll only truncate the Linux/MIPS history
but that'll still leave all of Linus's tree - well over 130,000 objects -
in the tree.

Anyway, I'm trying to maintain a homebrew shallow variant of the tree
for the time being until git provides a better instrument for the job.

  Ralf

[1] Not Linus's tags to avoid confusion.  They could easily be pulled from
    Linus tree into a separate branch.  Similar for Marcelo's 2.4 tree.
