Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Jan 2006 11:13:32 +0000 (GMT)
Received: from p549F5FA9.dip.t-dialin.net ([84.159.95.169]:10085 "EHLO
	mail.linux-mips.net") by ftp.linux-mips.org with ESMTP
	id S8133382AbWAGLNH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 7 Jan 2006 11:13:07 +0000
Received: from fluff.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.4/8.13.1) with ESMTP id k07BFkOm032650;
	Sat, 7 Jan 2006 12:15:46 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.4/8.13.4/Submit) id k07BFewS032649;
	Sat, 7 Jan 2006 12:15:40 +0100
Date:	Sat, 7 Jan 2006 12:15:40 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Alex Gonzalez <langabe@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Jump/branch to external symbol
Message-ID: <20060107111540.GA30498@linux-mips.org>
References: <c58a7a270601060241u765acb76s61bb30d443c420f1@mail.gmail.com> <Pine.LNX.4.64N.0601061147540.25759@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0601061147540.25759@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jan 06, 2006 at 11:51:56AM +0000, Maciej W. Rozycki wrote:

> > solution for binutils-2.13.
> > 
> > Can anybody offer any help?
> 
>  Well, the most obvious solution is upgrading to the current release, 
> which is 2.16.1 now.  Otherwise you are probably on your own -- 2.15 is 
> already somewhat old and 2.13 is ancient.

Binutils 2.15 may crash when building particular configurations, so 2.15
is no longer acceptable for building the kernel.

  Ralf
