Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 22:19:50 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:36595 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225388AbTLIWTt>;
	Tue, 9 Dec 2003 22:19:49 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id hB9MJek07169;
	Tue, 9 Dec 2003 14:19:40 -0800
Date: Tue, 9 Dec 2003 14:19:40 -0800
From: Jun Sun <jsun@mvista.com>
To: Brad Parker <brad@parker.boston.ma.us>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: to_tm() in kernel/time.c?
Message-ID: <20031209141940.A7038@mvista.com>
References: <200312092058.hB9Kw6t31608@p2.parker.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200312092058.hB9Kw6t31608@p2.parker.boston.ma.us>; from brad@parker.boston.ma.us on Tue, Dec 09, 2003 at 03:58:06PM -0500
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Dec 09, 2003 at 03:58:06PM -0500, Brad Parker wrote:
> 
> Can anyone tell me if to_tm() in kernel/time.c returns months as 0-11?
> (in the current mips tree, that is)
> 

It is 0-11.  See the code

        tm->tm_mon = i - 1;             /* tm_mon starts from 0 to 11 */

> I'm curious if the to_tm() in the ppc tree is the same as the to_tm()
> in the mips tree.  In the ppc tree it returns 1-12.
>

The routine was copied from PPC.  I think tm_mon is set to 0-11 so as to match
struct rtc_time usage when it is exported to userland.

I will check with PPC folks to see why they changed it.

Jun
