Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2004 15:51:09 +0100 (BST)
Received: from trump.cadenux-support.com ([IPv6:::ffff:66.135.34.142]:41610
	"EHLO cadenux.com") by linux-mips.org with ESMTP
	id <S8224942AbUJFOvE>; Wed, 6 Oct 2004 15:51:04 +0100
Received: from t32 (unknown [200.12.239.3])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by cadenux.com (Postfix) with ESMTP id 880003A005E
	for <linux-mips@linux-mips.org>; Wed,  6 Oct 2004 16:27:29 +0000 (UTC)
Subject: gcc 3.4 / bad_unaligned_access_length
From: Gregory Nutt <greg.nutt@cadenux.com>
Reply-To: greg.nutt@cadenux.com
To: linux-mips@linux-mips.org
Content-Type: text/plain
Organization: Cadenux, LLC
Message-Id: <1097074271.9253.8.camel@spudrun>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 06 Oct 2004 08:51:11 -0600
Content-Transfer-Encoding: 7bit
Return-Path: <greg.nutt@cadenux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.nutt@cadenux.com
Precedence: bulk
X-list: linux-mips

Hi, List,

I have been struggling to bring up 2.6.8-rc2 on an Au1100 processor.  I
am using gcc 3.4.1 which seems to the be source of most of the issues
that I have been having.

Here is the last issue:

- At boot time, I was encountering a fault in slab.c -- ac_data
  was returning a NULL pointer.  But when I put in lots of printk's
  the problem disappeared.  Hmmm.. sound like an optimization
  issue.  Has anyone else seen this?

- So I tried lowering the optimization to -O1 by editting the top-
  level Makefile.  Now, to my surprise, I can no longer link the
  kernel.  I get:

  "fs/built-in.o(.text+0x3a0c4): In function `parse_extended':
  : undefined reference to `bad_unaligned_access_length'"

  This repeats several times.

I grep'ped through the kernel.  I see that bad_unaligned_access_length()
is externed in include/asm-mips/unaligned.h.  It is also used in the
default: case of several inline functions in that same file.  It is not
referenced or defined anywhere else in the kernel.

My hunch is that at -O2 the calls to bad_unaligned_access_length() were
optimized away and all is well.  But at -O1 they are not.

Greg Nutt
-- 
Gregory Nutt <greg.nutt@cadenux.com>
Cadenux, LLC
