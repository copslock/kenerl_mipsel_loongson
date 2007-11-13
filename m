Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Nov 2007 16:13:08 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:30383 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20026824AbXKMQNA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Nov 2007 16:13:00 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 46E2C30FEC8;
	Tue, 13 Nov 2007 16:12:57 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Tue, 13 Nov 2007 16:12:55 +0000 (UTC)
Received: from jennifer.localdomain ([192.168.7.229]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 13 Nov 2007 08:12:35 -0800
Message-ID: <4739CCD6.2080306@avtrex.com>
Date:	Tue, 13 Nov 2007 08:12:06 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Cc:	Richard Sandiford <rsandifo@nildram.co.uk>, gcc@gcc.gnu.org
Subject: Re: Cannot unwind through MIPS signal frames with ICACHE_REFILLS_WORKAROUND_WAR
References: <473957B6.3030202@avtrex.com>
In-Reply-To: <473957B6.3030202@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Nov 2007 16:12:35.0671 (UTC) FILETIME=[00E9BE70:01C82610]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> With the current kernel (2.6.23.1) in my R5000 based O2 it seems 
> impossible for GCC's exception unwinding machinery to unwind through 
> signal frames.  The cause of the problems is the 
> ICACHE_REFILLS_WORKAROUND_WAR which puts the sigcontext at an almost 
> impossible to determine offset from the signal return trampoline.  The 
> unwinder depends on being able to find the sigcontext given a known 
> location of the trampoline.
>
> It seems there are a couple of possible solutions:
>
> 1) The comments in war.h indicate the problem only exists in R7000 and 
> E9000 processors.  We could turn off the workaround if the kernel is 
> configured for R5000.  That would help me, but not those with the 
> effected systems.
>
> 2) In the non-workaround case, the siginfo immediately follows the 
> trampoline and the first member is the signal number.  For the 
> workaround case the first word following the trampoline is zero.  We 
> could replace this with the offset to the sigcontext which is always a 
> small negative value.  The unwinder could then distinguish the two 
> cases (signal numbers are positive and the offset negative).  If we 
> did this, the change would have to be coordinated with GCC's unwinder 
> (in libgcc_s.so.1).
>
I think I have found a solution that doesn't require kernel changes.

The CFA (i.e. the stack pointer of the signal handler) of the the 
context when calling mips_fallback_frame_state is at a constant offset 
from the sigcontext.  I can just use the CFA instead of the trampoline's 
address.

Does this seem plausible?

Thanks,
David Daney
