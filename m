Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2002 16:38:11 +0200 (CEST)
Received: from [66.31.4.227] ([66.31.4.227]:25460 "EHLO
	ripple.nh.metrolink.com") by linux-mips.org with ESMTP
	id <S1122977AbSICOiK>; Tue, 3 Sep 2002 16:38:10 +0200
Received: (from lembree@localhost)
	by ripple.nh.metrolink.com (8.11.6/8.11.6) id g83EakD24451;
	Tue, 3 Sep 2002 10:36:46 -0400
X-Authentication-Warning: ripple.nh.metrolink.com: lembree set sender to lembree@metrolink.com using -f
Subject: Re: hints on wait queue bug?
From: Rob Lembree <lembree@metrolink.com>
To: Robert Lembree <lembree@metrolink.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <1030652956.1536.21.camel@ripple.nh.metrolink.com>
References: <1030652956.1536.21.camel@ripple.nh.metrolink.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Sep 2002 10:36:46 -0400
Message-Id: <1031063806.11894.16.camel@ripple.nh.metrolink.com>
Mime-Version: 1.0
Return-Path: <lembree@metrolink.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lembree@metrolink.com
Precedence: bulk
X-list: linux-mips

On Thu, 2002-08-29 at 16:29, Rob Lembree wrote:
> Hi there,
> 
> I've got a problem where lots of io to the console seems
> to break something in the kernel, resulting in a segfault,
> along with a kernel error.
> 
> I dove into it, and found that it's related to wait queue
> stuff.  I turned on the wait queue debugging, and got the
> following, just prior to things going off the deep end.
> 
> bad magic 802ccb24 (should be 802ccb2c), kernel BUG at sched.c:729!
> 
> Is there some tutorial on this stuff somewhere (besides
> reading the code -- I'm doing that now!)  
> 
> Has this stuff changed a great deal since 2.4.5 (when this
> code last worked correctly)?

Turns out that this is the same problem as the binutils bug
referenced back in January /February.  An upgrade will fix 
this.

r

> thanks,
> rob
> 
> -- 
> 
> Rob Lembree                        Metro Link Incorporated
> 29 Milk St.			     lembree@metrolink.com
> Nashua, NH 03064-1651             http://www.metrolink.com
> Phone:  954.660.2460               Alternate: 603.577.9714
> PGP: 1F EE F8 58 30 F1 B1 20       C5 4F 12 21 AD 0D 6B 29
-- 

Rob Lembree                        Metro Link Incorporated
29 Milk St.			     lembree@metrolink.com
Nashua, NH 03064-1651             http://www.metrolink.com
Phone:  954.660.2460               Alternate: 603.577.9714
PGP: 1F EE F8 58 30 F1 B1 20       C5 4F 12 21 AD 0D 6B 29
