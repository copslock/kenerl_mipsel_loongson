Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Mar 2004 14:22:32 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:687 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8225462AbUC2NWb>;
	Mon, 29 Mar 2004 14:22:31 +0100
Received: (qmail 12481 invoked from network); 29 Mar 2004 13:20:27 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.187)
  by mail.ict.ac.cn with SMTP; 29 Mar 2004 13:20:27 -0000
Message-ID: <4068D9C6.7020308@ict.ac.cn>
Date: Mon, 29 Mar 2004 21:21:58 -0500
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
CC: linux-mips@linux-mips.org
Subject: Re: bug in handle_sys?
References: <4067A59B.5000705@ict.ac.cn>
In-Reply-To: <4067A59B.5000705@ict.ac.cn>
Content-Type: text/plain; charset=x-gbk; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Hi,all

It seems the fix is a little more complex than I had thought
because we've to make sure every configuration works,so a patch
is attached below.
And during the reading of related code,we can't find code in mips64
to ensure correct handle of too small a syscall number? For mips we
have reserved space for nr<4000,but now it seems random. Do we need to
fix that too?


===================================================================
RCS file: /home/cvs/linux-godson2/arch/mips64/kernel/scall_o32.S,v
retrieving revision 1.3
retrieving revision 1.4
diff -u -r1.3 -r1.4
--- scall_o32.S 16 Oct 2003 16:18:15 -0000 1.3
+++ scall_o32.S 27 Mar 2004 14:58:11 -0000 1.4
@@ -33,8 +33,8 @@
subu t0, v0, __NR_O32_Linux # check syscall number
sltiu t0, t0, __NR_O32_Linux_syscalls + 1
daddiu t1, 4 # skip to next instruction
- beqz t0, not_o32_scall
sd t1, PT_EPC(sp)
+ beqz t0, not_o32_scall
#if 0
SAVE_ALL
move a1, v0

Index: scall_n32.S
===================================================================
RCS file: /home/cvs/linux-godson2/arch/mips64/kernel/scall_n32.S,v
retrieving revision 1.4
retrieving revision 1.6
diff -u -r1.4 -r1.6
--- scall_n32.S 16 Oct 2003 16:18:15 -0000 1.4
+++ scall_n32.S 29 Mar 2004 13:41:45 -0000 1.6
@@ -35,13 +35,16 @@
STI
.set at
#endif
- ld t1, PT_EPC(sp) # skip syscall on return

subu t0, v0, __NR_N32_Linux # check syscall number
sltiu t0, t0, __NR_N32_Linux_syscalls + 1
+
+#ifndef CONFIG_MIPS32_O32
+ ld t1, PT_EPC(sp) # skip syscall on return
daddiu t1, 4 # skip to next instruction
- beqz t0, not_n32_scall
sd t1, PT_EPC(sp)
+#endif
+ beqz t0, not_n32_scall

dsll t0, v0, 3 # offset into table
ld t2, (sysn32_call_table - (__NR_N32_Linux * 8))(t0)

Index: scall_64.S
===================================================================
RCS file: /home/cvs/linux-godson2/arch/mips64/kernel/scall_64.S,v
retrieving revision 1.2
retrieving revision 1.4
diff -u -r1.2 -r1.4
--- scall_64.S 16 Oct 2003 16:18:15 -0000 1.2
+++ scall_64.S 29 Mar 2004 13:41:44 -0000 1.4
@@ -31,13 +31,15 @@
STI
.set at
#endif
- ld t1, PT_EPC(sp) # skip syscall on return
-
subu t0, v0, __NR_Linux # check syscall number
sltiu t0, t0, __NR_Linux_syscalls + 1
+
+#if !defined(CONFIG_MIPS32_O32) && !defined(CONFIG_MIPS32_N32)
+ ld t1, PT_EPC(sp) # skip syscall on return
daddiu t1, 4 # skip to next instruction
- beqz t0, illegal_syscall
sd t1, PT_EPC(sp)
+#endif
+ beqz t0, illegal_syscall

dsll t0, v0, 3 # offset into table
ld t2, (sys_call_table - (__NR_Linux * 8))(t0) # syscall routine





Fuxin Zhang wrote:

> Hi,
>
> My colleague finds that there is probably a bug in handle_sys:
>
> .align 5
> NESTED(handle_sys, PT_SIZE, sp)
> .set noat
> SAVE_SOME
> STI
> .set at
>
> lw t1, PT_EPC(sp) # skip syscall on return
>
> sltiu t0, v0, MAX_SYSCALL_NO + 1 # check syscall number
> addiu t1, 4 # skip to next instruction
> beqz t0, illegal_syscall
> sw t1, PT_EPC(sp)
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This code is not guarded by .set no reorder,so it won't be the delay slot
> instruction,thus illegal_syscall with num > MAX_SYSCALL_NO will return 
> with
> EPC unchanged. The reason it works is that the syscall number register 
> v0 will
> be changed to ENOSYS. ENOSYS is fortunately another illegal syscall 
> number
> that will take another illegal_syscall return path.
>
> Newer glibc of debian(2.3.2+?) will generate sys_4246,and that lead to 
> real
> problem for mips64. Put the line ahead of the beqz solve it.
>
>
>
>
>
>
>
