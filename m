Received:  by oss.sgi.com id <S553771AbRCISzn>;
	Fri, 9 Mar 2001 10:55:43 -0800
Received: from boco.fee.vutbr.cz ([147.229.9.11]:44305 "EHLO boco.fee.vutbr.cz")
	by oss.sgi.com with ESMTP id <S553765AbRCISz3>;
	Fri, 9 Mar 2001 10:55:29 -0800
Received: from fest.stud.fee.vutbr.cz (fest.stud.fee.vutbr.cz [147.229.9.16])
	by boco.fee.vutbr.cz (8.11.3/8.11.3) with ESMTP id f29ItJt60238
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified OK);
	Fri, 9 Mar 2001 19:55:20 +0100 (CET)
Received: (from xjezda00@localhost)
	by fest.stud.fee.vutbr.cz (8.11.2/8.11.2) id f29It5H34487;
	Fri, 9 Mar 2001 19:55:05 +0100 (CET)
Date:   Fri, 9 Mar 2001 19:55:05 +0100
From:   David Jez <dave.jez@seznam.cz>
To:     Carsten Langgaard <carstenl@mips.com>
Cc:     ppopov@pacbell.net, Pete Popov <ppopov@mvista.com>,
        Ralf Baechle <ralf@oss.sgi.com>,
        David Jez <dave.jez@seznam.cz>, linux-mips@oss.sgi.com
Subject: Re: redhat 7.0
Message-ID: <20010309195505.C34241@stud.fee.vutbr.cz>
References: <3A901B3F.ADADC601@pacbell.net> <20010220074903.A68652@stud.fee.vutbr.cz> <20010220215616.F2086@bacchus.dhis.org> <3A930AB3.3AEAE5BF@mvista.com> <3AA5FA06.D9D5277@mips.com> <3AA63113.45430090@pacbell.net> <3AA76955.2819476F@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AA76955.2819476F@mips.com>; from carstenl@mips.com on Thu, Mar 08, 2001 at 12:13:25PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Carsten,

try this:

  1. install package rpm-3.0.5 from last rh-6.2 updates
  2. then install package rpm-4.0.4
  this may will be OK, because rpm-3.0.5 know rpm-4 packages format.

Try read this, but I'm afraid you will not understand:
http://www.linux.cz/lists/archive/linux/101281.html

good luck
Dave

> Please Ralf, could you help me here.
> I did the same as Pete describe below, and I got the same result.
> When I tried "rpm --rebuilddb" it fails because it couldn't find some libraries.
> The rpm-tarball contains a statically linked rpm binary, but rpmdb is dynamically
> linked, could you please provide me with a statically linked rpmdb binary, that would
> be great.
> > > Did you managed to get through the installation of the RedHat 7.0 packages ?
> > > I would like to do something similar.
> > > > > > > Has anyone tried installing 7.0 that's on oss.sgi.com?  The problem I'm
> > > > > > > running into is that after I netboot and mount simple-0.2b as the root
> > > > > > > fs, and install the rpm-4.0 tarball, rpm doesn't work with the
> > > > > > > libraries, or lack of, of that root fs.  It looks like I need an fs with
> > > > > > > a working rpm-4.0, so that I can mount my second disk somewhere and
> > > > > > > install the 7.0 packages.  Any suggestions?
> > > > > > Yes,
> > > > > > If you download rpm-3.0 (I'm not sure, try get newer version) you'll should
> > > > > > be able to work with rpm 4 packages.

-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@fest.stud.fee.vutbr.cz
---------=[ ~EOF ]=------------------------------------
