Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2005 06:29:33 +0000 (GMT)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:50571 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8133476AbVKWG3G (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 Nov 2005 06:29:06 +0000
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 4405BC058;
	Wed, 23 Nov 2005 07:31:44 +0100 (CET)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id AB6091BC08D;
	Wed, 23 Nov 2005 07:31:45 +0100 (CET)
Received: from orionlinux.starfleet.com (cmb58-52.dial-up.arnes.si [153.5.49.52])
	by smtp.triera.net (Postfix) with ESMTP id 101B51A18AB;
	Wed, 23 Nov 2005 07:31:41 +0100 (CET)
Subject: Re: [PATCH] Fix board type in db1x00
From:	Matej Kupljen <matej.kupljen@ultra.si>
To:	Dan Malek <dan@embeddedalley.com>
Cc:	Jordan Crouse <jordan.crouse@amd.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
In-Reply-To: <6dabaec28e238ccc915f20f51ee28327@embeddedalley.com>
References: <20051122221526.GZ18119@cosmic.amd.com>
	 <6dabaec28e238ccc915f20f51ee28327@embeddedalley.com>
Content-Type: text/plain
Organization: Ultra d.o.o.
Date:	Wed, 23 Nov 2005 07:31:37 +0100
Message-Id: <1132727497.10318.8.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Triera AV Service
Return-Path: <matej.kupljen@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matej.kupljen@ultra.si
Precedence: bulk
X-list: linux-mips

Hi

> > +	/* Set the platform # */
> > +#if	defined (CONFIG_MIPS_DB1550)
> > +	mips_machtype = MACH_DB1550;
> > +#elif	defined (CONFIG_MIPS_DB1500)
> > +	mips_machtype = MACH_DB1500;
> > +#elif	defined (CONFIG_MIPS_DB1100)
> > +	mips_machtype = MACH_DB1100;
> > +#else
> > +	mips_machtype = MACH_DB1000;
> > +#endif
> 
> Can't we just do something like
> 	#define MACH_ALCHEMY_TYPE  xxxxx
> 
> in the include files and not have this mess in the
> actual code?  Then, all we have to do here is:
> 
> 	mips_machtype = MACH_ALCHEMY_TYPE;

I prefer Dan's suggestion, if it counts.

And please, don't forget about DB1200 board also.
I already sent some minor patches, but they didn't
get in :(

BR,
Matej
