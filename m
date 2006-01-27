Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 10:41:17 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.194]:62535 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133357AbWA0Kk7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 10:40:59 +0000
Received: by zproxy.gmail.com with SMTP id l8so584992nzf
        for <linux-mips@linux-mips.org>; Fri, 27 Jan 2006 02:45:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JZbwfcG99HHlQpvdWreVzVWwlpo4PakAfUyDdpUHJ9c9ZZRxoZVunqohrr/a7U242KWR9eKtbRxgMw9eG3QV6Y/fYO5cHv+aVZNlyUTHk7GWc5KDAbfpsv5AmaEgR6PT3QX4aaDnmczyM3Wy2Eiv7hAAHH38jJGJrn8p8SA7z48=
Received: by 10.36.108.12 with SMTP id g12mr2347993nzc;
        Fri, 27 Jan 2006 02:45:34 -0800 (PST)
Received: by 10.36.49.12 with HTTP; Fri, 27 Jan 2006 02:45:34 -0800 (PST)
Message-ID: <cda58cb80601270245g6273ce04k@mail.gmail.com>
Date:	Fri, 27 Jan 2006 11:45:34 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
Cc:	Nigel Stephens <nigel@mips.com>, linux-mips@linux-mips.org
In-Reply-To: <000b01c6232a$5ea81470$10eca8c0@grendel>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com>
	 <cda58cb80601260702wf781e70l@mail.gmail.com>
	 <005101c6228c$6ebfb0a0$10eca8c0@grendel> <43D8F000.9010106@mips.com>
	 <cda58cb80601260831i61167787g@mail.gmail.com>
	 <43D8FF16.40107@mips.com>
	 <cda58cb80601261002w6eb02249k@mail.gmail.com>
	 <43D93025.9040800@mips.com>
	 <cda58cb80601270103t1419117cq@mail.gmail.com>
	 <000b01c6232a$5ea81470$10eca8c0@grendel>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2006/1/27, Kevin D. Kissell <kevink@mips.com>:
> > > You could, but why not stick with -march=4ksd if that's your CPU of
> > > choice? It appears to result in  marginally smaller code even when using
> > > -Os, and should have (slightly) better performance than a generic
> > > mips32r2 kernel?
> >
> > Just to avoid a new CPU_4KSD definition in the kernel code as
> > suggested by Kevin. Basically all mips32r2 specific code is the same
> > as 4ksd specific code (except the code that deals with SmartMIPS
> > extension). So it can use CONFIG_CPU_MIPS32_R2 macro. But I was not
> > aware of -march=4ksd and -march=mips32r2 differences. Maybe now it is
> > needed to have a new CPU_4KSD definition ?
>
> Configuration hacks that are specific to a single core create cruft and
> maintenence problems.  As I said yesterday, I think we'd be much better
> off to have a CONFIG_CPU_MIPS_SMALL or some such option
> that could cause -Os to be used, allow branch-likelies, etc. The optimizations
> under discussion aren't at all specific to the 4KSd,

no some are. As we said previously:

        1/ sizeof(vmlinux-mips32r2-Os) > sizeof(vmlinux-4ksd-Os)
        2/ with -march=4ksd can do (slightly) better optimizations

> for every 4KSd embedded Linux platform there are several 4KEc platforms
> that would benefit from a smaller kernel footprint.
>

-Os can already be choosen by user in kernel configuration. Your
CONFIG_CPU_MIPS_SMALL option brings nothing more except that the user
is stuck with -Os option. BTW, I think it may be the default option in
the near future for mainline...

Thanks
--
               Franck
