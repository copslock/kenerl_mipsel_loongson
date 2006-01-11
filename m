Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 12:14:18 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:19734 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133429AbWAKMNr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jan 2006 12:13:47 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0BCGk8d006778;
	Wed, 11 Jan 2006 12:16:47 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0BCGjBY006776;
	Wed, 11 Jan 2006 12:16:45 GMT
Date:	Wed, 11 Jan 2006 12:16:45 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	"P. Christeas" <p_christ@hol.gr>, linux-mips@linux-mips.org
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Message-ID: <20060111121645.GB4403@linux-mips.org>
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com> <20060109145610.GB4286@linux-mips.org> <200601091720.03822.p_christ@hol.gr> <20060109152429.GE4286@linux-mips.org> <50c9a2250601091702g7e48c75br178868a3c91d48f4@mail.gmail.com> <20060110141924.GA13779@linux-mips.org> <50c9a2250601101804h73aa933dyf3434635aa7bde55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250601101804h73aa933dyf3434635aa7bde55@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 11, 2006 at 10:04:50AM +0800, zhuzhenhua wrote:

> On 1/10/06, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Tue, Jan 10, 2006 at 09:02:43AM +0800, zhuzhenhua wrote:
> >
> > > > In 2.6.15 things were alomst fully merged but several megabytes of
> > > > patches are between the linux-mips.org and kernel.org versions of 2.6.14.
> > > >
> > > >   Ralf
> > > >
> > >
> > > in linux-mips, where to download the patches for standard kernel?
> >
> > I don't publish such patches - but they're eassy to generate.
> i find on http://www.linux-mips.org/pub/linux/mips/kernel/v2.6/ can
> download the kernel tarball, i compire the 2.6.14 with the stand
> kernel, and found they are not same.
> 
> is the tarball in
> http://www.linux-mips.org/pub/linux/mips/kernel/v2.6/ is tared with
> the cvs tree code in linux-mips?

Some tarballs were rather old, were created before the switch to git.
The 2.4 and 2.6 tarballs were created from the git tags.

In case of doubt you could always try git-get-tar-commit-id on the tarball.

  Ralf
