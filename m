Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Mar 2004 16:27:45 +0100 (BST)
Received: from mail.ict.ac.cn ([IPv6:::ffff:159.226.39.4]:49808 "HELO
	mail.ict.ac.cn") by linux-mips.org with SMTP id <S8225204AbUC1P1o>;
	Sun, 28 Mar 2004 16:27:44 +0100
Received: (qmail 22845 invoked from network); 28 Mar 2004 15:25:46 -0000
Received: from unknown (HELO ict.ac.cn) (159.226.40.187)
  by mail.ict.ac.cn with SMTP; 28 Mar 2004 15:25:46 -0000
Message-ID: <4067A59B.5000705@ict.ac.cn>
Date: Sun, 28 Mar 2004 23:27:07 -0500
From: Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
X-Accept-Language: zh-cn, en-us
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: bug in handle_sys?
Content-Type: text/plain; charset=x-gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

Hi,

My colleague finds that there is probably a bug in handle_sys:

.align 5
NESTED(handle_sys, PT_SIZE, sp)
.set noat
SAVE_SOME
STI
.set at

lw t1, PT_EPC(sp) # skip syscall on return

sltiu t0, v0, MAX_SYSCALL_NO + 1 # check syscall number
addiu t1, 4 # skip to next instruction
beqz t0, illegal_syscall
sw t1, PT_EPC(sp)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This code is not guarded by .set no reorder,so it won't be the delay slot
instruction,thus illegal_syscall with num > MAX_SYSCALL_NO will return with
EPC unchanged. The reason it works is that the syscall number register 
v0 will
be changed to ENOSYS. ENOSYS is fortunately another illegal syscall number
that will take another illegal_syscall return path.

Newer glibc of debian(2.3.2+?) will generate sys_4246,and that lead to real
problem for mips64. Put the line ahead of the beqz solve it.
