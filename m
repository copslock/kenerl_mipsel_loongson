Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2004 21:09:41 +0100 (BST)
Received: from p508B630B.dip.t-dialin.net ([IPv6:::ffff:80.139.99.11]:61492
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225748AbUD2UJi>; Thu, 29 Apr 2004 21:09:38 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3TK9VxT023875;
	Thu, 29 Apr 2004 22:09:31 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3TK9RZ8023874;
	Thu, 29 Apr 2004 22:09:27 +0200
Date: Thu, 29 Apr 2004 22:09:27 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.arm.linux.org.uk, linux-mips@linux-mips.org,
	linux-sh-ctl@m17n.org,
	CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Subject: Re: CONFIG_XIP_ROM vs. CONFIG_XIP_KERNEL
Message-ID: <20040429200927.GB20401@linux-mips.org>
References: <40915265.2050906@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40915265.2050906@am.sony.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4926
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 29, 2004 at 12:07:17PM -0700, Tim Bird wrote:

> I'm looking at some sources for kernel Execute-in-place (XIP).
> 
> I see references to CONFIG_XIP_ROM and CONFIG_XIP_KERNEL,
> in different architecture branches of the same kernel
> source tree.
> 
> Is this difference merely the result of inconsistent
> usage, or is there a functional difference between
> these two options?
> 
> I can imagine that CONFIG_XIP_ROM is intended only to
> handle XIP in ROM, and that CONFIG_XIP_KERNEL possibly
> handles additional cases like XIP in flash.  However,
> before jumping to that conclusion I thought I would
> ask if there is some intention behind the different
> config names.

Since you copied linux-mips - neither option is implemented for MIPS ...

  Ralf
