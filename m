Received:  by oss.sgi.com id <S553872AbQKMVDx>;
	Mon, 13 Nov 2000 13:03:53 -0800
Received: from mail.ivm.net ([62.204.1.4]:2687 "EHLO mail.ivm.net")
	by oss.sgi.com with ESMTP id <S553863AbQKMVDg>;
	Mon, 13 Nov 2000 13:03:36 -0800
Received: from franz.no.dom (port166.duesseldorf.ivm.de [195.247.65.166])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id WAA15124;
	Mon, 13 Nov 2000 22:03:21 +0100
X-To:   linux-mips@oss.sgi.com
Message-ID: <XFMail.001113220314.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20001112210049.C26606@lug-owl.de>
Date:   Mon, 13 Nov 2000 22:03:14 +0100 (CET)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: RE: Build failure for R3000 DECstation
Cc:     linux-mips@oss.sgi.com
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On 12-Nov-00 Jan-Benedict Glaw wrote:
> I see this build failure:
> 
> sysmips.c: In function `sys_sysmips':
> sysmips.c:109: warning: implicit declaration of function `syscall_trace'
> {standard input}: Assembler messages:
> {standard input}:337: Error: opcode requires -mips2 or greater `ll'
> {standard input}:339: Error: opcode requires -mips2 or greater `sc'
> {standard input}:340: Error: opcode requires -mips2 or greater `beqzl'
> {standard input}:341: Error: opcode requires -mips2 or greater `ll'

Something like 

--- snip here ---
diff -ruN /nfs/cvs/linux-2.3/linux/arch/mips/kernel/sysmips.c
linux/arch/mips/kernel/sysmips.c
--- /nfs/cvs/linux-2.3/linux/arch/mips/kernel/sysmips.c Sun Nov 12 16:05:54 2000
+++ linux/arch/mips/kernel/sysmips.c    Mon Nov 13 19:35:46 2000
@@ -73,13 +73,16 @@
 
        case MIPS_ATOMIC_SET: {
                unsigned int tmp;
-
+#ifndef CONFIG_CPU_HAS_LLSC
+               unsigned long flags;
+#endif
                p = (int *) arg1;
                errno = verify_area(VERIFY_WRITE, p, sizeof(*p));
                if (errno)
                        return errno;
                errno = 0;
 
+#ifdef CONFIG_CPU_HAS_LLSC             
                __asm__(".set\tpush\t\t\t# sysmips(MIPS_ATOMIC, ...)\n\t"
                        ".set\tnoreorder\n\t"
                        ".set\tnoat\n\t"
@@ -100,6 +103,12 @@
                        : "=&r" (tmp), "=o" (* (u32 *) p), "=r" (errno)
                        : "r" (arg2), "o" (* (u32 *) p), "2" (errno)
                        : "$1");
+#else
+               save_and_cli(flags);
+               errno |= __get_user(tmp, p);
+               errno |= __put_user(arg2, p);
+               restore_flags(flags);
+#endif
 
                if (errno)
                        return -EFAULT;
--- snip here ---

should fix this. However, this patch is untested and should be considered as an
RFD. For unknown reasons my R3000 DECstation doesn't grok elf2ecoffed kernels
any more. 

-- 
Regards,
Harald
