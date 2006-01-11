Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2006 11:07:16 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.205]:31897 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133429AbWAKLGz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Jan 2006 11:06:55 +0000
Received: by wproxy.gmail.com with SMTP id 71so126698wri
        for <linux-mips@linux-mips.org>; Wed, 11 Jan 2006 03:10:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gjDTX9iblrfg7cC2ZZ1IEQHMmRVGUFGGkjCjBvxpaV3356sImMbFhh2wMPbK2aLHgUqgmheTBMC6o6JoRQiPcrTzj922qst+wSU0lNVy8jZtA9gfUqfiyiRsa2FMfgpcEOHNgsI1224WartvbwVcMF0mCdyav2RzaOZ05DJ4Q80=
Received: by 10.54.72.5 with SMTP id u5mr798317wra;
        Wed, 11 Jan 2006 03:10:05 -0800 (PST)
Received: by 10.54.69.5 with HTTP; Wed, 11 Jan 2006 03:10:05 -0800 (PST)
Message-ID: <a59861030601110310gca74f54o@mail.gmail.com>
Date:	Wed, 11 Jan 2006 12:10:05 +0100
From:	Ivan Korzakow <ivan.korzakow@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Cc:	"P. Christeas" <p_christ@hol.gr>, linux-mips@linux-mips.org
In-Reply-To: <20060110215322.GA27577@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
	 <200601101757.45297.p_christ@hol.gr>
	 <a59861030601100838oa89ac84n@mail.gmail.com>
	 <200601101857.26978.p_christ@hol.gr>
	 <20060110215322.GA27577@linux-mips.org>
Return-Path: <ivan.korzakow@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ivan.korzakow@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/10, Ralf Baechle <ralf@linux-mips.org>:
> On Tue, Jan 10, 2006 at 06:57:24PM +0200, P. Christeas wrote:
>
> > > > You make sure you have the two trees and diff them.
> > > > They 're both in git and typically you could do that only using git.
> > >
> > > Have you ever tried what you're talking about or is it a guess ?
> > > For example, let's say that there's a bug introduced when merging
> > > Linus tree with mips branch. How do you easily "bisect" in order to do
> > > a binary seek of this bug ?
> >
> >  I was about to mention the git incompatibility as I gave you the first
> > answer. It's true what you say and I also find it annoying. That's why I use
> > Linus tree.
> > I cannot, though, complaint to Ralph about this practice. It seems that he has
> > done his best to preserve the CVS history of his tree. We can only thank him
> > for that. It is just a lot of work to trim the tree and make it
> > Linus-parallel.
> > There is also things that I don't know about git, so I won't jump to
> > conclusions yet (as to whether it is feasible to merge with Linus).
>
> It is possible to keep both Linus's and the lmo tree in the same
> repository with a _little_ care.  I do that all the time.  When compressed
> this will result in a bloat of just about 10-20MB.
>

It would be great to be a little bit more explicit by giving some
_little_ examples ! Why not enlighting us directly instead of being so
vague.

Thanks

Ivan
