Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Oct 2005 18:24:31 +0100 (BST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:42929 "EHLO
	t111.niisi.ras.ru") by ftp.linux-mips.org with ESMTP
	id S8133550AbVJFRYH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Oct 2005 18:24:07 +0100
Received: from t111.niisi.ras.ru (localhost [127.0.0.1])
	by t111.niisi.ras.ru (8.13.4/8.12.11) with ESMTP id j96HO6UB032192
	for <linux-mips@linux-mips.org>; Thu, 6 Oct 2005 21:24:06 +0400
Received: (from uucp@localhost)
	by t111.niisi.ras.ru (8.13.4/8.13.4/Submit) with UUCP id j96HO6QF032189
	for linux-mips@linux-mips.org; Thu, 6 Oct 2005 21:24:06 +0400
Received: from [192.168.173.2] (t34 [193.232.173.34])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id j96HNp3t021489
	for <linux-mips@linux-mips.org>; Thu, 6 Oct 2005 21:23:51 +0400
Message-ID: <43455D2D.1010901@niisi.msk.ru>
Date:	Thu, 06 Oct 2005 21:21:49 +0400
From:	"Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Bug in the syscall tracing code
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Hello,

The story continues. The last fix of the syscall tracing code was wrong, 
unfortunately. (The bug was a user could invoke any function in the 
kernel. The fix was not to use t2 as pointer to a syscall, s0 was chosen 
for it.) The problem we discovered is a few syscalls do SAVE_STATIC 
(those declared as save_static_function), so s0 (which holds pointer to 
the syscall at the time the syscall is invoked) is saved on the stack 
overwriting a value saved from the process being traced. No wonder, s0 
that restored on syscall exit differs from s0 saved on syscall enter.

See, arch/mips/kernel/scall32-o32.S, syscall_trace_entry, for example. 
The rest of ABIs are the same.

There are several ways to fix this:

1. Make syscall handling code to be close to other arches. I mean, check 
for the trace flag first, then parse arguments and invoke a syscall.

2. Remove save_static_functions and do SAVE_STATIC early for several 
syscalls (yes, one big switch or its asm equivalent).

3. Store t2 in pt_regs (it means we have to expand this structure).

4. I know there should be yet another way.

Any ideas ?

Regards,
Gleb.
