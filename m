Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Sep 2009 03:05:48 +0200 (CEST)
Received: from smtp.zeugmasystems.com ([70.79.96.174]:32713 "EHLO
	zeugmasystems.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1493171AbZIZBFl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 26 Sep 2009 03:05:41 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Strange bad accesses in compat_exit_robust_list (2.6.26, n32 ABI).
Date:	Fri, 25 Sep 2009 18:05:30 -0700
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C501F7056C@exchange.ZeugmaSystems.local>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C501F7053F@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Strange bad accesses in compat_exit_robust_list (2.6.26, n32 ABI).
Thread-Index: Aco+NNVJ+M75nEnzTBCs6uWEZaSwkwAAFr7QAAPRybA=
From:	"Kaz Kylheku" <KKylheku@zeugmasystems.com>
To:	"Kaz Kylheku" <KKylheku@zeugmasystems.com>,
	<linux-mips@linux-mips.org>
Return-Path: <KKylheku@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KKylheku@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

linux-mips-bounce@linux-mips.org wrote:
> Kaz Kylheku wrote:
>> Hi all,
>> 
>> We made a strange discovery some time ago. After adding some tracing
>> printk's to the compat_exit_robust_list function for all the cases
>> where fetching the robust entry fails, we discovered that, from time
>> to time, 
>> it's being reported
>> for processes that don't even use threads.
> 
> Hmm. Maybe a syscall is being misrouted? Perhaps user space is calling
> some function that ends up routed to the compat_set_robust_list
> entry in the syscall table, causing a junk value to be installed
> as the robust list. Hmm. But robust mutexes work on our platform;
> so glibc does reach the right syscalls when they are intended.

I have another hypothesis.

The execve syscall does not appear to deal with the robust
mutex list at all. A process can set up these robust pointers
and then call execv. It gets a new memory map, but the
flush_old_exec function does not clean up the robust list pointer,
which refers to a virtual address in the old address space.

I just confirmed it in fact.

I have a 100% repro for this problem when I do a 
``tar xjf file.tar.bz2'' on my board.

The tar process calls compat_sys_set_robust_list, and then
the bzip2 process encounters the problem in the compat_exit_robust_list.

But the PID is the same!  The tar process has exec-ed
bzip2, and the bzip2 image inherited bad robust pointers from
the time when it was tar.
