Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2004 20:40:54 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:37108 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224907AbUHCTku>;
	Tue, 3 Aug 2004 20:40:50 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i73Jemar002112;
	Tue, 3 Aug 2004 12:40:48 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i73Jemum002111;
	Tue, 3 Aug 2004 12:40:48 -0700
Date: Tue, 3 Aug 2004 12:40:48 -0700
From: Jun Sun <jsun@mvista.com>
To: Song Wang <wsonguci@yahoo.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: 2.6 preemptive kernel on mips
Message-ID: <20040803124048.C1926@mvista.com>
References: <20040803192244.5889.qmail@web40002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040803192244.5889.qmail@web40002.mail.yahoo.com>; from wsonguci@yahoo.com on Tue, Aug 03, 2004 at 12:22:44PM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5588
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Aug 03, 2004 at 12:22:44PM -0700, Song Wang wrote:
> Hi,
> 
> Has anyone tried to enable kernel preemption on
> Linux mips 2.6 kernel (mips32) and test it? If
> so, which version does it work?
> 
> I tried on 2.6.3 and it didn't work.
> 

Try the latest kernel.  I checked preemption around 2.6.5 time
and I believe all the obvious problems are fixed then.

There are still some issues with both SMP and PREEMPT, but most
people won't see them in normal cases.

Jun
