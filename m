Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 21:53:35 +0100 (BST)
Received: from mx02.qsc.de ([213.148.130.14]:8590 "EHLO mx02.qsc.de")
	by ftp.linux-mips.org with ESMTP id S3465660AbVJFUxU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Oct 2005 21:53:20 +0100
Received: from port-195-158-179-121.dynamic.qsc.de ([195.158.179.121] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1ENcjl-00005f-00; Thu, 06 Oct 2005 22:53:09 +0200
Received: from ths by hattusa.textio with local (Exim 4.54)
	id 1ENcjk-0007b8-ST; Thu, 06 Oct 2005 22:53:08 +0200
Date:	Thu, 6 Oct 2005 22:53:08 +0200
To:	"Gleb O. Raiko" <raiko@niisi.msk.ru>
Cc:	linux-mips@linux-mips.org
Subject: Re: Bug in the syscall tracing code
Message-ID: <20051006205308.GB31717@hattusa.textio>
References: <43455D2D.1010901@niisi.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43455D2D.1010901@niisi.msk.ru>
User-Agent: Mutt/1.5.11
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Gleb O. Raiko wrote:
> Hello,
> 
> The story continues. The last fix of the syscall tracing code was wrong, 
> unfortunately. (The bug was a user could invoke any function in the 
> kernel. The fix was not to use t2 as pointer to a syscall, s0 was chosen 
> for it.) The problem we discovered is a few syscalls do SAVE_STATIC 
> (those declared as save_static_function), so s0 (which holds pointer to 
> the syscall at the time the syscall is invoked) is saved on the stack 
> overwriting a value saved from the process being traced. No wonder, s0 
> that restored on syscall exit differs from s0 saved on syscall enter.
> 
> See, arch/mips/kernel/scall32-o32.S, syscall_trace_entry, for example. 
> The rest of ABIs are the same.
> 
> There are several ways to fix this:
> 
> 1. Make syscall handling code to be close to other arches. I mean, check 
> for the trace flag first, then parse arguments and invoke a syscall.
> 
> 2. Remove save_static_functions and do SAVE_STATIC early for several 
> syscalls (yes, one big switch or its asm equivalent).
> 
> 3. Store t2 in pt_regs (it means we have to expand this structure).
> 
> 4. I know there should be yet another way.

- Use the k1 slot instead of s0 to save the function pointer.


Thiemo
