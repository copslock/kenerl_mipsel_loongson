Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 16:36:15 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.198]:36568 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133431AbWAJQfu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jan 2006 16:35:50 +0000
Received: by wproxy.gmail.com with SMTP id 71so3673081wri
        for <linux-mips@linux-mips.org>; Tue, 10 Jan 2006 08:38:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N+GidnhpSkoEOOOji69+4LjcQCC91aJk2xE88LuHKJIuH9XFkg4vLXYuOcY/X/CbDNlCF5Zq+EygMig3ZjKyjRoZvH8sllQM3RxuaDGXLHixLQ9aqnj9DBg7H+BPqK9lGSrePvVWwXhG6Y0ebpKOh1y7cC2yUvykGvcqyqTFcFM=
Received: by 10.54.67.10 with SMTP id p10mr5463219wra;
        Tue, 10 Jan 2006 08:38:55 -0800 (PST)
Received: by 10.54.69.5 with HTTP; Tue, 10 Jan 2006 08:38:55 -0800 (PST)
Message-ID: <a59861030601100838oa89ac84n@mail.gmail.com>
Date:	Tue, 10 Jan 2006 17:38:55 +0100
From:	Ivan Korzakow <ivan.korzakow@gmail.com>
To:	"P. Christeas" <p_christ@hol.gr>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <200601101757.45297.p_christ@hol.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
	 <20060110141924.GA13779@linux-mips.org>
	 <a59861030601100740r432904d9o@mail.gmail.com>
	 <200601101757.45297.p_christ@hol.gr>
Return-Path: <ivan.korzakow@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9846
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ivan.korzakow@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/10, P. Christeas <p_christ@hol.gr>:
> On Tuesday 10 January 2006 5:40 pm, Ivan Korzakow wrote:
> > 2006/1/10, Ralf Baechle <ralf@linux-mips.org>:
> > > On Tue, Jan 10, 2006 at 09:02:43AM +0800, zhuzhenhua wrote:
> > > > > In 2.6.15 things were alomst fully merged but several megabytes of
> > > > > patches are between the linux-mips.org and kernel.org versions of
> > > > > 2.6.14.
> > > > >
> > > > >   Ralf
> > > >
> > > > in linux-mips, where to download the patches for standard kernel?
> > >
> > > I don't publish such patches - but they're eassy to generate.
> >
> > Could you be a bit more explicit about that "easy" way you generate them ?
> >
> > Ivan
> You make sure you have the two trees and diff them.
> They 're both in git and typically you could do that only using git.
>

Have you ever tried what you're talking about or is it a guess ?
For example, let's say that there's a bug introduced when merging
Linus tree with mips branch. How do you easily "bisect" in order to do
a binary seek of this bug ?

BTW, I noticed that Linux mips repository have several branches. Each
branch is tracking each kernel minor version. I think this is
completly useless :
1 - it makes the repository huge by keeping history since 2.2 (It's
pointless for most people)
2 - The way branches are made is broken : you can not fetch separate
branches without doing some "grafts" things

Why not simply ask Linus to pull from the mips tree ?

Ivan
