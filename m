Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2003 17:59:20 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:4345 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225232AbTBRR7T>;
	Tue, 18 Feb 2003 17:59:19 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h1IHxG324073;
	Tue, 18 Feb 2003 09:59:16 -0800
Date: Tue, 18 Feb 2003 09:59:16 -0800
From: Jun Sun <jsun@mvista.com>
To: Keith Owens <kaos@sgi.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [PATCH] REMOTE_DEBUG, DEBUG config cleanup
Message-ID: <20030218095916.K7466@mvista.com>
References: <20030213123108.V7466@mvista.com> <4706.1045353575@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4706.1045353575@ocs3.intra.ocs.com.au>; from kaos@sgi.com on Sun, Feb 16, 2003 at 10:59:35AM +1100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


The hope is some other arches might adopt it too.  How about
CONFIG_RUNTIME_DEBUG?

While we are on the subject, Ralf and I also are thinking to 
change CONFIG_REMOTE_DEBUG to CONFIG_KGDB.  Any objections?

Jun

On Sun, Feb 16, 2003 at 10:59:35AM +1100, Keith Owens wrote:
> On Thu, 13 Feb 2003 12:31:08 -0800, 
> Jun Sun <jsun@mvista.com> wrote:
> >Remove false dependency.  Add help info for CONFIG_DEBUG.
> >+Enable run-time debugging
> >+CONFIG_DEBUG
> >+  If you say Y here, some debugging macros will do run-time checking.
> >+  If you say N here, those macros will mostly turn to no-ops.  For
> >+  MIPS boards only.  See include/asm-mips/debug.h for debuging macros.
> >+  If unsure, say N.
> 
> CONFIG_DEBUG is too generic for an option that only applies to mips.
> Make it CONFIG_MIPS_DEBUG.
> 
