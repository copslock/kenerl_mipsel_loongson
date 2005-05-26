Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2005 18:26:24 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:59142 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225978AbVEZR0I>; Thu, 26 May 2005 18:26:08 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8FDE4E1C7C; Thu, 26 May 2005 19:25:56 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 06876-04; Thu, 26 May 2005 19:25:56 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 5A2CAE1C79; Thu, 26 May 2005 19:25:56 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j4QHQ0Hr002689;
	Thu, 26 May 2005 19:26:01 +0200
Date:	Thu, 26 May 2005 18:26:10 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	maxim@mox.ru, linux-mips@linux-mips.org
Subject: Re: glibc-2.3.4 mips64 compilation failure
In-Reply-To: <20050526170603.GA13272@nevyn.them.org>
Message-ID: <Pine.LNX.4.61L.0505261815330.29423@blysk.ds.pg.gda.pl>
References: <6097c4905052609326a4c1232@mail.gmail.com> <20050526170603.GA13272@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/894/Wed May 25 14:53:16 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 26 May 2005, Daniel Jacobowitz wrote:

> > I am trying to build glibc-2.3.4 using binutils-2.15 and gcc-3.4.3
> > from ftp://ftp.linux-mips.org/pub/linux/mips/crossdev/i386-linux/mips64-linux.
> > Compilation fails with following messages:
> 
> Looks like your kernel headers are too old.

 Or too new, sigh...  See: 
"http://sources.redhat.com/bugzilla/show_bug.cgi?id=758".  Unfortunately 
it's not clear to me what "the 2.3 branch inclusion criteria" are and it's 
a pity the MIPS port of glibc is unmaintained these days...

  Maciej
