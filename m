Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 11:52:45 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.200]:35803 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133524AbWAZLw1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 11:52:27 +0000
Received: by zproxy.gmail.com with SMTP id l8so343786nzf
        for <linux-mips@linux-mips.org>; Thu, 26 Jan 2006 03:56:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tm0qxpvLiX6zW7HNTtFvxebz4twZ5DPLzQqtu50j/a0d9cjEqSGmLNq2LLJxBfS/h6zqTNsPXnWWS8MXFf72PO6O+0M6xKdY2uaIu+d3CfQ0AnnaQj635woVwVxgBcYAtgmPKbNn569lQaM2r+wWIh8v3IhL5ySUg+05480PJnw=
Received: by 10.37.13.24 with SMTP id q24mr1388465nzi;
        Thu, 26 Jan 2006 03:56:55 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Thu, 26 Jan 2006 03:56:54 -0800 (PST)
Message-ID: <cda58cb80601260356k74235508s@mail.gmail.com>
Date:	Thu, 26 Jan 2006 12:56:54 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <000b01c62259$535f0e10$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <20060125141424.GE3454@linux-mips.org>
	 <cda58cb80601250632r3e8f7b9en@mail.gmail.com>
	 <20060125150404.GF3454@linux-mips.org>
	 <cda58cb80601251003m6ba4379w@mail.gmail.com>
	 <43D7C050.5090607@mips.com>
	 <cda58cb80601260011r6136c3fq@mail.gmail.com>
	 <43D887BB.3030906@mips.com>
	 <cda58cb80601260047g78ffb52cr@mail.gmail.com>
	 <000b01c62259$535f0e10$10eca8c0@grendel>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/26, Kevin D. Kissell <kevink@mips.com>:
> > > Franck wrote:
> > > > Let's say that the 4KSC has "wsbh" instruction which is part of
> > > > MIPS32R2 instructrion set (I haven't checked it). The question is how
> > > > the 4KSC would use the SWAB optimizations since it doesn't define
> > > > CONFIG_CPU_MIPS32_R2  ? The 4KSC might not be the only one case...
> > >
> > > The 4KSc happens not to have the MIPS32R2 WSBH (is that pronounced
> > > "wasabi"? ;o) instruction, but it does have the MIPS32R2 ROTR, because
> > > it's part of the SmartMIPS ASE.  Our options here include:
> > >
> > > * Say "to heck with it" and deny the 4KSc use of the ROTR, and stay
> > >    with a "#ifdef CONFIG_CPU_MIPS32R2" conditional.
> > >
> > > * Define CONFIG_CPU_MIPS4KSC as an additional oddball CPU flag, and
> > >    make it "#if defined(CONFIG_CPU_MIPS32R2) || defined(CONFIG_CPU_MIPS4KSC)
> > >
> > > * Have an ASE-support flag, CONFIG_CPU_SMARTMIPS, which would cover both
> > >    the 4KSc and 4KSd.  In that case code using ROTR could be conditional on
> > >    #if defined(CPU_CONFIG_MIPS32R2) || defined(CONFIG_CPU_SMARTMIPS).
> > >
> > > I personally think that the third option is the cleanest and most conceptually
> > > correct, but I'm not the guy operationally responsible for maintaining
> > > that code.
> >
> > I think we will have to use second _and_ third options. I can't find
> > out an example, but since 4KSC has some MIPS32_R2 instructions it will
> > need to use some specific MIPS32_R2 code sometimes.
>
> You don't understand. There is nothing in the 4KSc that is not in the SmartMIPS ASE.
> The 4KSc implements MIPS32+SmartMIPS.  The 4KSd implementes MIPS32R2+SmartMIPS.
> You're getting confused because some elements of SmartMIPS made it into MIPS32R2.
> If we have a CONFIG_CPU_SMARTMIPS flag, there would be no need for a
> CONFIG_CPU_MIPS4KSC flag.
>

I think I was confused by your previous description of 4KSC:

"""
the 4KSc is a superset of MIPS32 which includes some, but not all
MIPS32R2 features (plus other stuff),
"""

I understood it like:
        The 4KSC implements MIPS32 + SmartMIPS + a_part_of(MIPS32R2)
But now you're saying:
        The 4KSC implements MIPS32 + SmartMIPS

I didn't understand that a_part_of(MIPS32R2) elements were part of the
SmartMIPS extension....

Thanks
--
               Franck
