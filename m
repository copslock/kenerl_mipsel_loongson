Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2008 23:40:22 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:30697 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23620953AbYKKXkT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 11 Nov 2008 23:40:19 +0000
Date:	Tue, 11 Nov 2008 23:40:19 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Richard Sandiford <rdsandiford@googlemail.com>
cc:	Kumba <kumba@gentoo.org>, gcc-patches@gcc.gnu.org,
	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH]: R10000 Needs LL/SC Workaround in Gcc
In-Reply-To: <87y6zphn5b.fsf@firetop.home>
Message-ID: <alpine.LFD.1.10.0811112328580.2015@ftp.linux-mips.org>
References: <490A90F4.6040601@gentoo.org> <490C05A9.9070707@gentoo.org> <87abcjibsl.fsf@firetop.home> <490CA4C8.40904@gentoo.org> <87tzargrn4.fsf@firetop.home> <490CEDB9.6030600@gentoo.org> <87prleh2hc.fsf@firetop.home> <490EBDE2.6010709@gentoo.org>
 <87myggilk2.fsf@firetop.home> <490FF63A.7010900@gentoo.org> <8763mypnhf.fsf@firetop.home> <4917D01B.8080508@gentoo.org> <87y6zphn5b.fsf@firetop.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 11 Nov 2008, Richard Sandiford wrote:

> (Which I suppose raises the question: should
> 
>   -march=r10000 -mno-branch-likely
> 
> be an error, or should it silently disable -mfix-r10000?  My vote is
> for "error".  You can always write -march=r10000 -mno-branch-likely
> -mno-fix-r10000 is that's really what you mean.
> 
> The suggested change -- swapping these two blocks around -- should do that.)

 FWIW, my preference is for an error too.  The main reason being to warn 
the user about the incompatibility of these options.

 For the opposite case a scenario where in a building system they come 
from different places each can be imagined.  Or one could be buried 
somewhere down the Makefiles in a platform-specific section of an odd 
package.  In the end the user might not be fully aware they are doing 
something wrong and the result would be broken packages would fail 
randomly on the affected processors at the run time.

 Always prefer a build error to a run-time error if possible.

  Maciej
