Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Apr 2004 02:34:17 +0100 (BST)
Received: from p508B630B.dip.t-dialin.net ([IPv6:::ffff:80.139.99.11]:41272
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225780AbUD3BeQ>; Fri, 30 Apr 2004 02:34:16 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id i3U1YBxT031210;
	Fri, 30 Apr 2004 03:34:11 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.8/8.12.8/Submit) id i3U1YAZO031209;
	Fri, 30 Apr 2004 03:34:10 +0200
Date: Fri, 30 Apr 2004 03:34:10 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux-mips@linux-mips.org,
	CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Subject: Re: CONFIG_XIP_ROM vs. CONFIG_XIP_KERNEL
Message-ID: <20040430013410.GA29246@linux-mips.org>
References: <40915265.2050906@am.sony.com> <20040429200927.GB20401@linux-mips.org> <40916C15.7000500@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40916C15.7000500@am.sony.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4930
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 29, 2004 at 01:56:53PM -0700, Tim Bird wrote:

> Well this is interesting.  One the architectures where this is supported
> in my tree is MIPS.  I'm looking at the CELF source tree. The patch for
> this was submitted to me by Toshiba.  I had assumed (based on some other
> indications) that they were submitting stuff to me that they had already
> submitted to kernel.org or to the MIPS list.  This appears not to be
> the case.
> 
> We should discuss this.  I have some patches for MIPS stuff in the
> CELF tree from MontaVista, Toshiba, and NEC.   Unfortunately, the
> CELF tree is based on Linux 2.4.20, so I don't know how much of it,
> if any, would be useful to you.

Depends.  The linux-mips.org tree is at 2.4.26.  Some areas have changed
significantly since 2.4.20, some not at all.  If you want to send patches
please make sure they still apply to the latest kernel.

> How do I proceed with finding out what's interesting, and how to get
> it to you?  Just post some stuff (even if old) to the mips mailing
> list?  Request the originator to do such a post?  Do things need to
> be migrated to 2.6?

Preferably yes.  I don't really care who sends the patch as long as the
sender takes responsibility also after the initial submission.

Any new features preferably for 2.6.

>  Could we bypass that for a casual "is this interesting" review?  Etc.

If all you need is a comment, sure.

> The questions are endless.
> Let me know what you think.
> 
> And, BTW, in my tree the variable used for MIPS is CONFIG_XIP_ROM.
> For SH, it's CONFIG_XIP_KERNEL, and for ARM, it has conditionals
> for both, but only defines CONFIG_XIP_ROM in the config.in!

In the kernel.org kernel the only references to these symbols are to
CONFIG_XIP_KERNEL in a few files under arch/arm26.

  Ralf
