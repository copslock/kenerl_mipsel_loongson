Received:  by oss.sgi.com id <S553916AbRAYPz1>;
	Thu, 25 Jan 2001 07:55:27 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:49416 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553895AbRAYPzC>;
	Thu, 25 Jan 2001 07:55:02 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 2BA0D7FE; Thu, 25 Jan 2001 16:55:00 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 4644AEE9C; Thu, 25 Jan 2001 16:55:31 +0100 (CET)
Date:   Thu, 25 Jan 2001 16:55:31 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: [FIX] sysmips(MIPS_ATMIC_SET, ...) ret_from_sys_call vs. o32_ret_from_sys_call
Message-ID: <20010125165530.B12576@paradigm.rfc822.org>
References: <20010124163048.B15348@paradigm.rfc822.org> <20010124165919.C15348@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010124165919.C15348@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Jan 24, 2001 at 04:59:19PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Jan 24, 2001 at 04:59:19PM +0100, Florian Lohoff wrote:
> Decoded this is:
> 
> Unable to handle kernel paging request at virtual address 00000000, epc == 00000000, ra == 00000000
> $0 : 00000000 1004fc00 fffffff2 00000001
> $4 : fffffff2 00000000 00000001 00000000
> $8 : 00000000 2abf3a94 8800f4a0 00000004
> $12: 8ec09f10 7ffffaf8 8ec09f18 8ec09f18
> $16: 8801acf8 00000000 10011510 00000002
> $20: 10011510 7ffffdd8 7ffffdcc 00000002
> $24: 00000000 2abf3a80
> $28: 8ec08000 8ec09ef8 7ffffd10 00000000
> epc   : 00000000
> Using defaults from ksymoops -t elf32-bigmips -a mips:3000
> Status: 1004fc03
> Cause : 30000008

Ok - another one (sorry to spam you) 

>From "handle_sys" i see that system call address and no of
args are in t2 and t3 which are 0x8800f4a0 and 4 with the register
dump above.

8800f4a0 is sys_sysmips which i also saw in the find strace.

>From the strace i find

sysmips(0x7d1, 0x2ac95d24, 0x1, 0)      = 4149

all the time - 0x7d1 is "MIPS_ATOMIC_SET" - Ok from the trace
i see the call comes from handle_sys which itself would end with
o32_ret_from_sys_call.

sysmips(MIPS_ATOMIC_SET, ...) 

would itself return with "ret_from_sys_call".

If i now apply

Index: arch/mips/kernel/sysmips.c
===================================================================
RCS file: /cvs/linux/arch/mips/kernel/sysmips.c,v
retrieving revision 1.15
diff -u -r1.15 sysmips.c
--- arch/mips/kernel/sysmips.c	2000/11/18 01:19:35	1.15
+++ arch/mips/kernel/sysmips.c	2001/01/25 15:48:44
@@ -111,7 +111,7 @@
 
 		__asm__ __volatile__(
 			"move\t$29, %0\n\t"
-			"j\tret_from_sys_call"
+			"j\to32_ret_from_sys_call"
 			: /* No outputs */
 			: "r" (&cmd));
 		/* Unreached */

The machine now at least doesnt crash anymore - Others have to decide
if this is correct. (Nevertheless find doesnt return but this might
be a different problem)

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
