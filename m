Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5F4A4Y00332
	for linux-mips-outgoing; Thu, 14 Jun 2001 21:10:04 -0700
Received: from mms1.broadcom.com (mms1.broadcom.com [63.70.210.58])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5F4A3k00327
	for <linux-mips@oss.sgi.com>; Thu, 14 Jun 2001 21:10:03 -0700
Received: from 63.70.210.1 by mms1.broadcom.com with ESMTP (Broadcom
 MMS-1 SMTP Relay (MMS v4.7)); Thu, 14 Jun 2001 21:10:02 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from postal.sibyte.com (IDENT:postfix@[10.21.128.60]) by
 mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP id VAA01550; Thu, 14
 Jun 2001 21:09:47 -0700 (PDT)
Received: from plugh.sibyte.com (plugh.sibyte.com [10.21.64.158]) by
 postal.sibyte.com (Postfix) with ESMTP id 8C9D91595F; Thu, 14 Jun 2001
 21:09:47 -0700 (PDT)
Received: by plugh.sibyte.com (Postfix, from userid 61017) id 4F20A686D;
 Thu, 14 Jun 2001 21:09:07 -0700 (PDT)
From: "Justin Carlson" <carlson@sibyte.com>
Reply-to: carlson@sibyte.com
Organization: Sibyte
To: kjlin <kj.lin@viditec-netmedia.com.tw>
Subject: Re: How to trigger a binary to excute in Linux/MIPS?
Date: Thu, 14 Jun 2001 21:03:22 -0700
X-Mailer: KMail [version 1.0.29]
References: <04a201c0f542$28184620$056aaac0@kjlin>
In-Reply-To: <04a201c0f542$28184620$056aaac0@kjlin>
cc: linux-mips@oss.sgi.com
MIME-Version: 1.0
Message-ID: <0106142109060Z.00831@plugh.sibyte.com>
X-WSS-ID: 17375510120071-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 8bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 14 Jun 2001, you wrote:
> 
> Hi,
> 
> To execute a program, the load_elf_binary() loads it and descdes the value of elf_entry, start_code, start_data....etc..
> Then , the start_thread(regs, elf_entry, bprm->p) will trigger it.
> But it just sets up the value of regs->cp0_status, regs->cp0_epc, regs->regs[29] and current->thread.current_ds.
> Why can the start_thread() trigger a program?
> 

It does trigger a program, just not in the way you're thinking. 

At that point, you're in kernel space, with kernel privileges, so you can't
just jump to the entry point of the elf binary; you have to drop privs first.

What you're probably missing is that, when the kernel returns to userspace, it
does so (in mips) via an eret, which returns to the epc.  The registers are
restored from the regs struct that is being modified by start_thread, so it is
effectively modifying the registers for userspace, which is what it should be
doing.

In short, you're not going to see the new process, in your case, /sbin/hello,
start executing until the syscall returns.  Check out
arch/mips/kernel/entry.S:ret_from_sys_call to see where this happens.  You'll
also want to check out include/asm-mips/stackframe.h

Does this make sense?

-Justin
