Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2003 22:21:52 +0100 (BST)
Received: from p508B7344.dip.t-dialin.net ([IPv6:::ffff:80.139.115.68]:37774
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225374AbTINVVu>; Sun, 14 Sep 2003 22:21:50 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h8ELLkLT021588;
	Sun, 14 Sep 2003 23:21:46 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h8ELLkhQ021587;
	Sun, 14 Sep 2003 23:21:46 +0200
Date: Sun, 14 Sep 2003 23:21:46 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: rwhron@earthlink.net
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] version.h cleanup of arch/mips
Message-ID: <20030914212146.GB21051@linux-mips.org>
References: <20030914001453.GA27609@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914001453.GA27609@rushmore>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Sep 13, 2003 at 08:14:53PM -0400, rwhron@earthlink.net wrote:

> version.h is included in some files that don't need it.
> Removing the unnessary includes prevents extra compiles when
> version.h changes.  Patch against 2.6.0-test5-bk3.

Thanks, applied.

  Ralf
