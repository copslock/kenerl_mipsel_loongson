Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Apr 2009 03:11:46 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:967 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S28652912AbZDVPUM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Apr 2009 16:20:12 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49ef35600000>; Wed, 22 Apr 2009 11:18:58 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Apr 2009 08:18:34 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 22 Apr 2009 08:18:34 -0700
Message-ID: <49EF354A.3030109@caviumnetworks.com>
Date:	Wed, 22 Apr 2009 08:18:34 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Shane McDonald <mcdonald.shane@gmail.com>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Preliminary vdso.
References: <49EE3B0F.3040506@caviumnetworks.com>	 <1240349605-1921-1-git-send-email-ddaney@caviumnetworks.com> <b2b2f2320904212224l1223737en95bffec015f1907e@mail.gmail.com>
In-Reply-To: <b2b2f2320904212224l1223737en95bffec015f1907e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Apr 2009 15:18:34.0543 (UTC) FILETIME=[9A555BF0:01C9C35D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Shane McDonald wrote:
> Hello David:
> 
> On Tue, Apr 21, 2009 at 3:33 PM, David Daney <ddaney@caviumnetworks.com 
> <mailto:ddaney@caviumnetworks.com>> wrote:
> 
>     This is a preliminary patch to add a vdso to all user processes.
>     Still missing are ELF headers and .eh_frame information.  But it is
>     enough to allow us to move signal trampolines off of the stack.
> 
>     We allocate a single page (the vdso) and write all possible signal
>     trampolines into it.  The stack is moved down by one page and the vdso
>     is mapped into this space.
> 
> 
> This patch fails to compile for me with an RM7035C-based system (out of 
> tree, sadly).  The error I see is:
> 
>   CC      arch/mips/kernel/syscall.o
> arch/mips/kernel/syscall.c: In function 'arch_get_unmapped_area':
> arch/mips/kernel/syscall.c:80: error: 'TASK_SIZE32' undeclared (first 
> use in this function)
> arch/mips/kernel/syscall.c:80: error: (Each undeclared identifier is 
> reported only once
> arch/mips/kernel/syscall.c:80: error: for each function it appears in.)
> make[1]: *** [arch/mips/kernel/syscall.o] Error 1
> 

I never built a 32-bit kernel with the patch.  I will endeavor to fix this.

Thanks,
David Daney
