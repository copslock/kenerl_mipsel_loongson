Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Oct 2004 13:17:05 +0100 (BST)
Received: from pD956212F.dip.t-dialin.net ([IPv6:::ffff:217.86.33.47]:53273
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225072AbUJVMQ7>; Fri, 22 Oct 2004 13:16:59 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i9MCGvQM028120;
	Fri, 22 Oct 2004 14:16:57 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i9MCGmHp028119;
	Fri, 22 Oct 2004 14:16:48 +0200
Date: Fri, 22 Oct 2004 14:16:48 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org
Subject: Re: kernel_thread creation bug?
Message-ID: <20041022121647.GA27961@linux-mips.org>
References: <20041022.170758.48799763.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022.170758.48799763.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 22, 2004 at 05:07:58PM +0900, Atsushi Nemoto wrote:

> With recent change in kernel_thread(), initial cp0_status value comes
> from current C0_STATUS (which does not include EXL bit).  Is this
> correct?  The initial value should contain EXL bit to start the thread
> up safely, shouldn't it?

Yes ...

  Ralf
