Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Apr 2003 19:17:22 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:44018 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224861AbTDQSRW>;
	Thu, 17 Apr 2003 19:17:22 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3HIHAk24000;
	Thu, 17 Apr 2003 11:17:10 -0700
Date: Thu, 17 Apr 2003 11:17:10 -0700
From: Jun Sun <jsun@mvista.com>
To: Dennis Castleman <DennisCastleman@oaktech.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: your mail
Message-ID: <20030417111710.F1642@mvista.com>
References: <56BEF0DBC8B9D611BFDB00508B5E2634102F10@TLEXMAIL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <56BEF0DBC8B9D611BFDB00508B5E2634102F10@TLEXMAIL>; from DennisCastleman@oaktech.com on Thu, Apr 17, 2003 at 10:53:57AM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Apr 17, 2003 at 10:53:57AM -0700, Dennis Castleman wrote:
> ALL
> 
> Anybody know the performance differences I can expect using a MIPS 5K core
> @250 Mhz in 64bit mode versus 32bit mode?
>

It really depends on the applications.  The biggest gain from 64bit,
other than the obviously bigger address space, is 64bit data
manipulation.  A single 64bit instruction (add/sub/...) is carried
out by several instructions in 32bit.

If your apps are heavy on 64bit operations, then you gain.
Otherwise I suspect no performance gain or even possibly a little 
worse performance due more stress on cache/memory subsystems.

I am sure others with more 64bit experience probably have more 
to say.  :)


Jun
