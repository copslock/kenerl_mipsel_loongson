Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Aug 2006 12:14:59 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:50362 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S20038543AbWHXLO6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 24 Aug 2006 12:14:58 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.7/8.13.4) with ESMTP id k7OBFJ09022203;
	Thu, 24 Aug 2006 12:15:19 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k7OBFFXh022202;
	Thu, 24 Aug 2006 12:15:15 +0100
Date:	Thu, 24 Aug 2006 12:15:15 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	nigel@mips.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
Message-ID: <20060824111515.GA4490@linux-mips.org>
References: <20060523.003424.104640954.anemo@mba.ocn.ne.jp> <20060824.003130.25910593.anemo@mba.ocn.ne.jp> <44EC87C9.8010402@mips.com> <20060824.101531.07643963.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824.101531.07643963.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 24, 2006 at 10:15:31AM +0900, Atsushi Nemoto wrote:

> On Wed, 23 Aug 2006 17:52:25 +0100, Nigel Stephens <nigel@mips.com> wrote:
> > Doesn't tlbidx need to be declared as a signed int, else the compiler
> > could optimize away this comparison.
> 
> You are right.  I'll fix it.  Thanks.

Your patch also still contains copy_user_page().  The only user of it used
to be copy_user_highpage() so after our rewrite it can go away.  I've
already applied both fixes to my working version of the patch.

Your patch only maps the source page.  I'm trying to map the destination
page also and I'm hitting a few issues with it.

  Ralf
