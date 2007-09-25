Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 17:18:41 +0100 (BST)
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54989 "EHLO
	smtp2.linux-foundation.org") by ftp.linux-mips.org with ESMTP
	id S20022543AbXIYQSi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 17:18:38 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8PGIP74032049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Sep 2007 09:18:26 -0700
Received: from box (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id l8PGIOpX025850;
	Tue, 25 Sep 2007 09:18:24 -0700
Date:	Tue, 25 Sep 2007 09:18:24 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-mac: Driver model & phylib update
Message-Id: <20070925091824.ffbd0386.akpm@linux-foundation.org>
In-Reply-To: <20070925131817.GA28402@linux-mips.org>
References: <Pine.LNX.4.64N.0709191811040.24627@blysk.ds.pg.gda.pl>
	<20070921124409.7f3d122b.akpm@linux-foundation.org>
	<20070925131817.GA28402@linux-mips.org>
X-Mailer: Sylpheed 2.4.1 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Tue, 25 Sep 2007 14:18:17 +0100 Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Sep 21, 2007 at 12:44:09PM -0700, Andrew Morton wrote:
> 
> > >  A driver model and phylib update.
> > 
> > akpm:/usr/src/25> diffstat patches/git-net.patch | tail -n 1
> >  1013 files changed, 187667 insertions(+), 23587 deletions(-)
> > 
> > Sorry, but raising networking patches against Linus's crufty
> > old mainline tree just isn't viable at present.
> 
> Out of curiosity:
> 
> [ralf@denk linux-queue]$ git diff $(git merge-base master v2.6.23-rc8-mm1)..v2.6.23-rc8-mm1 | wc -cl
> 1046669 31900996
> [ralf@denk linux-queue]$ git diff $(git merge-base master v2.6.23-rc8-mm1)..v2.6.23-rc8-mm1 | diffstat | tail -1
>  6049 files changed, 573635 insertions(+), 207630 deletions(-)

A few years ago I thought it might slow down soon.

> [ralf@denk linux-queue]$ 
> 
> We're all a little too productive ;-)

s/prod/destr/
