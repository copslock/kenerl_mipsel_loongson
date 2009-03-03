Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Mar 2009 16:59:55 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:50187 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21299811AbZCCQ7v (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Mar 2009 16:59:51 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49ad61750000>; Tue, 03 Mar 2009 11:57:30 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Mar 2009 08:56:25 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 3 Mar 2009 08:56:25 -0800
Message-ID: <49AD6139.60209@caviumnetworks.com>
Date:	Tue, 03 Mar 2009 08:56:25 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@codesourcery.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2009 16:56:25.0772 (UTC) FILETIME=[FD344EC0:01C99C20]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> Hello,
> 
>  Here is code to implement the getcontext API for MIPS.
[...]
> 
>  The conclusion is what I am requesting is to get the structure of the 
> stack frame used by sigreturn(2) fixed in its current form and make sure 
> the syscall only ever uses data from the ucontext_t structure within.  A 
> new syscall would have to be introduced if the kernel required a change in 
> the way sigreturn(2) behaves in the future.  For the purpose of glibc the 
> structure of the stack frame is defined in the kernel_rt_sigframe.h header 
> provided with the patch.
> 

Note the libgcc currently makes the assumption that the layout of the 
stack for signal handlers is fixed.  The DWARF2 unwinder needs this 
information to be able to unwind through signal frames (see 
gcc/config/mips/linux-unwind.h), so it is already a de facto part of the 
ABI.

When (and if) we move the sigreturn trampoline to a vdso we should be 
able to maintain the ABI.


>  Furthermore I am requesting that the kernel recognises the special 
> meaning of the value of one stored in the slot designated for the $zero 
> register and never places such a value itself there.

Seems reasonable to me as currently a zero is unconditionally stored there.

David Daney
