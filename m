Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2006 16:38:19 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:32791 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133489AbWBIQiL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Feb 2006 16:38:11 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k19GiCPI015843;
	Thu, 9 Feb 2006 16:44:12 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k19GiChX015842;
	Thu, 9 Feb 2006 16:44:12 GMT
Date:	Thu, 9 Feb 2006 16:44:12 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix build error by removal of obsoleted au1x00_uart driver.
Message-ID: <20060209164412.GB3558@linux-mips.org>
References: <20060210.004302.96686142.anemo@mba.ocn.ne.jp> <20060209154959.GA3558@linux-mips.org> <20060210.012559.89066702.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210.012559.89066702.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10385
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Feb 10, 2006 at 01:25:59AM +0900, Atsushi Nemoto wrote:

> >>>>> On Thu, 9 Feb 2006 15:49:59 +0000, Ralf Baechle <ralf@linux-mips.org> said:
> 
> ralf> You were seconds to late, I already checked in an identical
> ralf> patch :)
> 
> Oh I see.  It seems linux-2.6.15.git is a bit behind linux.git ;-)

Not really - I just had not pushed it out yet, so it wasn't get in
linux.git either.

> BTW, linux-2.6.15.git repository is somewhat broken, isn't it?  When I
> pull using git protocol just after rsync, I got following error.  I'm
> using git 1.1.6.
> 
> $ git-pull rsync://ftp.linux-mips.org/pub/scm/linux-2.6.15.git
> receiving file list ... done

Don't do pulls using rsync URLs, it's rather slow as will download all the
packs each time I repacked the archive - which I last did this morning.

Otoh for very large pulls the git protocol is putting a significant
burden on the linux-mips.org machine ...  But linux-2.6.15.git fortunately
doesn't classify as large in this context.

> sent 107 bytes  received 162 bytes  41.38 bytes/sec
> total size is 64135739  speedup is 238422.82
> Already up-to-date.
> $ git-pull git://ftp.linux-mips.org/pub/scm/linux-2.6.15.git
> error: Could not read 91483db9b01b547ae9cc45c8c98b217642acb40a
> error: Could not read 826eeb53a6f264842200d3311d69107d2eb25f5e
> Already up-to-date.
> $

When cloning such a repository git isn't actually downloading the
.git/info/grafts file.  This results in such errors.  I don't know of a
way to get git to do this right.  You may download the file manually
and install it into your tree.  The URL of the grafts file is:

  http://www.linux-mips.org/pub/scm/linux-2.6.15.git/info/grafts

  Ralf
