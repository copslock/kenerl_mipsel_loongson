Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 14:19:47 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:60128 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20035104AbYFMNTo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jun 2008 14:19:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5DDJMZm030707;
	Fri, 13 Jun 2008 14:19:23 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5DDJJt7030688;
	Fri, 13 Jun 2008 14:19:19 +0100
Date:	Fri, 13 Jun 2008 14:19:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	yoichi_yuasa@tripeaks.co.jp, linux-mips@linux-mips.org
Subject: Re: [PATCH][MIPS] fix divide by zero error in build_clear_page and
	build_copy_page
Message-ID: <20080613131919.GA703@linux-mips.org>
References: <20080507233815.e6de28da.yoichi_yuasa@tripeaks.co.jp> <20080530.130721.41629284.nemoto@toshiba-tops.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080530.130721.41629284.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 30, 2008 at 01:07:21PM +0900, Atsushi Nemoto wrote:

> This change is wrong.  Please apply this on top of the patch.

Applied.

  Ralf
