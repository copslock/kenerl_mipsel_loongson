Received:  by oss.sgi.com id <S553929AbRBUAZJ>;
	Tue, 20 Feb 2001 16:25:09 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:1531 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553788AbRBUAYx>;
	Tue, 20 Feb 2001 16:24:53 -0800
Received: from mvista.com (IDENT:ppopov@zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f1L0Km824721;
	Tue, 20 Feb 2001 16:20:48 -0800
Message-ID: <3A930AB3.3AEAE5BF@mvista.com>
Date:   Tue, 20 Feb 2001 16:24:19 -0800
From:   Pete Popov <ppopov@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i586)
X-Accept-Language: en, bg
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     David Jez <dave.jez@seznam.cz>, ppopov@pacbell.net,
        linux-mips@oss.sgi.com
Subject: Re: redhat 7.0
References: <3A901B3F.ADADC601@pacbell.net> <20010220074903.A68652@stud.fee.vutbr.cz> <20010220215616.F2086@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Tue, Feb 20, 2001 at 07:49:04AM +0100, David Jez wrote:
> 
> > > Has anyone tried installing 7.0 that's on oss.sgi.com?  The problem I'm
> > > running into is that after I netboot and mount simple-0.2b as the root
> > > fs, and install the rpm-4.0 tarball, rpm doesn't work with the
> > > libraries, or lack of, of that root fs.  It looks like I need an fs with
> > > a working rpm-4.0, so that I can mount my second disk somewhere and
> > > install the 7.0 packages.  Any suggestions?
> > Yes,
> > If you download rpm-3.0 (I'm not sure, try get newer version) you'll should
> > be able to work with rpm 4 packages.
> 
> Oss has a tarball with statically linked rpm 4 binaries.  Use that to
> convert your rpm database and then install the rpm 4 rpm package for real.

I tried that; "rpm --rebuilddb" failed because it couldn't find some
library.  I'll try again.

Pete
