Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2008 09:49:32 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:43705 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023157AbYEIIt3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 May 2008 09:49:29 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m498nSiA019152;
	Fri, 9 May 2008 09:49:28 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m498nQib019129;
	Fri, 9 May 2008 09:49:26 +0100
Date:	Fri, 9 May 2008 09:49:26 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix divide by zero error in build_clear_page and
	build_copy_page
Message-ID: <20080509084926.GA14450@linux-mips.org>
References: <20080507233815.e6de28da.yoichi_yuasa@tripeaks.co.jp> <Pine.LNX.4.55.0805071712520.25644@cliff.in.clinika.pl> <200805072238.m47MbxbZ022160@po-mbox303.hop.2iij.net> <Pine.LNX.4.55.0805080003120.31409@cliff.in.clinika.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0805080003120.31409@cliff.in.clinika.pl>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, May 08, 2008 at 12:04:54AM +0100, Maciej W. Rozycki wrote:

> > >  Why would ever cache_line_size be zero in this place?  Are you trying to 
> > > support a cacheless CPU?  If not, it should be a BUG_ON().
> > > 
> > 
> > When CPU has no prefetch, no cache cdex_s and no caache cdex_p, cache_line_size is zero.
> > I confirmed it with Nevada(Cobalt server) and VR41xx.
> 
>  Fair enough.  I confused the variable with some others used to store the
> actual line size of each of the caches.  Your change is correct, thank you
> and sorry about the noise.

And I guess that means the variable should get a better name.

  Ralf
