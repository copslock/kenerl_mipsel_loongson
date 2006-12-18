Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Dec 2006 09:04:18 +0000 (GMT)
Received: from www.nabble.com ([72.21.53.35]:8938 "EHLO talk.nabble.com")
	by ftp.linux-mips.org with ESMTP id S20047876AbWLRJEM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 18 Dec 2006 09:04:12 +0000
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50)
	id 1GwEPq-0006ch-4E
	for linux-mips@linux-mips.org; Mon, 18 Dec 2006 01:04:10 -0800
Message-ID: <7925460.post@talk.nabble.com>
Date:	Mon, 18 Dec 2006 01:04:10 -0800 (PST)
From:	Daniel Laird <danieljlaird@hotmail.com>
To:	linux-mips@linux-mips.org
Subject: PAGE_ALIGN + PAGE_SHIFT from userspace
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Nabble-From: danieljlaird@hotmail.com
Return-Path: <lists@nabble.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danieljlaird@hotmail.com
Precedence: bulk
X-list: linux-mips


Hi All,

I was using linux 2.6.17.13 on my MIPS and it was all going well.  I am just
porting to 2.6.19 and am having a couple of issues.

My first issue is that i used to mmap a buffer from user space.  I used to
use a PAGE_ALIGN macro when doing this:
/** to align the pointer to the (next) page boundary */
#define PAGE_ALIGN(addr)	(((addr) + PAGE_SIZE - 1) & PAGE_MASK)

this worked as PAGE_SIZE and PAGE_MASK were available in page.h.

This have now been moved inside the #ifdef KERNEL guard in the header file. 
Meaning these are no longer available.

Are these available somewhere else?
Should I be doing something different to mmap?

Any help appreciated
Daniel Laird
-- 
View this message in context: http://www.nabble.com/PAGE_ALIGN-%2B-PAGE_SHIFT-from-userspace-tf2838680.html#a7925460
Sent from the linux-mips main mailing list archive at Nabble.com.
