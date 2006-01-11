Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 11:17:19 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:4118 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133376AbWAKLQ6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jan 2006 11:16:58 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0BBK1x7005085;
	Wed, 11 Jan 2006 11:20:02 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0BBK110005084;
	Wed, 11 Jan 2006 11:20:01 GMT
Date:	Wed, 11 Jan 2006 11:20:01 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ivan Korzakow <ivan.korzakow@gmail.com>
Cc:	"P. Christeas" <p_christ@hol.gr>, linux-mips@linux-mips.org
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Message-ID: <20060111112001.GA4403@linux-mips.org>
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com> <200601101757.45297.p_christ@hol.gr> <a59861030601100838oa89ac84n@mail.gmail.com> <200601101857.26978.p_christ@hol.gr> <20060110215322.GA27577@linux-mips.org> <a59861030601110310gca74f54o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59861030601110310gca74f54o@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 11, 2006 at 12:10:05PM +0100, Ivan Korzakow wrote:

> It would be great to be a little bit more explicit by giving some
> _little_ examples ! Why not enlighting us directly instead of being so
> vague.

In books that kind of stuff is usually marked as "left as an exercise to
the reader" ;-)

  git-clone rsync://ftp.linux-mips.org/pub/scm/linux.git repository
  cd repository
  git-fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 master:linus
  git-repack -a -d

  Ralf
