Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Mar 2003 00:27:37 +0000 (GMT)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:36294 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225206AbTCHA1g>;
	Sat, 8 Mar 2003 00:27:36 +0000
Received: (qmail 14755 invoked by uid 6180); 8 Mar 2003 00:27:33 -0000
Date: Fri, 7 Mar 2003 16:27:33 -0800
From: Jeff Baitis <baitisj@evolution.com>
To: linux-mips@linux-mips.org
Subject: Re: Kernel Debugging on the DBAu1500
Message-ID: <20030307162733.Z20129@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <20030306185345.W20129@luca.pas.lab> <1047043427.30914.432.camel@zeus.mvista.com> <1047043677.6389.436.camel@zeus.mvista.com> <20030307123637.Y20129@luca.pas.lab> <1047069561.6389.505.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1047069561.6389.505.camel@zeus.mvista.com>; from ppopov@mvista.com on Fri, Mar 07, 2003 at 12:39:22PM -0800
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Earlier I wrote:

> > Debugging seems to work great now! Thanks!

Well, not quite great. I've abandoned the old Monta Vista gdb-5.0 debugger
since it's been segfaulting.

I've tried building cross-debuggers from the current gdb release (5.3) and
from the March 3 CVS snapshot. Both lock up as soon as I 's'tep, just after
the GDB stub. (./configure --target=mipsel).

Perhaps someone could suggest a version of GDB that I should be using?

I also tried to disable CPU caching, but my kernel wouldn't boot.

Thanks again!

-Jeff


-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
