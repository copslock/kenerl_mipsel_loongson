Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 09:50:02 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:40970 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226122AbVGAItr>; Fri, 1 Jul 2005 09:49:47 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1B36FE1C8A; Fri,  1 Jul 2005 10:49:35 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26253-10; Fri,  1 Jul 2005 10:49:34 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id BABF4E1C78; Fri,  1 Jul 2005 10:49:34 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j618nZdd008825;
	Fri, 1 Jul 2005 10:49:36 +0200
Date:	Fri, 1 Jul 2005 09:49:39 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	"Stephen P. Becker" <geoman@gentoo.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Bryan Althouse <bryan.althouse@3phoenix.com>,
	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Seg fault when compiled with -mabi=64 and -lpthread
In-Reply-To: <20050701035105.GA9601@nevyn.them.org>
Message-ID: <Pine.LNX.4.61L.0507010940280.30138@blysk.ds.pg.gda.pl>
References: <20050630173409Z8226102-3678+735@linux-mips.org>
 <20050630202111.GC3245@linux-mips.org> <20050630210357.GA23456@nevyn.them.org>
 <42C46D85.9050104@gentoo.org> <20050701035105.GA9601@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/962/Fri Jul  1 07:19:05 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 30 Jun 2005, Daniel Jacobowitz wrote:

> > Hmm, well with respect to my problem, I'm using a pretty recent
> > toolchain, with gcc 3.4.4, binutils-2.16.1, glibc-2.3.5, and headers
> > from a linux-mips 2.6.11 snapshot.  Interestingly, I tried to reproduce
> > Bryan's segfault, but could not.  That code ran without error when I
> > linked with libpthread.  Any thoughts?
> 
> I don't think glibc 2.3.5 worked for mips64.  But I haven't checked it
> in a long time.  Try CVS HEAD of glibc instead.

 Well, I tried a few trivial programs that use libpthread in my (n)64 
environment, which is based on 2.3.5, and they worked just fine.  They 
could have bin as simple as `ls', but as I have seen in the original 
report you do not have to make extensive use of the library to trigger 
problematic behaviour.

 Though it can be related to patches I have applied, me having built glibc 
with GCC 4.0.0 or perhaps it only happens for BE...

> Other than that, you're on your own - building glibc is extremely error
> prone.

 And you may need external patches as glibc is (effectively) not 
maintained.

  Maciej
