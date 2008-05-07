Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2008 00:05:05 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:1007 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20023276AbYEGXFC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 May 2008 00:05:02 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m47N4xai031430;
	Thu, 8 May 2008 01:04:59 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m47N4td5031425;
	Thu, 8 May 2008 00:04:59 +0100
Date:	Thu, 8 May 2008 00:04:54 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
cc:	Ralf Baechle <ralf@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix divide by zero error in build_clear_page and
 build_copy_page
In-Reply-To: <200805072238.m47MbxbZ022160@po-mbox303.hop.2iij.net>
Message-ID: <Pine.LNX.4.55.0805080003120.31409@cliff.in.clinika.pl>
References: <20080507233815.e6de28da.yoichi_yuasa@tripeaks.co.jp>
 <Pine.LNX.4.55.0805071712520.25644@cliff.in.clinika.pl>
 <200805072238.m47MbxbZ022160@po-mbox303.hop.2iij.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19143
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 8 May 2008, Yoichi Yuasa wrote:

> >  Why would ever cache_line_size be zero in this place?  Are you trying to 
> > support a cacheless CPU?  If not, it should be a BUG_ON().
> > 
> 
> When CPU has no prefetch, no cache cdex_s and no caache cdex_p, cache_line_size is zero.
> I confirmed it with Nevada(Cobalt server) and VR41xx.

 Fair enough.  I confused the variable with some others used to store the
actual line size of each of the caches.  Your change is correct, thank you
and sorry about the noise.

  Maciej
