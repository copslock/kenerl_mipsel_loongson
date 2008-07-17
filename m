Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2008 06:18:07 +0100 (BST)
Received: from mo30.po.2iij.net ([210.128.50.53]:62523 "EHLO mo30.po.2iij.net")
	by ftp.linux-mips.org with ESMTP id S28582173AbYGQFSF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2008 06:18:05 +0100
Received: by mo.po.2iij.net (mo30) id m6H5HvEt075411; Thu, 17 Jul 2008 14:17:57 +0900 (JST)
Received: from rally.tokyo.tripeaks.co.jp (65.126.232.202.bf.2iij.net [202.232.126.65])
	by mbox.po.2iij.net (po-mbox300) id m6H5HriF002901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 17 Jul 2008 14:17:54 +0900
Message-Id: <200807170517.m6H5HriF002901@po-mbox300.hop.2iij.net>
Date:	Thu, 17 Jul 2008 14:19:24 +0900
From:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	yoichi_yuasa@tripeaks.co.jp, adaplas@pol.net,
	linux-fbdev-devel@lists.sourceforge.net, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH v3] add new Cobalt LCD framebuffer driver
In-Reply-To: <20080716173154.8cb87400.akpm@linux-foundation.org>
References: <20080715222751.86091a71.yoichi_yuasa@tripeaks.co.jp>
	<20080716173154.8cb87400.akpm@linux-foundation.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 2.3.0beta5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@tripeaks.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@tripeaks.co.jp
Precedence: bulk
X-list: linux-mips

On Wed, 16 Jul 2008 17:31:54 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Tue, 15 Jul 2008 22:27:51 +0900
> Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> 
> > I update cobalt_lcdfb driver.
> > 
> > v3
> > - fix read/write count boundary check.
> > - add <include/uaccess.h>.
> > - fix MODULE_AUTHOR.
> > 
> > v2
> > - add dpends MIPS_COBALT in Kconfig.
> > - add handling of signal_pending().
> > - check overflow of read/write count.
> > 
> > v1
> > - first release.
> 
> This driver has been merged into the subsystem tree for a long time and
> has been reviewed and has been perhaps tested by others.  Sending a
> complete new version of the entire thing is really quite an unfriendly
> act.  It basically invalidates all the review and test work which
> everyone else has done.
>
> This is why I will almost always turn replacement patches into
> incremental patches - so I can see what changed.  But that's only good
> for me.  Everyone else who is reading your new version won't bother
> doing that.
> 
> 
> So I generated the incremental patch and:
> 
> - The driver I have already includes linux/uaccess.h, so that change
>   was unneeded.
> 
> - The driver I have has already fixed the reject in
>   drivers/video/Makefile, so I get to fix it again, ho hum.
> 
> Here's what I ended up committing:
> 
>  drivers/video/Kconfig        |    2 +-
>  drivers/video/cobalt_lcdfb.c |   24 ++++++++++++++++++------
>  2 files changed, 19 insertions(+), 7 deletions(-)

OK.
If I update the driver to v4, I'll send the incremental patch.

Thanks a lot,

Yoichi
