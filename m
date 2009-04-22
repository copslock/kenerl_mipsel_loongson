Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Apr 2009 10:35:48 +0100 (BST)
Received: from gateway06.websitewelcome.com ([67.18.15.14]:9134 "HELO
	gateway06.websitewelcome.com") by ftp.linux-mips.org with SMTP
	id S20025167AbZDVJfk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 10:35:40 +0100
Received: (qmail 17427 invoked from network); 22 Apr 2009 09:38:22 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway06.websitewelcome.com with SMTP; 22 Apr 2009 09:38:22 -0000
Received: from [217.109.65.213] (port=3481 helo=[127.0.0.1])
	by gator750.hostgator.com with esmtpa (Exim 4.69)
	(envelope-from <kevink@paralogos.com>)
	id 1LwYoW-0003Cr-1p; Wed, 22 Apr 2009 04:32:20 -0500
Message-ID: <49EEE4EA.8040100@paralogos.com>
Date:	Wed, 22 Apr 2009 11:35:38 +0200
From:	"Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To:	David Daney <ddaney@caviumnetworks.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
References: <49EE3B0F.3040506@caviumnetworks.com> <1240349605-1921-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1240349605-1921-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:
> This is a preliminary patch to add a vdso to all user processes.
> Still missing are ELF headers and .eh_frame information.  But it is
> enough to allow us to move signal trampolines off of the stack.
>
> We allocate a single page (the vdso) and write all possible signal
> trampolines into it.  The stack is moved down by one page and the vdso
> is mapped into this space.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Note that for FPU-less CPUs, the kernel FP emulator also uses a user
stack trampoline to execute instructions in the delay slots of emulated
FP branches.  I didn't see any of the math-emu modules being tweaked in
either part of your patch.  Presumably, one would want to move that
operation into the vdso as well.  With the proposed patch, I'm not sure
whether things would continue working normally as before, still using
the user stack, or whether the dsemulret code depends on something that
is changed by the patch, and will now implode.  Probably the former, but
paranoia is not a character defect in OS kernel work. I don't have a
test case handy (nor a test system any more), but compiling something
like whetstone or linpack in C with a high degree of optimization will
*probably* generate FP branches with live delay slots.

          Regards,

          Kevin K.
