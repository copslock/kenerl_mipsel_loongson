Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 14:16:48 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:49431 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465573AbWAJOQa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jan 2006 14:16:30 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0AEJPYc013935;
	Tue, 10 Jan 2006 14:19:25 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0AEJPGZ013934;
	Tue, 10 Jan 2006 14:19:25 GMT
Date:	Tue, 10 Jan 2006 14:19:24 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	zhuzhenhua <zzh.hust@gmail.com>
Cc:	"P. Christeas" <p_christ@hol.gr>, linux-mips@linux-mips.org
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Message-ID: <20060110141924.GA13779@linux-mips.org>
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com> <20060109145610.GB4286@linux-mips.org> <200601091720.03822.p_christ@hol.gr> <20060109152429.GE4286@linux-mips.org> <50c9a2250601091702g7e48c75br178868a3c91d48f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c9a2250601091702g7e48c75br178868a3c91d48f4@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 10, 2006 at 09:02:43AM +0800, zhuzhenhua wrote:

> > In 2.6.15 things were alomst fully merged but several megabytes of
> > patches are between the linux-mips.org and kernel.org versions of 2.6.14.
> >
> >   Ralf
> >
> 
> in linux-mips, where to download the patches for standard kernel?

I don't publish such patches - but they're eassy to generate.

  Ralf
