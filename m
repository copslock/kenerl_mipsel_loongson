Received:  by oss.sgi.com id <S553665AbRCGNCd>;
	Wed, 7 Mar 2001 05:02:33 -0800
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:6366 "EHLO
        mta6.snfc21.pbi.net") by oss.sgi.com with ESMTP id <S553655AbRCGNCF>;
	Wed, 7 Mar 2001 05:02:05 -0800
Received: from pacbell.net ([63.194.214.47])
 by mta6.snfc21.pbi.net (Sun Internet Mail Server sims.3.5.2000.01.05.12.18.p9)
 with ESMTP id <0G9T00C5OW6ABZ@mta6.snfc21.pbi.net>; Wed,
 7 Mar 2001 05:01:23 -0800 (PST)
Date:   Wed, 07 Mar 2001 05:01:07 -0800
From:   ppopov@pacbell.net
Subject: Re: redhat 7.0
To:     Carsten Langgaard <carstenl@mips.com>
Cc:     Pete Popov <ppopov@mvista.com>, Ralf Baechle <ralf@oss.sgi.com>,
        David Jez <dave.jez@seznam.cz>, linux-mips@oss.sgi.com
Message-id: <3AA63113.45430090@pacbell.net>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14-5.0 i686)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: bg, en
References: <3A901B3F.ADADC601@pacbell.net>
 <20010220074903.A68652@stud.fee.vutbr.cz>
 <20010220215616.F2086@bacchus.dhis.org> <3A930AB3.3AEAE5BF@mvista.com>
 <3AA5FA06.D9D5277@mips.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Carsten Langgaard wrote:
> 
> Hi Pete
> 
> Did you managed to get through the installation of the RedHat 7.0 packages ?
> I would like to do something similar.

I haven't had time to try again. I tried the debian 2_2 tar ball, went
through the partitioning and dvhtool exersize and managed to setup all
of that.  If I try RedHat 7.0 again and manage to install it before
someone else does, I'll send instructions. 


Pete


> Pete Popov wrote:
> 
> > Ralf Baechle wrote:
> > >
> > > On Tue, Feb 20, 2001 at 07:49:04AM +0100, David Jez wrote:
> > >
> > > > > Has anyone tried installing 7.0 that's on oss.sgi.com?  The problem I'm
> > > > > running into is that after I netboot and mount simple-0.2b as the root
> > > > > fs, and install the rpm-4.0 tarball, rpm doesn't work with the
> > > > > libraries, or lack of, of that root fs.  It looks like I need an fs with
> > > > > a working rpm-4.0, so that I can mount my second disk somewhere and
> > > > > install the 7.0 packages.  Any suggestions?
> > > > Yes,
> > > > If you download rpm-3.0 (I'm not sure, try get newer version) you'll should
> > > > be able to work with rpm 4 packages.
> > >
> > > Oss has a tarball with statically linked rpm 4 binaries.  Use that to
> > > convert your rpm database and then install the rpm 4 rpm package for real.
> >
> > I tried that; "rpm --rebuilddb" failed because it couldn't find some
> > library.  I'll try again.
> >
> > Pete
> 
> --
> _    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
> |\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
> | \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
>   TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
>                    Denmark             http://www.mips.com
