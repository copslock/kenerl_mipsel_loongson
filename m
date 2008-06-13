Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2008 15:29:57 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:45189 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S20035567AbYFMO3z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jun 2008 15:29:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5DET0d7003103;
	Fri, 13 Jun 2008 15:29:01 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5DESsWe003066;
	Fri, 13 Jun 2008 15:28:54 +0100
Date:	Fri, 13 Jun 2008 15:28:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	GCC Mailing List <gcc@gcc.gnu.org>,
	MIPS Linux List <linux-mips@linux-mips.org>,
	rdsandiford@googlemail.com
Subject: Re: Resend: [PATCH] [MIPS] Fix asm constraints for 'ins'
	instructions.
Message-ID: <20080613142854.GA24821@linux-mips.org>
References: <48500599.9080807@avtrex.com> <20080611172950.GA16600@linux-mips.org> <48500EDD.404@avtrex.com> <871w339hy9.fsf@firetop.home> <48514F3E.6050906@avtrex.com> <87k5gu8qey.fsf@firetop.home> <485182A2.7020702@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <485182A2.7020702@avtrex.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2008 at 01:10:10PM -0700, David Daney wrote:

>>> Among the versions of GCC that can build the current kernel, will any
>>> fail on this code because the "i" constraint cannot be matched when
>>> expanded to RTL?
>>
>> Someone will point this out if I don't, so for avoidance of doubt:
>> this needs to be always_inline.  It also isn't guaranteed to work
>> with "bit" being a separate statement.  I'm not truly sure it's
>> guaranteed to work even with:
>>
>>     __asm__ __volatile__ ("  foo %0, %1" : "=m" (*p) : "i" (nr & 5));
>>
>> but I think we'd try hard to make sure it does.
>>
>> I think Maciej said that 3.2 was the minimum current version.
>> Even with those two issues sorted out, I don't think you can
>> rely on this sort of thing with compilers that used RTL inlining.
>> (always_inline does go back to 3.2, in case you're wondering.)
>>
>
> Well I withdraw the patch.  With the current kernel code we seem to always get good code generation.  In the event that the compiler tries to put the shift amount (nr) in a register, the assembler will complain.  I don't think it is possible to generate bad object code, so best to leave it alone.
>
> FYI, the reason that I stumbled on this several weeks ago is that if(__builtin_constant_p(nr)) in the trunk compiler was generating code for the asm even though nr was not constant.

How about I simply put your patch into the -queue tree, everybody gives it
a nice beating and then we'll how well it'll hold up in the real world?

  Ralf
