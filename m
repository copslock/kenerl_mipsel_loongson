Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2006 19:12:35 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:15294 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133530AbWF1SM1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Jun 2006 19:12:27 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k5SICN8Q031273;
	Wed, 28 Jun 2006 19:12:23 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k5SICMQO031272;
	Wed, 28 Jun 2006 19:12:22 +0100
Date:	Wed, 28 Jun 2006 19:12:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Erik Frederiksen <erik_frederiksen@pmc-sierra.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: errno value for EDQUOT on MIPS
Message-ID: <20060628181222.GA28516@linux-mips.org>
References: <1151512806.3901.1082.camel@girvin.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151512806.3901.1082.camel@girvin.pmc-sierra.bc.ca>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 28, 2006 at 10:40:07AM -0600, Erik Frederiksen wrote:

> from include/asm-mips/errno.h
> #define EDQUOT      1133    /* Quota exceeded */
> 
> Hi everyone.  I'm kind of confused as to why the value for EDQUOT is so
> large on MIPS.  It seems like no other architectures have errnos that go
> that high.

History; the errno values were inheritted from earlier MIPS operating
systems at a time when that seemed to be a good idea because Linux was
the new kid in town.

> The reason I'm interested is that functions that use ERR_PTR() to return
> error codes in pointers cannot return this error code without IS_ERR()
> thinking that the pointer is valid.  In my case, it caused an alignment
> exception in the XFS open call when quota has been exceeded.  This takes
> place in the linux-mips 2.6.14 kernel.  
> 
> I think that the XFS code has changed enough that this bug isn't in
> newer versions, though I'm not sure about that.  I've supplied a patch
> that addresses this situation by changing the threshold used by IS_ERR
> if EMAXERRNO is defined and greater than 1000.  Looking forward to your
> feedback.

The value 1000 has been choosen pretty arbitrarily I think.  Not sure if
a complicated solution is actually needed.

You may try raising that number to a higher value and posting the patch to
linux-kernel@vger.kernel.org to see if other have an issue with such a
change.

   Ralf
