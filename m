Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id QAA135138 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Jan 1998 16:02:44 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA29892 for linux-list; Thu, 15 Jan 1998 15:59:36 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA29882 for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 15:59:34 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA09042
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Jan 1998 15:59:33 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-21.uni-koblenz.de [141.26.249.21])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA11525
	for <linux@cthulhu.engr.sgi.com>; Fri, 16 Jan 1998 00:59:31 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id AAA07873;
	Fri, 16 Jan 1998 00:42:36 +0100
Message-ID: <19980116004236.53486@uni-koblenz.de>
Date: Fri, 16 Jan 1998 00:42:36 +0100
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: tsbogend@alpha.franken.de, linux@cthulhu.engr.sgi.com
Subject: Re: The world's worst RPM
References: <19980114215847.36294@alpha.franken.de> <199801142359.RAA07990@athena.nuclecu.unam.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199801142359.RAA07990@athena.nuclecu.unam.mx>; from Miguel de Icaza on Wed, Jan 14, 1998 at 05:59:27PM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 14, 1998 at 05:59:27PM -0600, Miguel de Icaza wrote:

> > hmm, to do this with only one src.rpm, we need a little support from
> > rpm. At the moment mips is defined for mipsel and mipseb. I would suggest,
> > that for .spec execution mips is defined for bot mipsel and mipseb, because 
> > there are changes, which work for both and we only need to seperate changes 
> > like that needed by ncompress.  Comments ? Does anybody how to do this ?
> 
> The code should be fixed to autoconfigure itself by using the
> __LITTLE_ENDIAN and __BIG_ENDIAN macros that are defined somewhere in
> /usr/include.  And ship the patch with this.

I actually have some patch ... somewhere on a disk ...

  Ralf
