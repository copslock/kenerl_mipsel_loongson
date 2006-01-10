Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 11:46:17 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:5405 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133429AbWAKLp4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jan 2006 11:45:56 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0BBmv9s005995;
	Wed, 11 Jan 2006 11:48:57 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0ANK6lS003667;
	Tue, 10 Jan 2006 23:20:06 GMT
Date:	Tue, 10 Jan 2006 23:20:06 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ivan Korzakow <ivan.korzakow@gmail.com>
Cc:	"P. Christeas" <p_christ@hol.gr>, linux-mips@linux-mips.org
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Message-ID: <20060110232006.GA3519@linux-mips.org>
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com> <200601101757.45297.p_christ@hol.gr> <a59861030601100838oa89ac84n@mail.gmail.com> <200601101857.26978.p_christ@hol.gr> <a59861030601100915q6ffb4896v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59861030601100915q6ffb4896v@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 10, 2006 at 06:15:18PM +0100, Ivan Korzakow wrote:

> Why not simply keep CVS repository available for 1% of people willing
> to browse the history ? And make life easier for 99% of people willing
> to work on 2.6 ... (2.4 work may continue to use CVS too).

The CVS repository is still available - and will stay for a long time so
people have a chance to do diffs against their existing checked out trees.
But no more changes.

Note, this does not affect the other projects in the CVS server.  Each
of them is maintained independantly and for each the decission to use CVS,
git or some flying saucer technology to use is made by whoever is the
caretaker of that project.

  Ralf
