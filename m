Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2006 17:48:51 +0000 (GMT)
Received: from mra02.ch.as12513.net ([82.153.252.24]:13224 "EHLO
	mra02.ch.as12513.net") by ftp.linux-mips.org with ESMTP
	id S8133842AbWAFRse (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Jan 2006 17:48:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by mra02.ch.as12513.net (Postfix) with ESMTP id 936F8D4504;
	Fri,  6 Jan 2006 17:51:10 +0000 (GMT)
Received: from mra02.ch.as12513.net ([127.0.0.1])
 by localhost (mra02.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 29495-01-21; Fri,  6 Jan 2006 17:51:10 +0000 (GMT)
Received: from [192.168.1.212] (unknown [82.152.104.245])
	by mra02.ch.as12513.net (Postfix) with ESMTP id 8F099D45B3;
	Fri,  6 Jan 2006 17:51:09 +0000 (GMT)
Subject: Re: Jump/branch to external symbol
From:	Alex Gonzalez <linux-mips@packetvision.com>
Reply-To: linux-mips@alexgg.plus.com
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Alex Gonzalez <langabe@gmail.com>, linux-mips@linux-mips.org
In-Reply-To: <20060106145216.GA6849@nevyn.them.org>
References: <c58a7a270601060241u765acb76s61bb30d443c420f1@mail.gmail.com>
	 <Pine.LNX.4.64N.0601061147540.25759@blysk.ds.pg.gda.pl>
	 <20060106145216.GA6849@nevyn.them.org>
Content-Type: text/plain
Date:	Fri, 06 Jan 2006 17:50:20 +0000
Message-Id: <1136569820.9887.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <linux-mips@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@packetvision.com
Precedence: bulk
X-list: linux-mips

Thanks, that works. Somehow it didn't occurred to me to try it.
Alex 

On Fri, 2006-01-06 at 09:52 -0500, Daniel Jacobowitz wrote:
> On Fri, Jan 06, 2006 at 11:51:56AM +0000, Maciej W. Rozycki wrote:
> > On Fri, 6 Jan 2006, Alex Gonzalez wrote:
> > 
> > > I am happy with the patch for binutils-2.15, and I would need a
> > > solution for binutils-2.13.
> > > 
> > > Can anybody offer any help?
> > 
> >  Well, the most obvious solution is upgrading to the current release, 
> > which is 2.16.1 now.  Otherwise you are probably on your own -- 2.15 is 
> > already somewhat old and 2.13 is ancient.
> 
> Or better yet to trunk and you won't need any patches for this.
> 
