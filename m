Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 15:35:13 +0100 (BST)
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:30216 "EHLO
	mail.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20038455AbWI1OfI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 15:35:08 +0100
Received: from zeus.sw.starentnetworks.com (zeus.sw.starentnetworks.com [12.33.233.46])
	by mail.sw.starentnetworks.com (Postfix) with ESMTP id 54A223E24C;
	Thu, 28 Sep 2006 10:34:59 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17691.56721.616378.698325@zeus.sw.starentnetworks.com>
Date:	Thu, 28 Sep 2006 10:34:57 -0400
From:	Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>, 
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: wrong SP restored after DBE exception
In-Reply-To: <20060928142840.GB3394@linux-mips.org>
References: <17690.54995.407882.581783@zeus.sw.starentnetworks.com>
	<20060928130925.GA3394@linux-mips.org>
	<Pine.LNX.4.64N.0609281448310.3949@blysk.ds.pg.gda.pl>
	<20060928142840.GB3394@linux-mips.org>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson+linux-mips@sw.starentnetworks.com,
Precedence: bulk
X-list: linux-mips

Ralf Baechle writes:
> I would suggest to disable interrupts around accesses that potencially
> could result in DB exceptions and just to make sure he is not getting
> trapped by a non-blocking load by making some use of any value read
> from the device.  Writes could be posted depending on bus type.  So
> having a read from the same device would force the write to complete.
> 
>   Ralf

Ya, I was about to try that.  I could be getting an interrupt
between the time the read is issued and the timeout occurs on the
GBus.  Also, doing a dummy read on the GBus to a device that
shouldn't fault prior to (for reads) or after (for writes) the
potentially faulting one to force ordering seems like a good idea
too.


-- 
Dave Johnson
Starent Networks
