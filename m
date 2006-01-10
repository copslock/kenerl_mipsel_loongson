Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 16:55:22 +0000 (GMT)
Received: from [62.38.108.96] ([62.38.108.96]:10206 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S8133452AbWAJQyn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 10 Jan 2006 16:54:43 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id 4783F1F101;
	Tue, 10 Jan 2006 18:57:40 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Date:	Tue, 10 Jan 2006 18:57:24 +0200
User-Agent: KMail/1.9
Cc:	Ivan Korzakow <ivan.korzakow@gmail.com>
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com> <200601101757.45297.p_christ@hol.gr> <a59861030601100838oa89ac84n@mail.gmail.com>
In-Reply-To: <a59861030601100838oa89ac84n@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601101857.26978.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9847
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Tuesday 10 January 2006 6:38 pm, Ivan Korzakow wrote:
> 2006/1/10, P. Christeas <p_christ@hol.gr>:

> > You make sure you have the two trees and diff them.
> > They 're both in git and typically you could do that only using git.
>
> Have you ever tried what you're talking about or is it a guess ?
> For example, let's say that there's a bug introduced when merging
> Linus tree with mips branch. How do you easily "bisect" in order to do
> a binary seek of this bug ?

 I was about to mention the git incompatibility as I gave you the first 
answer. It's true what you say and I also find it annoying. That's why I use 
Linus tree.
I cannot, though, complaint to Ralph about this practice. It seems that he has 
done his best to preserve the CVS history of his tree. We can only thank him 
for that. It is just a lot of work to trim the tree and make it 
Linus-parallel.
There is also things that I don't know about git, so I won't jump to 
conclusions yet (as to whether it is feasible to merge with Linus).
