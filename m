Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Dec 2002 23:58:32 +0100 (CET)
Received: from gateway-1237.mvista.com ([12.44.186.158]:25595 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224847AbSLDW6b>;
	Wed, 4 Dec 2002 23:58:31 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id gB4MwNt31774;
	Wed, 4 Dec 2002 14:58:23 -0800
Date: Wed, 4 Dec 2002 14:58:23 -0800
From: Jun Sun <jsun@mvista.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: possible Malta 4Kc cache problem ...
Message-ID: <20021204145823.X4363@mvista.com>
References: <20021203224504.B13437@mvista.com> <007501c29b78$f34680e0$10eca8c0@grendel> <3DEDD414.3854664F@mips.com> <3DEDE537.CD58AD8F@mips.com> <013d01c29b95$fb487f60$10eca8c0@grendel> <3DEDFFB9.3312BA1A@mips.com> <021401c29bb7$cd02abe0$10eca8c0@grendel> <20021204173248.GA23213@nevyn.them.org> <3DEE6572.5331C5CD@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DEE6572.5331C5CD@mips.com>; from carstenl@mips.com on Wed, Dec 04, 2002 at 09:28:34PM +0100
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


I guess I still did not answer some of your questions:

On Wed, Dec 04, 2002 at 09:28:34PM +0100, Carsten Langgaard wrote:
> Could you please tell us, which 4Kc you are running on ?

Is the PRID telling enough?  I posted it in the other email.

> What are the cache configuration (size, number of ways) ?
> Are you running on the latest kernel sources from the CVS tree ?

Debugging work is done with my kernel, but confirmed that latest
CVS tree shows the same problem.

> Have you tried the mips32_cache.h file I send and

No, because I don't think it is related to indexed cache operations.

> /or have you tried the kernel
> from the ftp.mips.com FTP server ?
>

Jun
