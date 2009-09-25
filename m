Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Sep 2009 01:06:55 +0200 (CEST)
Received: from smtp.zeugmasystems.com ([70.79.96.174]:28828 "EHLO
	zeugmasystems.com" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S1493455AbZIYXGr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 26 Sep 2009 01:06:47 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Strange bad accesses in compat_exit_robust_list (2.6.26, n32 ABI).
Date:	Fri, 25 Sep 2009 16:06:37 -0700
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C501F7053D@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Strange bad accesses in compat_exit_robust_list (2.6.26, n32 ABI).
Thread-Index: Aco+NNVJ+M75nEnzTBCs6uWEZaSwkw==
From:	"Kaz Kylheku" <KKylheku@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <KKylheku@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: KKylheku@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

Hi all,

We made a strange discovery some time ago. After adding some tracing
printk's
to the compat_exit_robust_list function for all the cases where fetching
the
robust entry fails, we discovered that, from time to time, it's being
reported
for processes that don't even use threads.

[16:20:13.406162] [futex] ("iptables")(pid=2543)
compat_exit_robust_list:unable to fetch robust entry.
uaddr=000000002aad37e0
[16:20:13.587506] device eth0 entered promiscuous mode
[16:20:13.883648] device eth1 entered promiscuous mode
[16:20:15.419965] [futex] ("ifconfig")(pid=2552)
compat_exit_robust_list:unable to fetch robust entry.
uaddr=00000000301d64f0
[16:20:15.497954] [futex] ("ifconfig")(pid=2574)
compat_exit_robust_list:unable to fetch robust entry.
uaddr=00000000301d64f0
[16:20:15.547260] [futex] ("iptables")(pid=2544)
compat_exit_robust_list:unable to fetch robust entry.
uaddr=000000002aad37e0
[16:20:16.002251] eth1: link available: 100base-FD
[00:32:56.240290] [futex] ("gzip")(pid=14397)
compat_exit_robust_list:unable to fetch the next robust entry.
uaddr=0000000000000000
[00:33:06.769279] [futex] ("gzip")(pid=14413)
compat_exit_robust_list:unable to fetch the next robust entry.
uaddr=0000000000000000
[00:33:11.964047] [futex] ("bzip2")(pid=14416)
compat_exit_robust_list:unable to fetch the next robust entry.
uaddr=0000000000000000
[16:41:50.024024] [futex] ("bzip2")(pid=32595)
compat_exit_robust_list:unable to fetch the next robust entry.
uaddr=0000000000000000

Sometimes the pointer to the robust list head is bad (``unable to fetch
robust
entry'').  Sometimes that pointer works, but walking the list is bad
(``unable
to fetch the next robust entry'').

These programs shouldn't even be invoking the compat_set_robust_list
system call, and don't even link to libpthread.so.
