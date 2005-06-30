Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 11:09:11 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.204]:7616 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8225722AbVF3KIy> convert rfc822-to-8bit;
	Thu, 30 Jun 2005 11:08:54 +0100
Received: by zproxy.gmail.com with SMTP id 13so54529nzn
        for <linux-mips@linux-mips.org>; Thu, 30 Jun 2005 03:08:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LHppA6lBCQk0aiBSwYteWlojxGxOyFegQHYFgB3+COLeCaF9PpDCUafCQGGP72dqbNINsMDQXwmqs/3SL7HP7EU54mALUUKNsAb5SZX78Z9ALL7n+JFmsDUl1qmRSJOIn+c3393mow5b46kBVS/mCMGWp/lwIJc2t1MzJu2DEBw=
Received: by 10.36.58.15 with SMTP id g15mr185067nza;
        Thu, 30 Jun 2005 03:08:32 -0700 (PDT)
Received: by 10.36.68.6 with HTTP; Thu, 30 Jun 2005 03:08:32 -0700 (PDT)
Message-ID: <6097c49050630030859b061c5@mail.gmail.com>
Date:	Thu, 30 Jun 2005 14:08:32 +0400
From:	Maxim Osipov <maxim.osipov@gmail.com>
Reply-To: maxim@mox.ru
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Popular MIPS4Kc boards?
Cc:	Krishna B S <bskris@gmail.com>, linux-mips@linux-mips.org
In-Reply-To: <20050630091056.GA2935@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1943a413050629014858a124f7@mail.gmail.com>
	 <20050630091056.GA2935@linux-mips.org>
Return-Path: <maxim.osipov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim.osipov@gmail.com
Precedence: bulk
X-list: linux-mips

And if we talk about fan project, are there any MIPS64 based devices on market?

Maxim

On 6/30/05, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Jun 29, 2005 at 02:18:40PM +0530, Krishna B S wrote:
> 
> > I have to develop toolchains for various MIPS boards my company
> > develops. All the boards consist of MIPS 4KC.
> >
> > I would like to know from you what is the most popular board used by
> > the community with this kind of processor. I know, its tough to get a
> > clear answer.
> >
> > But, my intention is to first port my toolchain/kernel for this
> > popular board so that I can get your support, in case I encounter any
> > problems. Having confirmed the working of the toolchain for this
> > board, I would port it to my company's boards.
> >
> > (The popular board in the community would be my reference board for
> > development.)
> 
> The price tag is juicy but for serious development with a 4Kc I'd
> recommend a MIPS Malta.  Forcing consumer hardware into submission may
> be a fun project for a spare time hacker but in general isn't a very
> productive process for somebody who needs to finish a job soon or needs
> to additional hardware such as PCI cards, logic analyzer, additional
> memory, other CPU types etc.
> 
>   Ralf
> 
>
