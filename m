Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 22:16:55 +0100 (BST)
Received: from exchange.mabuhaynetworks.com ([IPv6:::ffff:206.169.233.186]:23152
	"EHLO exchange.vivato.net") by linux-mips.org with ESMTP
	id <S8225193AbTGWVQw> convert rfc822-to-8bit; Wed, 23 Jul 2003 22:16:52 +0100
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Cross Compilation
Date: Wed, 23 Jul 2003 14:16:45 -0700
Message-ID: <D8B86D9BB607124BA1D54EDB7944DB0B013D452F@exchange.mabuhay>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Cross Compilation
Thread-Index: AcNRSCgnA3dsRI75Rbmxupity8AE+wAF1xAQ
From: "Jim Thompson" <jimt@vivato.net>
To: <baitisj@evolution.com>, "Jun Sun" <jsun@mvista.com>
Cc: "Tiemo Krueger - mycable GmbH" <tk@mycable.de>,
	<saravana_kumar@naturesoft.net>, <linux-mips@linux-mips.org>
Return-Path: <jimt@vivato.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jimt@vivato.net
Precedence: bulk
X-list: linux-mips

One more time, the current top-of-tree on 'buildroot' is broken.

Specifically, the 'chew' binary gets built for the target, but should be
built for the host.  The build fails when 'chew' gets run (because it
can't).

Erik is looking for a patch.

Jim


> -----Original Message-----
> From: Jeff Baitis [mailto:baitisj@evolution.com]
> Sent: Wednesday, July 23, 2003 11:27 AM
> To: Jun Sun
> Cc: Tiemo Krueger - mycable GmbH; saravana_kumar@naturesoft.net;
linux-
> mips@linux-mips.org
> Subject: Re: Cross Compilation
> 
> I find that the uClibC tools are excellent, and have no problems
> generating
> MIPS binaries from an i386 host ;)
> 
> -Jeff
> 
> On Wed, Jul 23, 2003 at 10:09:46AM -0700, Jun Sun wrote:
> > On Wed, Jul 23, 2003 at 09:45:43AM +0200, Tiemo Krueger - mycable
GmbH
> wrote:
> > > You could even use the buildroot thing from uclibc.org:
> > >
> > >
http://uclibc.org/cgi-bin/cvsweb/buildroot/buildroot.tar.gz?tarball=1
> > >
> > > It's one of the most simple way for cross toolchain beginners, it
> > > provides you finally with a toolchain and rootfile system and more
> > >
> >
> > I took a look.  It looks similar to one project that I worked on
> > before.   Very interesting.
> >
> > Has anybody tried successfully to do a cross MIPS yet?  From a
> Linux/i386 host
> > obviously ...
> >
> > Jun
> >
> 
> --
>          Jeffrey Baitis - Associate Software Engineer
> 
>                     Evolution Robotics, Inc.
>                      130 West Union Street
>                        Pasadena CA 91103
> 
>  tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com
> 
