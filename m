Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jan 2003 09:59:07 +0000 (GMT)
Received: from smtp-102.noc.nerim.net ([IPv6:::ffff:62.4.17.102]:58386 "EHLO
	mallaury.noc.nerim.net") by linux-mips.org with ESMTP
	id <S8224847AbTAWJ7H>; Thu, 23 Jan 2003 09:59:07 +0000
Received: from melkor (vivienc.net1.nerim.net [213.41.134.233])
	by mallaury.noc.nerim.net (Postfix) with ESMTP
	id 0E94462D01; Thu, 23 Jan 2003 10:59:05 +0100 (CET)
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.36 #1 (Debian))
	id 18be8w-0005tU-00; Thu, 23 Jan 2003 10:59:30 +0100
Date: Thu, 23 Jan 2003 10:59:29 +0100 (CET)
From: Vivien Chappelier <vivienc@nerim.net>
X-Sender: glaurung@melkor
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@linux-mips.org
Subject: Re: sigset_t32 broken?
In-Reply-To: <20030123071753.GA996@pureza.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.21.0301231044270.22634-100000@melkor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <vivienc@nerim.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vivienc@nerim.net
Precedence: bulk
X-list: linux-mips

On Thu, 23 Jan 2003, Andrew Clausen wrote:

> Shouldn't those two long's be replaced with u64 and u32
> respectively?  Is the second struct really meant to be twice the
> size the first?

They should be the same size, otherwise sys32_rt_sigsuspend and
sys32_rt_sigaction will return EINVAL. As the comment says:
/* XXX: Don't preclude handling different sized sigset_t's.  */

I've posted a patch to fix that earlier this month (Monday 13 Jan
2003 "[2.5 PATCH] signal handling").

BTW, anyone working on mips64 2.5 kernel should have a look at my patch
set (http://www.linux-mips.org/~glaurung/O2/linux-2.5.47/patches-2.5.47.tar.gz)
for patches named "linux-mips-*.diff" as they might be relevant for other
machines than just the O2, and the more they are tested the better. A
README is provided to explain briefly what they (try to) fix.

regards,
Vivien.
