Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 01:00:00 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.206]:7103 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8134419AbWAJA7m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jan 2006 00:59:42 +0000
Received: by wproxy.gmail.com with SMTP id 36so65034wra
        for <linux-mips@linux-mips.org>; Mon, 09 Jan 2006 17:02:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mlQWPMnA3akhkZEApBJr2eMBLnHHoB5unlK5Vo82fmDQM6RIZbD5VTlUU6b1m6q0Hhgbm3NozKDrWcfjoxB2v7WQuGFGEedHpPJDwRrmlqNgwuXqbwW6UqZ6qkYLLN8F/q6kE6ZLbvlUY4hs8Q6vm7sUhOn18BQ7P4vXNB9ySsE=
Received: by 10.54.108.2 with SMTP id g2mr220355wrc;
        Mon, 09 Jan 2006 17:02:43 -0800 (PST)
Received: by 10.54.156.1 with HTTP; Mon, 9 Jan 2006 17:02:43 -0800 (PST)
Message-ID: <50c9a2250601091702g7e48c75br178868a3c91d48f4@mail.gmail.com>
Date:	Tue, 10 Jan 2006 09:02:43 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Cc:	"P. Christeas" <p_christ@hol.gr>, linux-mips@linux-mips.org
In-Reply-To: <20060109152429.GE4286@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
	 <20060109145610.GB4286@linux-mips.org>
	 <200601091720.03822.p_christ@hol.gr>
	 <20060109152429.GE4286@linux-mips.org>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

On 1/9/06, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Jan 09, 2006 at 05:20:01PM +0200, P. Christeas wrote:
>
> > > You've downloaded a kernel.org kernel it would seem - doesn't fly for MIPS.
> > > Instead get a kernel from linux-mips.org.
> > >
> > > The early_initcall() construct has been removed.
> > >
> > >   Ralf
> >
> > What's the difference between the trees?
>
> All the MIPS work is happening in the linux-mips.org tree.
>
> > Aren't the MIPS patches supposed to be merged to Linus' tree?
>
> In 2.6.15 things were alomst fully merged but several megabytes of
> patches are between the linux-mips.org and kernel.org versions of 2.6.14.
>
>   Ralf
>

in linux-mips, where to download the patches for standard kernel?

zhuzhenhua
