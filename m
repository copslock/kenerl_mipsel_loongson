Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2005 20:34:35 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:62990 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225988AbVEZTeU>; Thu, 26 May 2005 20:34:20 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 9B0CBF59BD; Thu, 26 May 2005 21:34:12 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06418-02; Thu, 26 May 2005 21:34:12 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 53DB6F59B7; Thu, 26 May 2005 21:34:12 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j4QJYH7Q007728;
	Thu, 26 May 2005 21:34:17 +0200
Date:	Thu, 26 May 2005 20:34:28 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	maxim@mox.ru, linux-mips@linux-mips.org
Subject: Re: glibc-2.3.4 mips64 compilation failure
In-Reply-To: <20050526190554.GA16765@nevyn.them.org>
Message-ID: <Pine.LNX.4.61L.0505262023030.29423@blysk.ds.pg.gda.pl>
References: <6097c4905052609326a4c1232@mail.gmail.com> <20050526170603.GA13272@nevyn.them.org>
 <Pine.LNX.4.61L.0505261815330.29423@blysk.ds.pg.gda.pl>
 <20050526190554.GA16765@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/894/Wed May 25 14:53:16 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 26 May 2005, Daniel Jacobowitz wrote:

> >  Or too new, sigh...  See: 
> > "http://sources.redhat.com/bugzilla/show_bug.cgi?id=758".  Unfortunately 
> > it's not clear to me what "the 2.3 branch inclusion criteria" are and it's 
> > a pity the MIPS port of glibc is unmaintained these days...
> 
> He did post the criteria.  You can find them in the list archives
> though I don't have a URL handy.

 Well, the criteria probably don't change that much if at all from one 
stable branch to another, so having them somewhere at one of the GNU libc 
web pages (probably the sourceware's is the right one for such internal 
guidelines) wouldn't hurt, like it's done e.g. with GCC.  I can't recall 
if I tried searching the mailing list previously, but now "branch 
inclusion criteria" doesn't return anything, so even your hint isn't 
especially useful (and I don't want to spend my life digging the archives, 
sorry).  I'm somewhat surprised, actually, as I'm subscribed to the 
libc-alpha list for quite some time now, certainly since before the branch 
was created and I haven't noticed such an announcement.

> I'm hoping to improve the maintenance in the near future.

 Well, if you have resources for doing that, it will be most welcomed.

  Maciej
