Received:  by oss.sgi.com id <S553844AbRCGJGw>;
	Wed, 7 Mar 2001 01:06:52 -0800
Received: from mx.mips.com ([206.31.31.226]:10945 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553840AbRCGJGr>;
	Wed, 7 Mar 2001 01:06:47 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA20906;
	Wed, 7 Mar 2001 01:06:43 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA11045;
	Wed, 7 Mar 2001 01:06:41 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id KAA28493;
	Wed, 7 Mar 2001 10:06:15 +0100 (MET)
Message-ID: <3AA5FA06.D9D5277@mips.com>
Date:   Wed, 07 Mar 2001 10:06:14 +0100
From:   Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Pete Popov <ppopov@mvista.com>
CC:     Ralf Baechle <ralf@oss.sgi.com>, David Jez <dave.jez@seznam.cz>,
        ppopov@pacbell.net, linux-mips@oss.sgi.com
Subject: Re: redhat 7.0
References: <3A901B3F.ADADC601@pacbell.net> <20010220074903.A68652@stud.fee.vutbr.cz> <20010220215616.F2086@bacchus.dhis.org> <3A930AB3.3AEAE5BF@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Pete

Did you managed to get through the installation of the RedHat 7.0 packages ?
I would like to do something similar.

/Carsten

Pete Popov wrote:

> Ralf Baechle wrote:
> >
> > On Tue, Feb 20, 2001 at 07:49:04AM +0100, David Jez wrote:
> >
> > > > Has anyone tried installing 7.0 that's on oss.sgi.com?  The problem I'm
> > > > running into is that after I netboot and mount simple-0.2b as the root
> > > > fs, and install the rpm-4.0 tarball, rpm doesn't work with the
> > > > libraries, or lack of, of that root fs.  It looks like I need an fs with
> > > > a working rpm-4.0, so that I can mount my second disk somewhere and
> > > > install the 7.0 packages.  Any suggestions?
> > > Yes,
> > > If you download rpm-3.0 (I'm not sure, try get newer version) you'll should
> > > be able to work with rpm 4 packages.
> >
> > Oss has a tarball with statically linked rpm 4 binaries.  Use that to
> > convert your rpm database and then install the rpm 4 rpm package for real.
>
> I tried that; "rpm --rebuilddb" failed because it couldn't find some
> library.  I'll try again.
>
> Pete

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
