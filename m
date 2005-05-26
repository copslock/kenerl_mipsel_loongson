Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 May 2005 21:33:58 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:44046 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225991AbVEZUdo>; Thu, 26 May 2005 21:33:44 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 394EBF59B4; Thu, 26 May 2005 22:33:32 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07063-01; Thu, 26 May 2005 22:33:32 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id F2D01F5998; Thu, 26 May 2005 22:33:31 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j4QKXbcP009844;
	Thu, 26 May 2005 22:33:37 +0200
Date:	Thu, 26 May 2005 21:33:49 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	maxim@mox.ru, linux-mips@linux-mips.org
Subject: Re: glibc-2.3.4 mips64 compilation failure
In-Reply-To: <20050526202415.GA19298@nevyn.them.org>
Message-ID: <Pine.LNX.4.61L.0505262125320.29423@blysk.ds.pg.gda.pl>
References: <6097c4905052609326a4c1232@mail.gmail.com> <20050526170603.GA13272@nevyn.them.org>
 <Pine.LNX.4.61L.0505261815330.29423@blysk.ds.pg.gda.pl>
 <20050526190554.GA16765@nevyn.them.org> <Pine.LNX.4.61L.0505262023030.29423@blysk.ds.pg.gda.pl>
 <20050526200804.GA18695@nevyn.them.org> <20050526201503.GA19015@nevyn.them.org>
 <Pine.LNX.4.61L.0505262118310.29423@blysk.ds.pg.gda.pl>
 <20050526202415.GA19298@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/894/Wed May 25 14:53:16 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 26 May 2005, Daniel Jacobowitz wrote:

> HEAD does work, however.  I will even get around to the MIPS64 NPTL
> bits for HEAD very soon.

 Hmm, has #933 been applied to HEAD?  Apparently not.  I have more stuff 
to come that's less obvious, but what's the point if even basic one is 
stuck?  I put such bits at my FTP site of course, so that people can still 
benefit.

  Maciej
