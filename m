Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1BI8ag07288
	for linux-mips-outgoing; Mon, 11 Feb 2002 10:08:36 -0800
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1BI8V907282
	for <linux-mips@oss.sgi.com>; Mon, 11 Feb 2002 10:08:31 -0800
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 16aJwL-0005gu-00; Mon, 11 Feb 2002 18:08:29 +0100
Date: Mon, 11 Feb 2002 18:08:29 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@oss.sgi.com
Subject: Re: gcc include strangeness
Message-ID: <20020211180829.A21744@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020209150155.GA853@paradigm.rfc822.org> <Pine.GSO.3.96.1020211134516.18917A-100000@delta.ds2.pg.gda.pl> <20020211135302.GB30314@paradigm.rfc822.org> <20020211142708.GA2577@convergence.de> <20020211153732.GA31248@paradigm.rfc822.org> <20020211165325.GB3261@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020211165325.GB3261@convergence.de>; from js@convergence.de on Mon, Feb 11, 2002 at 05:53:25PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 11, 2002 at 05:53:25PM +0100, Johannes Stezenbach wrote:
> On Mon, Feb 11, 2002 at 04:37:32PM +0100, Florian Lohoff wrote:
> > On Mon, Feb 11, 2002 at 03:27:08PM +0100, Johannes Stezenbach wrote:
> > > 
> > > The glibc-2.2.5/FAQ says:
> > >   1.20.   Which tools should I use for MIPS?
> > > 
> > >   {AJ} You should use the current development version of gcc 3.0 or newer from
> > >   CVS.  gcc 2.95.x does not work correctly on mips-linux.
> > > 
> > 
> > Its not about gcc development but rather keeping a distribution in
> > sync. All Debian archs try to use the same compiler which is currently
> > 2.95.4 which we are happy with right now - Except some minor issues
> > breaking 2-3 Packages ...
> 
> So does this mean that Debian's gcc 2.95.4 works on MIPS?
The whole distribution is compiled with 2.95.4.

> Does it include patches which are not in CVS (gcc-2_95-branch)?
Yes. See the debian/patches directory after unpacking the
source-package.
 -- Guido
