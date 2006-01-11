Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 19:05:07 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:47624 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133424AbWAKTEo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jan 2006 19:04:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0BJ7j9A025388;
	Wed, 11 Jan 2006 19:07:46 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0BJ7hEa025381;
	Wed, 11 Jan 2006 19:07:43 GMT
Date:	Wed, 11 Jan 2006 19:07:43 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ivan Korzakow <ivan.korzakow@gmail.com>
Cc:	"P. Christeas" <p_christ@hol.gr>, linux-mips@linux-mips.org
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Message-ID: <20060111190743.GE4403@linux-mips.org>
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com> <200601101757.45297.p_christ@hol.gr> <a59861030601100838oa89ac84n@mail.gmail.com> <200601101857.26978.p_christ@hol.gr> <20060110215322.GA27577@linux-mips.org> <a59861030601110310gca74f54o@mail.gmail.com> <20060111112001.GA4403@linux-mips.org> <a59861030601110707u16f5d366m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a59861030601110707u16f5d366m@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 11, 2006 at 04:07:25PM +0100, Ivan Korzakow wrote:

> I know that but you miss my point. GIT is a tool to ease work on linux
> kernel, but the way you use it makes harder life of users of your
> tree. For example your tree contains more than 350 000 objects ! That
> makes a lot of git commands running slow...

Linus promised too look into that.  He has too - it's what his tree would
be facing in the not too distant future, otherwise.

> Let's say I'm developing a net drivers on ARM platform. I'm actually
> do not care about ARM development, but I do care about net tree. To do
> that, I just need to clone net tree because I know that ARM should be
> OK with this tree. What about MIPS ?
> 
> I'm just wondering why not asking to Linus to pull from your tree like
> every others maintainers do ?

Like most other developers I create throw-away trees for that purpose, see
the upstream-linus tree.  Due to the way the Linux release process is
working anything else is unrealistic.

  Ralf
