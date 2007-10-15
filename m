Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2007 19:28:16 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:40163 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037422AbXJOS2N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 Oct 2007 19:28:13 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9FISC6o021216;
	Mon, 15 Oct 2007 19:28:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9FISBST021215;
	Mon, 15 Oct 2007 19:28:11 +0100
Date:	Mon, 15 Oct 2007 19:28:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix aliasing bug in copy_user_highpage, take 2.
Message-ID: <20071015182811.GA20157@linux-mips.org>
References: <S20036863AbXJOPrf/20071015154735Z+80955@ftp.linux-mips.org> <20071016.023125.59033711.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071016.023125.59033711.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17051
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 16, 2007 at 02:31:25AM +0900, Atsushi Nemoto wrote:

> On Mon, 15 Oct 2007 16:47:30 +0100, linux-mips@linux-mips.org wrote:
> > Turns out 6a36458d9348265327d074bdd40bfb1c5b6fb2cb  wasn't quite right.
> > When called for a page that isn't marked dirty it would artificially
> > create an alias instead of doing the obvious thing and access the page
> > via KSEG0.
> > 
> > The same issue also exists in copy_to_user_page and copy_from_user_page
> > which was causing the machine to die under rare circumstances for example
> > when running ps if the BUG_ON() assertion added by the earlier fix was
> > getting triggered.
> 
> This commit added a SetPageDcacheDirty() call for both
> copy_to_user_page() and copy_from_user_page().  The call in
> copy_from_user_page() is really needed?

After copy_from_user_page the page will reside in the D-cache.  So just
in case it ever gets mapped to userspace and modified there we better
make sure its kernel address will get flushed before mapping it to user
space.  If not, we might see stale data if the page got modified under
its userspace address.

  Ralf
