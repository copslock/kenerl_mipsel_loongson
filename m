Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2004 22:51:52 +0100 (BST)
Received: from fed1rmmtao05.cox.net ([IPv6:::ffff:68.230.241.34]:42210 "EHLO
	fed1rmmtao05.cox.net") by linux-mips.org with ESMTP
	id <S8225214AbUHDVvs>; Wed, 4 Aug 2004 22:51:48 +0100
Received: from opus ([68.107.143.141]) by fed1rmmtao05.cox.net
          (InterMail vM.6.01.03.02.01 201-2131-111-104-103-20040709)
          with ESMTP
          id <20040804215139.NGXX14278.fed1rmmtao05.cox.net@opus>;
          Wed, 4 Aug 2004 17:51:39 -0400
Date: Wed, 4 Aug 2004 14:51:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jun Sun <jsun@mvista.com>
Cc: Song Wang <wsonguci@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: 2.6 preemptive kernel on mips
Message-ID: <20040804215140.GP9235@smtp.west.cox.net>
References: <20040803192244.5889.qmail@web40002.mail.yahoo.com> <20040803124048.C1926@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803124048.C1926@mvista.com>
User-Agent: Mutt/1.5.6+20040523i
Return-Path: <trini@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5594
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: trini@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 03, 2004 at 12:40:48PM -0700, Jun Sun wrote:

> On Tue, Aug 03, 2004 at 12:22:44PM -0700, Song Wang wrote:
> > Hi,
> > 
> > Has anyone tried to enable kernel preemption on
> > Linux mips 2.6 kernel (mips32) and test it? If
> > so, which version does it work?
> > 
> > I tried on 2.6.3 and it didn't work.
> > 
> 
> Try the latest kernel.  I checked preemption around 2.6.5 time
> and I believe all the obvious problems are fixed then.
> 
> There are still some issues with both SMP and PREEMPT, but most
> people won't see them in normal cases.

MIPS or generic?  It's claimed, at least, that SMP&&PREEMPT have no
fatal, generic, issues now (I forget if that was the case around 2.6.5).

-- 
Tom Rini
http://gate.crashing.org/~trini/
