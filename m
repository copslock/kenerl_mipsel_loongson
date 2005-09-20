Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Sep 2005 16:34:32 +0100 (BST)
Received: from smtp.wicomtechnologies.com ([IPv6:::ffff:195.234.214.162]:13793
	"EHLO smtp.wicomtechnologies.com") by linux-mips.org with ESMTP
	id <S8225202AbVITPeN>; Tue, 20 Sep 2005 16:34:13 +0100
Received: from [192.168.0.24] (wcm-24.wicom.kiev.ua [192.168.0.24] (may be forged))
	by smtp.wicomtechnologies.com (8.12.10/8.12.10) with ESMTP id j8KFY1NC060633;
	Tue, 20 Sep 2005 18:34:01 +0300 (EEST)
	(envelope-from jerry@wicomtechnologies.com)
Date:	Tue, 20 Sep 2005 18:33:57 +0300
From:	Jerry <jerry@wicomtechnologies.com>
X-Mailer: The Bat! (v3.51.10) Professional
Reply-To: Jerry <jerry@wicomtechnologies.com>
X-Priority: 3 (Normal)
Message-ID: <622539804.20050920183357@wicomtechnologies.com>
To:	Pete Popov <ppopov@embeddedalley.com>
CC:	linux-mips@linux-mips.org
Subject: Re[2]: CVS Update@linux-mips.org: linux
In-Reply-To: <1127228028.4948.228.camel@localhost.localdomain>
References: <20050920002016Z8225531-3678+9789@linux-mips.org>
 <477557788.20050920111957@wicomtechnologies.com>
 <1127228028.4948.228.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <jerry@wicomtechnologies.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerry@wicomtechnologies.com
Precedence: bulk
X-list: linux-mips

>[In reply to "CVS Update@linux-mips.org: linux" from Pete Popov <ppopov@embeddedalley.com> to Jerry <jerry@wicomtechnologies.com>  20.09.2005 17:53]

> What's mostly unusable? I only did cosmetic cleanups of this one and
> gave it a quick test. Seemed to work fine. Let me know what you've
> tested and didn't work for you and we'll fix it at some point.

Generic fb may work (but some months ago I tested earlier version for
2.4 and it fails on most graphic tests (I used tests for SDL)). It
grows up, and this version may work well with base fb, but au1200 has
some advances and all its specifics controls through ioctl. Ioctl code
#defined in driver's .c source (hehe) it's very unusual way :) There's
no header file to work with the driver from kernel/userspace.

Driver has it's own mmap implementation but it left from au1100 driver
where it controlled ...cache lines. In au1200 it does noting unusual
and actually is a copy of generic fb mmap from kernel. One can remove
au1200_fb_mmap to use standart func to mmap memory but it needs to
properly set fix.mmio_start and family to work properly...

It has a CRT but cannot change videomodes.. etc ..etc

In short, if you'll work with device, all this little invisible things
will shown up.. But again, as base console fb it may work well.

Pity, about a month ago we suspended our au1200 project for some
months. Hope I will able to help with driver when we'll continue it.


   ()_()
 -( ^,^ )- -[21398845]- -<The Bat! 3.51.10>- -<20.09.2005 17:57>-
  (") (")
