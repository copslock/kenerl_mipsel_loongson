Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2004 16:20:48 +0000 (GMT)
Received: from RT-soft-2.Moscow.itn.ru ([IPv6:::ffff:80.240.96.70]:17295 "HELO
	mail.dev.rtsoft.ru") by linux-mips.org with SMTP
	id <S8225333AbUAUQUj>; Wed, 21 Jan 2004 16:20:39 +0000
Received: (qmail 32552 invoked from network); 21 Jan 2004 15:59:47 -0000
Received: from unknown (HELO dev.rtsoft.ru) (192.168.1.132)
  by mail.dev.rtsoft.ru with SMTP; 21 Jan 2004 15:59:47 -0000
Message-ID: <400EA795.3030200@dev.rtsoft.ru>
Date: Wed, 21 Jan 2004 19:23:49 +0300
From: Pavel Kiryukhin <savl@dev.rtsoft.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Pavel Kiryukhin <savl@dev.rtsoft.ru>
Subject: sys32_rt_sigtimedwait - new question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <savl@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: savl@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

Hi,
concerning endiannes checking in sys32_rt_sigtimedwait:
just let me note that we have get_sigset and put_sigset that are used in 
sys32_rt_[sigaction,  sigprocmask, sigpending ...] in signal32.c.
Thise functions does not use endian check. Don't know if we can use 
get_sigset in sys32_rt_sigtimedwait.

But I have another question about sys32_rt_sigtimedwait:
We can see the comment about "brainfarting competition". Based on this 
comment only part of sigset is copied from user space to kernel. Why 
signals greater than 64 should not be handled?
If we look at sys32_rt_sigtimedwait in ppc64/kernel/signal32.c or 
sparc64/sys_sparc32.c we can see that full sigset (compat_sigset_t) is 
copied from user while in mips compat_old_sigset is copied. Why it is 
different in MIPS?
-------
Regards
Pavel Kiryukhin
