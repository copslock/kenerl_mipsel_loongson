Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 16:55:44 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:20758 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S3465656AbVJSPz0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Oct 2005 16:55:26 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9JFtIp5017921;
	Wed, 19 Oct 2005 16:55:18 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9JFtHAL017920;
	Wed, 19 Oct 2005 16:55:17 +0100
Date:	Wed, 19 Oct 2005 16:55:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	David Daney <ddaney@avtrex.com>,
	oprofile-list@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: [Patch] Fix lookup_dcookie for MIPS o32
Message-ID: <20051019155517.GI2616@linux-mips.org>
References: <17236.6951.865559.479107@dl2.hq2.avtrex.com> <20051018114526.GC2656@linux-mips.org> <20051019154843.GF5721@hattusa.textio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051019154843.GF5721@hattusa.textio>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 19, 2005 at 05:48:43PM +0200, Thiemo Seufer wrote:
> Date:	Wed, 19 Oct 2005 17:48:43 +0200
> To:	Ralf Baechle <ralf@linux-mips.org>
> Cc:	David Daney <ddaney@avtrex.com>,
> 	oprofile-list@lists.sourceforge.net, linux-mips@linux-mips.org
> Subject: Re: [Patch] Fix lookup_dcookie for MIPS o32
> Content-Type: text/plain; charset=us-ascii
> From:	Thiemo Seufer <ths@networkno.de>
> 
> Ralf Baechle wrote:
> > On Mon, Oct 17, 2005 at 02:44:07PM -0700, David Daney wrote:
> > 
> > > This patch fixes the lookup_dcookie for the MIPS o32 ABI.  Although I
> > > only tested with little-endian, the big-endian case needed fixing as
> > > well but is untested (but what are the chances that this is not the
> > > correct fix?).
> > > 
> > > This is the only patch I needed to get the user space oprofile
> > > programs to work for mipsel-linux.
> > > 
> > > I am CCing the linux-mips list as this may be of interest there as well.
> > 
> > Good catch.
> > 
> > > 2005-10-17  David Daney  <ddaney@avtrex.com>
> > > 
> > > 	* daemon/opd_cookie.c (lookup_dcookie): Handle MIPS o32 for both big
> > > 	and little endian.
> > > 
> > > Index: oprofile/daemon/opd_cookie.c
> > > ===================================================================
> > > RCS file: /cvsroot/oprofile/oprofile/daemon/opd_cookie.c,v
> > > retrieving revision 1.19
> > > diff -p -a -u -r1.19 opd_cookie.c
> > > --- oprofile/daemon/opd_cookie.c	26 May 2005 00:00:02 -0000	1.19
> > > +++ oprofile/daemon/opd_cookie.c	17 Oct 2005 21:29:13 -0000
> > > @@ -60,12 +60,21 @@
> > >  #endif /* __NR_lookup_dcookie */
> > >  
> > >  #if (defined(__powerpc__) && !defined(__powerpc64__)) || defined(__hppa__)\
> > > -	|| (defined(__s390__) && !defined(__s390x__))
> > > +	|| (defined(__s390__) && !defined(__s390x__)) \
> > > +	|| (defined(__mips__) && (_MIPS_SIM == _MIPS_SIM_ABI32) \
> > > +	    && defined(_MIPSEB))
> > 
> > Small nit - please use __MIPSEB__ rsp. __MIPSEL__; I think there are
> > some compilers floating around that don't define the single underscore
> > variant.
> 
> AFAIR it's the other way, some compilers fail to define __MIPSEB__ and/or
> __MIPSEB but all have _MIPSEB.

None of these compilers would _ever_ have been able to compile a kernel
without the __*__ variant.

  Ralf
