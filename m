Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jul 2005 09:40:28 +0100 (BST)
Received: from rproxy.gmail.com ([IPv6:::ffff:64.233.170.206]:9439 "EHLO
	rproxy.gmail.com") by linux-mips.org with ESMTP id <S8226317AbVGFIkK> convert rfc822-to-8bit;
	Wed, 6 Jul 2005 09:40:10 +0100
Received: by rproxy.gmail.com with SMTP id y7so1104456rne
        for <linux-mips@linux-mips.org>; Wed, 06 Jul 2005 01:40:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tYMHqrRptDDxaNoN0gotQ0DeJzgbO0MQfwgpCH4BFhU7czL5bSy2GaKwTUi6NcAzijnjOCkykfl8Xw6cKNSpzZ5CHZAhhCAS6kc3atEDTIRPNi2q0CO5HCGHKYyqeTIGUAc9r7jpVfvNs7+KzJvDDxHCKW3BduZJTIw1qsI8cW4=
Received: by 10.38.181.12 with SMTP id d12mr4802088rnf;
        Wed, 06 Jul 2005 01:40:32 -0700 (PDT)
Received: by 10.38.104.78 with HTTP; Wed, 6 Jul 2005 01:40:32 -0700 (PDT)
Message-ID: <dbce930205070601407c8ce6a4@mail.gmail.com>
Date:	Wed, 6 Jul 2005 04:40:32 -0400
From:	David Cummings <real.psyence@gmail.com>
Reply-To: David Cummings <real.psyence@gmail.com>
To:	linux-mips@linux-mips.org,
	"Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Subject: Re: broken ip27 kernel
In-Reply-To: <dbce930205070523316dd9954b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <dbce930205070518422c21be21@mail.gmail.com>
	 <42CB5908.7030005@total-knowledge.com>
	 <dbce930205070523316dd9954b@mail.gmail.com>
Return-Path: <real.psyence@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: real.psyence@gmail.com
Precedence: bulk
X-list: linux-mips

Ok, the patch difficulty was my fault. With latest cvs source and the
20050703.diff applied, I can build a kernel, arcload and arcs itself
can both load said kernel, but I receive no output on the console. If
I drop out to a MSC console, it is in one of either POD MSC Dex or Unc
depending on kernel(and time perhaps?). I feel like I am missing
something, like console support or something. Thanks again...

On 7/6/05, David Cummings <real.psyence@gmail.com> wrote:
> I can boot your kernel, Ilya, just fine. I'd really like it to be able
> to boot from sda1, so my config takes out nfsroot. I am using the
> newest checkout from cvs, but I am having trouble applying your diff.
> Either the Makefile and others have changed dramatically, or I am
> using an incorrect command to patch. Thanks for any info,
> -Dave
> 
> On 7/6/05, Ilya A. Volynets-Evenbakh <ilya@total-knowledge.com> wrote:
> > http://www.total-knowledge.com/progs/mips/kernels
> > contains compiled kernel as of few days ago, as well as diff I used.
> > It runs just fin on my Origin2000 and was reported to run on O200 as well.
> >
> > David Cummings wrote:
> >
> > >Hello all,
> > >   I have recently compiled kernel from cvs-source that will load from
> > >arcload, but after "Entering Kernel" the machine hangs and the MSC
> > >appears to be in a POD dex mode. I would  like to know if anyone is
> > >familiar with this and if it's just a patch I'm missing or something.
> > >Thanks
> > >-Dave
> > >
> > >
> >
> > --
> > Ilya A. Volynets-Evenbakh
> > Total Knowledge. CTO
> > http://www.total-knowledge.com
> >
> >
> 
> 
> --
> The way that can be named is not the Way.
> 


-- 
The way that can be named is not the Way.
