Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 16:49:21 +0100 (BST)
Received: from mx02.qsc.de ([213.148.130.14]:21406 "EHLO mx02.qsc.de")
	by ftp.linux-mips.org with ESMTP id S3465650AbVJSPtF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Oct 2005 16:49:05 +0100
Received: from port-195-158-177-190.dynamic.qsc.de ([195.158.177.190] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1ESGBI-0002a1-00; Wed, 19 Oct 2005 17:48:44 +0200
Received: from ths by hattusa.textio with local (Exim 4.54)
	id 1ESGBH-0007ij-Ug; Wed, 19 Oct 2005 17:48:43 +0200
Date:	Wed, 19 Oct 2005 17:48:43 +0200
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	David Daney <ddaney@avtrex.com>,
	oprofile-list@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: [Patch] Fix lookup_dcookie for MIPS o32
Message-ID: <20051019154843.GF5721@hattusa.textio>
References: <17236.6951.865559.479107@dl2.hq2.avtrex.com> <20051018114526.GC2656@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018114526.GC2656@linux-mips.org>
User-Agent: Mutt/1.5.11
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Oct 17, 2005 at 02:44:07PM -0700, David Daney wrote:
> 
> > This patch fixes the lookup_dcookie for the MIPS o32 ABI.  Although I
> > only tested with little-endian, the big-endian case needed fixing as
> > well but is untested (but what are the chances that this is not the
> > correct fix?).
> > 
> > This is the only patch I needed to get the user space oprofile
> > programs to work for mipsel-linux.
> > 
> > I am CCing the linux-mips list as this may be of interest there as well.
> 
> Good catch.
> 
> > 2005-10-17  David Daney  <ddaney@avtrex.com>
> > 
> > 	* daemon/opd_cookie.c (lookup_dcookie): Handle MIPS o32 for both big
> > 	and little endian.
> > 
> > Index: oprofile/daemon/opd_cookie.c
> > ===================================================================
> > RCS file: /cvsroot/oprofile/oprofile/daemon/opd_cookie.c,v
> > retrieving revision 1.19
> > diff -p -a -u -r1.19 opd_cookie.c
> > --- oprofile/daemon/opd_cookie.c	26 May 2005 00:00:02 -0000	1.19
> > +++ oprofile/daemon/opd_cookie.c	17 Oct 2005 21:29:13 -0000
> > @@ -60,12 +60,21 @@
> >  #endif /* __NR_lookup_dcookie */
> >  
> >  #if (defined(__powerpc__) && !defined(__powerpc64__)) || defined(__hppa__)\
> > -	|| (defined(__s390__) && !defined(__s390x__))
> > +	|| (defined(__s390__) && !defined(__s390x__)) \
> > +	|| (defined(__mips__) && (_MIPS_SIM == _MIPS_SIM_ABI32) \
> > +	    && defined(_MIPSEB))
> 
> Small nit - please use __MIPSEB__ rsp. __MIPSEL__; I think there are
> some compilers floating around that don't define the single underscore
> variant.

AFAIR it's the other way, some compilers fail to define __MIPSEB__ and/or
__MIPSEB but all have _MIPSEB.


Thiemo
