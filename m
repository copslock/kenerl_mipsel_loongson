Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Apr 2004 10:44:12 +0100 (BST)
Received: from [IPv6:::ffff:193.232.173.111] ([IPv6:::ffff:193.232.173.111]:57700
	"EHLO t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S8225254AbUDBJoL>; Fri, 2 Apr 2004 10:44:11 +0100
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.11.7/8.11.7) with ESMTP id i329irV27376
	for <linux-mips@linux-mips.org>; Fri, 2 Apr 2004 13:44:53 +0400
Received: from t06.niisi.ras.ru (localhost.localdomain [127.0.0.1])
	by t06.niisi.ras.ru (8.12.8/8.12.8) with ESMTP id i329fwFi004708
	for <linux-mips@linux-mips.org>; Fri, 2 Apr 2004 13:41:59 +0400
Received: (from uucp@localhost)
	by t06.niisi.ras.ru (8.12.8/8.12.8/Submit) with UUCP id i329fwor004706
	for linux-mips@linux-mips.org; Fri, 2 Apr 2004 13:41:58 +0400
Received: from niisi.msk.ru (aa01 [172.16.0.1])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id i329dxUY018426
	for <linux-mips@linux-mips.org>; Fri, 2 Apr 2004 13:39:59 +0400
Received: from niisi.msk.ru (t34 [193.232.173.34])
	by niisi.msk.ru (8.12.5/8.12.5) with ESMTP id i329dvuj018401
	for <linux-mips@linux-mips.org>; Fri, 2 Apr 2004 13:39:57 +0400 (MSK)
Message-ID: <406D3566.3FC6067C@niisi.msk.ru>
Date: Fri, 02 Apr 2004 13:41:58 +0400
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en,ru
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: strace on a linux/mips
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Hello,

Strace can't follow fork on a linux/mips (on all kernels, mips, mips64,
o32, n32, etc).

When fork occurs, strace changes syscall number from fork to clone in v0
and sets CLONE_PTRACE in a0.
Unfortunately, a kernel forms an address of a syscall routine before
strace performs its dirty tricks. Thus, only thing strace can do is
playing with syscall routine's address via t2. It's not so useful
because strace doesn't know where a syscall table is in. Strace is still
able to change first 4 arguments, though.

BTW, opening t2 to the ptrace(2) interface isn't good thing too. I am
not sure I can gain root by pondering t2, but I'm sure it's a hole for a
DoS attack, at least. (For lazy people, a kernel restores t2 from the
stack and does jalr t2 after the process being traced is resumed.)

The solution is to repeat parsing syscall number (and number of
arguments) on return from syscall_trace.
Another solution is to call syscall_trace early, before parsing.

Have somebody got yet another idea?

Regards,
Gleb.
