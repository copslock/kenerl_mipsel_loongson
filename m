Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 10:39:37 +0100 (CET)
Received: from ftp.mips.com ([206.31.31.227]:55541 "EHLO mx2.mips.com")
	by linux-mips.org with ESMTP id <S8225265AbSLEJjh>;
	Thu, 5 Dec 2002 10:39:37 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id gB59cuNf028457;
	Thu, 5 Dec 2002 01:38:56 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA07924;
	Thu, 5 Dec 2002 01:38:52 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id gB59csb18610;
	Thu, 5 Dec 2002 10:38:54 +0100 (MET)
Message-ID: <3DEF1EAD.14932B13@mips.com>
Date: Thu, 05 Dec 2002 10:38:54 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Jun Sun <jsun@mvista.com>
CC: Daniel Jacobowitz <dan@debian.org>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: possible Malta 4Kc cache problem ...
References: <20021203224504.B13437@mvista.com> <007501c29b78$f34680e0$10eca8c0@grendel> <3DEDD414.3854664F@mips.com> <3DEDE537.CD58AD8F@mips.com> <013d01c29b95$fb487f60$10eca8c0@grendel> <3DEDFFB9.3312BA1A@mips.com> <021401c29bb7$cd02abe0$10eca8c0@grendel> <20021204173248.GA23213@nevyn.them.org> <3DEE6572.5331C5CD@mips.com> <20021204145823.X4363@mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-Path: <carstenl@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: carstenl@mips.com
Precedence: bulk
X-list: linux-mips

I think I know what the problem is, the PRID is telling me everything.
Jun Sun, you have just found an ancient 4Kc bug, sorry if you spend a
lot of time debugging this.
We have a newer TMSC 4Kc board, which doesn't have this problem
You fix flushing the whole cache works, but the problem with this kind
of bug, is that there are other potential problems.

There is what the errata sheet says:

E16. Fill buffers not flushed on CACHE instructions
Problem: The fill buffers in the cache controllers were not flushed by
CACHE instructions. Under certain circumstances, the fill buffer could
service future loads even though the cache was invalidated with the
intent of causing a refill from memory. The ICache fill buffer is left
valid for all cache refills (and all cacheable read requests) until the
following cache miss. In this case, memory was being updated and the
ICache was being cleared. The line being cleared was the last one to be
filled and there was not another cache miss before that line was
re-accessed. The second fetch can get the stale data from the fill
buffer. A similar problem exists in the DCache, but the DFB is
invalidated when the cache is written. Thus, the only time this would be
seen is if all ways of the DCache were locked and the fill buffer was
being treated as an  extra way of the cache.

Implication: This could show up in any place where self modifying code
exists and the ICache is selectively flushed. (If the entire cache is
flushed, there will be an intervening cache miss or uncached reference
to flush the FB). The problem with the DCache would primarily show up
when accessing the same memory with different physical addresses or
cache coherency attributes. If an invalidate is used to flush an entry
from the DCache with the intent of forcing a refill, the refill may not
occur.

Workarounds: Flush the entire ICache when using self-modifying code.
Force a cache miss, cache refill, or uncached access to clear fill
buffers near the invalidation. For the instruction cache, this could be
done by using a CACHE Fill instruction to pre-load the invalidation
routine into the cache. This will force a refill which will flush the
fill buffer.

Status: Fixed.


/Carsten


Jun Sun wrote:

> I guess I still did not answer some of your questions:
>
> On Wed, Dec 04, 2002 at 09:28:34PM +0100, Carsten Langgaard wrote:
> > Could you please tell us, which 4Kc you are running on ?
>
> Is the PRID telling enough?  I posted it in the other email.
>
> > What are the cache configuration (size, number of ways) ?
> > Are you running on the latest kernel sources from the CVS tree ?
>
> Debugging work is done with my kernel, but confirmed that latest
> CVS tree shows the same problem.
>
> > Have you tried the mips32_cache.h file I send and
>
> No, because I don't think it is related to indexed cache operations.
>
> > /or have you tried the kernel
> > from the ftp.mips.com FTP server ?
> >
>
> Jun

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
