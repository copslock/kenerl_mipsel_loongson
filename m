Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 May 2004 23:58:16 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:49652 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225397AbUEGW6P>;
	Fri, 7 May 2004 23:58:15 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i47MwCx6014472;
	Fri, 7 May 2004 15:58:12 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i47MwBZL014470;
	Fri, 7 May 2004 15:58:11 -0700
Date: Fri, 7 May 2004 15:58:11 -0700
From: Jun Sun <jsun@mvista.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: MIPS status in 2.6
Message-ID: <20040507155811.B9702@mvista.com>
References: <409C0960.3080604@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <409C0960.3080604@am.sony.com>; from tim.bird@am.sony.com on Fri, May 07, 2004 at 03:10:40PM -0700
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Fri, May 07, 2004 at 03:10:40PM -0700, Tim Bird wrote:
> Anyone know what the status is of MIPS support in 2.6?
> 

32bit has been working pretty well, including preemption, kgdb,
SMP, etc.  IO subsystems have not been thoroughly tested.  Board support
varies.

64bit needs some work.

Jun
