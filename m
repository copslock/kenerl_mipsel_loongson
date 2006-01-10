Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 15:55:14 +0000 (GMT)
Received: from [62.38.108.96] ([62.38.108.96]:48007 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S8133373AbWAJPy4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Jan 2006 15:54:56 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id 9B2AF1F101;
	Tue, 10 Jan 2006 17:57:56 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	linux-mips@linux-mips.org
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Date:	Tue, 10 Jan 2006 17:57:44 +0200
User-Agent: KMail/1.9
Cc:	Ivan Korzakow <ivan.korzakow@gmail.com>
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com> <20060110141924.GA13779@linux-mips.org> <a59861030601100740r432904d9o@mail.gmail.com>
In-Reply-To: <a59861030601100740r432904d9o@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101757.45297.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Tuesday 10 January 2006 5:40 pm, Ivan Korzakow wrote:
> 2006/1/10, Ralf Baechle <ralf@linux-mips.org>:
> > On Tue, Jan 10, 2006 at 09:02:43AM +0800, zhuzhenhua wrote:
> > > > In 2.6.15 things were alomst fully merged but several megabytes of
> > > > patches are between the linux-mips.org and kernel.org versions of
> > > > 2.6.14.
> > > >
> > > >   Ralf
> > >
> > > in linux-mips, where to download the patches for standard kernel?
> >
> > I don't publish such patches - but they're eassy to generate.
>
> Could you be a bit more explicit about that "easy" way you generate them ?
>
> Ivan
You make sure you have the two trees and diff them.
They 're both in git and typically you could do that only using git.
