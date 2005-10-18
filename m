Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2005 12:45:53 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:49943 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133615AbVJRLpc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Oct 2005 12:45:32 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9IBjQGX012337;
	Tue, 18 Oct 2005 12:45:26 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9IBjQew012336;
	Tue, 18 Oct 2005 12:45:26 +0100
Date:	Tue, 18 Oct 2005 12:45:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	oprofile-list@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: Re: [Patch] Fix lookup_dcookie for MIPS o32
Message-ID: <20051018114526.GC2656@linux-mips.org>
References: <17236.6951.865559.479107@dl2.hq2.avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17236.6951.865559.479107@dl2.hq2.avtrex.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 17, 2005 at 02:44:07PM -0700, David Daney wrote:

> This patch fixes the lookup_dcookie for the MIPS o32 ABI.  Although I
> only tested with little-endian, the big-endian case needed fixing as
> well but is untested (but what are the chances that this is not the
> correct fix?).
> 
> This is the only patch I needed to get the user space oprofile
> programs to work for mipsel-linux.
> 
> I am CCing the linux-mips list as this may be of interest there as well.

Good catch.

> 2005-10-17  David Daney  <ddaney@avtrex.com>
> 
> 	* daemon/opd_cookie.c (lookup_dcookie): Handle MIPS o32 for both big
> 	and little endian.
> 
> Index: oprofile/daemon/opd_cookie.c
> ===================================================================
> RCS file: /cvsroot/oprofile/oprofile/daemon/opd_cookie.c,v
> retrieving revision 1.19
> diff -p -a -u -r1.19 opd_cookie.c
> --- oprofile/daemon/opd_cookie.c	26 May 2005 00:00:02 -0000	1.19
> +++ oprofile/daemon/opd_cookie.c	17 Oct 2005 21:29:13 -0000
> @@ -60,12 +60,21 @@
>  #endif /* __NR_lookup_dcookie */
>  
>  #if (defined(__powerpc__) && !defined(__powerpc64__)) || defined(__hppa__)\
> -	|| (defined(__s390__) && !defined(__s390x__))
> +	|| (defined(__s390__) && !defined(__s390x__)) \
> +	|| (defined(__mips__) && (_MIPS_SIM == _MIPS_SIM_ABI32) \
> +	    && defined(_MIPSEB))

Small nit - please use __MIPSEB__ rsp. __MIPSEL__; I think there are
some compilers floating around that don't define the single underscore
variant.

Thanks,

  Ralf
