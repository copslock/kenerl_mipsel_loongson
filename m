Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Sep 2002 20:29:56 +0200 (CEST)
Received: from gateway-1237.mvista.com ([12.44.186.158]:49394 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S1122958AbSIFS34>;
	Fri, 6 Sep 2002 20:29:56 +0200
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id g86IIFO01331;
	Fri, 6 Sep 2002 11:18:15 -0700
Date: Fri, 6 Sep 2002 11:18:15 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: [jsun@mvista.com: Re: /dev/rtc lookalike for NEW_TIME_C?]
Message-ID: <20020906111815.B1282@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


Try again ....

----- Forwarded message from Jun Sun <jsun@mvista.com> -----

On Thu, Sep 05, 2002 at 08:26:14PM -0700, Matthew Dharm wrote:
> Has anyone written a driver module provide something like /dev/rtc for
> those platforms that use the CONFIG_NEW_TIME_C?
>

Yes.  I submitted this patch November last year.  There was some discussions,
but no real opposition.  Ralf, can you apply this patch?  Tom Rini
is supposedly to come up with a unified solution in 2.5+.  But until
then this is such a useful thing for MIPS folks.

http://linux.junsun.net/patches/oss.sgi.com/submitted.

Jun

----- End forwarded message -----
