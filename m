Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jul 2005 18:18:49 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.199]:1549 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8226892AbVGSRSd> convert rfc822-to-8bit;
	Tue, 19 Jul 2005 18:18:33 +0100
Received: by zproxy.gmail.com with SMTP id s1so1197904nze
        for <linux-mips@linux-mips.org>; Tue, 19 Jul 2005 10:20:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hGlBxirc/tX5XzzL5NPKXJzVxehuyfzU3mSSAiMOyUs9RSCy8HdRC7QCizNlplSK49vXAB7/I5aR0F3spvOJaNeuhtHVPFUz12KsPG2m/Eq8mgOQ6EaYb8Ahy6j/1T5f8ZxBx5KOq/y14ausFZAJCsmsK0oAMwxCsOJF6+ShLbk=
Received: by 10.36.33.13 with SMTP id g13mr4534480nzg;
        Tue, 19 Jul 2005 10:19:49 -0700 (PDT)
Received: by 10.36.47.11 with HTTP; Tue, 19 Jul 2005 10:19:48 -0700 (PDT)
Message-ID: <f07e6e05071910194bab9b16@mail.gmail.com>
Date:	Tue, 19 Jul 2005 22:49:48 +0530
From:	Kishore K <hellokishore@gmail.com>
Reply-To: Kishore K <hellokishore@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: bal instruction in gcc 3.x
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050719164427.GB8758@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <f07e6e05071909301c212ab4@mail.gmail.com>
	 <20050719164427.GB8758@linux-mips.org>
Return-Path: <hellokishore@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8561
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hellokishore@gmail.com
Precedence: bulk
X-list: linux-mips

On 7/19/05, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Jul 19, 2005 at 10:00:20PM +0530, Kishore K wrote:
> 
> > We are facing a problem when U-boot is compiled with gcc 3.x
> >
> > U-boot  uses the following instruction in one of the files.
> >
> > bal jump_to_symbol
> >
> > This code gets compiled without any problem with gcc2. However, if I
> > compile the code
> > with gcc3, it exits with the error "Cannot branch to unknown symbol".
> >
> > What should we do to circumvent this problem ?
> >
> > I replaced
> >
> > bal jump_to_symbol
> >
> > by
> >
> > la t9, jump_to_symbol
> > jalr t9
> >
> > Then code gets compiled properly without any problem. Please let me
> > know, whether this
> > is correct way of fixing the problem. I am newbie to MIPS assembly
> > language. Why this
> > change is required with gcc 3.x compiler ?
> 
> FIrst of all, gcc doesn't care at all about your assembler code, that's
> the assembler which you must have changed along with that.
> 
> There used to be no relocation type to represent a branch to an external
> symbol in an ELF file which is why gas is throwing an error message, so
> gas is throwing an error message.  Latest gas fixed that shortcoming.
> I think there was a bug in somewhat older gas which resulted in such
> invalid code actually being accepted even though it shouldn't have been.
> 
>   Ralf

Thank you very much for the reply.

First of all code got compiled only after removing the option
-mips-allow-branch-to-undefined from Makefile. If this option is
included, compilation fails saying that option is invalid. I am using
binutils-2.14.90.06.
Same problem is observed even with binutils 2.15.94.0.2.2. 

Do you mean to say that no change is required in the code snippet 

bal jump_to_symbol

and code should get compiled with the latest assembler without any
problem. Please clearify.

TIA,
--kishore
