Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 15:37:26 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.206]:49340 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133442AbWAJPhI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jan 2006 15:37:08 +0000
Received: by wproxy.gmail.com with SMTP id 71so3657227wri
        for <linux-mips@linux-mips.org>; Tue, 10 Jan 2006 07:40:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rlQw1LZMfLQvP6jpTs6worMMhgMxHbvrb3B64wCgAn76qajTJCK4RgkZdNmZBVMG9sgmVMcEwPgLUNDFMm91+4gqzxzrlWbOX9wS1ZUpoBnasu5LITNaqViLyKu8Ux+MZlGYV/8VHxcGrRbfjpTS7UD7wqs9M/6cZHF/Z9lMMK4=
Received: by 10.54.84.1 with SMTP id h1mr9604365wrb;
        Tue, 10 Jan 2006 07:40:12 -0800 (PST)
Received: by 10.54.69.5 with HTTP; Tue, 10 Jan 2006 07:40:12 -0800 (PST)
Message-ID: <a59861030601100740r432904d9o@mail.gmail.com>
Date:	Tue, 10 Jan 2006 16:40:12 +0100
From:	Ivan Korzakow <ivan.korzakow@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: why the early_initcall(au1x00_setup) do not work?
Cc:	zhuzhenhua <zzh.hust@gmail.com>, "P. Christeas" <p_christ@hol.gr>,
	linux-mips@linux-mips.org
In-Reply-To: <20060110141924.GA13779@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250601082159p238cacd6r930709da9305479e@mail.gmail.com>
	 <20060109145610.GB4286@linux-mips.org>
	 <200601091720.03822.p_christ@hol.gr>
	 <20060109152429.GE4286@linux-mips.org>
	 <50c9a2250601091702g7e48c75br178868a3c91d48f4@mail.gmail.com>
	 <20060110141924.GA13779@linux-mips.org>
Return-Path: <ivan.korzakow@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ivan.korzakow@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/10, Ralf Baechle <ralf@linux-mips.org>:
> On Tue, Jan 10, 2006 at 09:02:43AM +0800, zhuzhenhua wrote:
>
> > > In 2.6.15 things were alomst fully merged but several megabytes of
> > > patches are between the linux-mips.org and kernel.org versions of 2.6.14.
> > >
> > >   Ralf
> > >
> >
> > in linux-mips, where to download the patches for standard kernel?
>
> I don't publish such patches - but they're eassy to generate.
>
Could you be a bit more explicit about that "easy" way you generate them ?

Ivan
