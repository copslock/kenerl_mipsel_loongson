Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2007 10:47:53 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:53955 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027275AbXJXJrv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 24 Oct 2007 10:47:51 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9O9lm9s004630
	for <linux-mips@linux-mips.org>; Wed, 24 Oct 2007 10:47:48 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9O9ll0s004629
	for linux-mips@linux-mips.org; Wed, 24 Oct 2007 10:47:47 +0100
Date:	Wed, 24 Oct 2007 10:47:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: 2.6.23-rc1 ...
Message-ID: <20071024094747.GA4470@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

I think Linus expressed it pretty well in his commit message:

commit c9927c2bf4f45bb85e8b502ab3fb79ad6483c244
Author: Linus Torvalds <torvalds@woody.linux-foundation.org>
Date:   Tue Oct 23 20:50:57 2007 -0700

    Linux 2.6.24-rc1
    
    The patch is big.  Really big.  You just won't believe how vastly hugely
    mindbogglingly big it is.  I mean you may think it's a long way down the
    road to the chemist, but that's just peanuts to how big the patch from
    2.6.23 is.
    
    But it's all good.
    
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

To put it into numbers, the diffstat summary is:

   8618 files changed, 535222 insertions(+), 256483 deletions(-)
   9473 files changed, 734462 insertions(+), 451280 deletions(-)

where the first one is accounting for renames, the second not.

The raw kernel patch is 1565010 lines or 47317945 bytes ...

There is still lots left to fix.  The time code turned into a larger
battlefield than my worst expectations.

So time to check how your favorite platform is doing and fix what broke!

Cheers,

  Ralf
