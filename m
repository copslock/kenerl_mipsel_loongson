Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2007 15:04:41 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:25802 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021944AbXITOEc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Sep 2007 15:04:32 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id B948740094;
	Thu, 20 Sep 2007 16:04:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id bHVUHeAc8cb6; Thu, 20 Sep 2007 16:04:19 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 0CC5540090;
	Thu, 20 Sep 2007 16:04:19 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l8KE4MK9010997;
	Thu, 20 Sep 2007 16:04:22 +0200
Date:	Thu, 20 Sep 2007 15:04:17 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Satyam Sharma <satyam@infradead.org>
cc:	Andrew Morton <akpm@linux-foundation.org>,
	Antonino Daplas <adaplas@pol.net>,
	linux-fbdev-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/video/pmag-ba-fb.c: Improve diagnostics
In-Reply-To: <alpine.LFD.0.999.0709201837160.17093@enigma.security.iitk.ac.in>
Message-ID: <Pine.LNX.4.64N.0709201445590.30788@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0709171736580.17606@blysk.ds.pg.gda.pl>
 <Pine.LNX.4.64N.0709181314300.9650@blysk.ds.pg.gda.pl>
 <20070919172412.725508d0.akpm@linux-foundation.org>
 <Pine.LNX.4.64N.0709201342160.30788@blysk.ds.pg.gda.pl>
 <alpine.LFD.0.999.0709201837160.17093@enigma.security.iitk.ac.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4349/Thu Sep 20 00:46:46 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hi Satyam,

> Firstly, "may be used uninitialized" can still be a bug.

 Of course -- essentially GCC cannot really figure out whether all the 
possible paths of execution include initialisation or not and complains 
just in case.

> Secondly, latest gcc is *horribly* buggy (and has been so for last several
> releases including 4.1, 4.2 and 4.3 -- 3.x was good). See:
> 
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=33327
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=18501
> 
> We'd been hurling all sorts of abuses on gcc for quite long (when it fails
> to detect these "false positive" cases), but now, it turns out it is quite
> easy to write *genuinely* buggy code that still won't get any warnings,
> neither the "is used" nor "may be used" one!

 GCC for MIPS used to be problematic enough elsewhere I do not want to 
turn back.  Even 4.0.x generates bad code, e.g. fs/partitions/msdos.c gets 
miscompiled for the big endianness (but not for the little one!).  
Compared to that some useless warnings are negligible.  This 4.1.2 version 
has triggered no problems with the kernel yet (though I suspect it is 
still so-so -- e.g. gmp gets miscompiled; which used to be fine with 
4.0.x, oddly enough).

> In short, there are three ways to fix these false positive warnings:
> 
> 1. Do nothing, there are enough "uninitialized variable" warnings anyway,
>    and hopefully, one day GCC would clean up its act.
> 
> 2. Use uninitialized_var() to shut it up (only if it's genuinely bogus).
> 
> 3. Do something like the following legendary patch [1]:
> 
> http://kegel.com/crosstool/crosstool-0.43/patches/linux-2.6.11.3/arch_alpha_kernel_srcons.patch
> 
> i.e., explicitly change the structure/logic of the function to make it
> obvious enough to gcc that the variable will not be used uninitialized.

 Perhaps preinitialising to an error value such as -EINVAL would be of 
more sense.  This way any error paths lacking initialisation are still 
reported as errors, even though the classification might be wrong.  In 
fact more exotic one might be chosen (the glibc manual has some nice 
proposals if none of these we currently define fits) so the mistake is 
more obvious.

  Maciej
