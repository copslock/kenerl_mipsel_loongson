Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 18:56:04 +0100 (BST)
Received: from newmail.sw.starentnetworks.com ([12.33.234.78]:17423 "EHLO
	mail.sw.starentnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20039093AbWI1R4D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 18:56:03 +0100
Received: from zeus.sw.starentnetworks.com (zeus.sw.starentnetworks.com [12.33.233.46])
	by mail.sw.starentnetworks.com (Postfix) with ESMTP id 93A743E24C;
	Thu, 28 Sep 2006 13:55:53 -0400 (EDT)
From:	Dave Johnson <djohnson@sw.starentnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17692.3241.497548.701401@zeus.sw.starentnetworks.com>
Date:	Thu, 28 Sep 2006 13:55:53 -0400
To:	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: wrong SP restored after DBE exception
In-Reply-To: <17691.56721.616378.698325@zeus.sw.starentnetworks.com>
References: <17690.54995.407882.581783@zeus.sw.starentnetworks.com>
	<20060928130925.GA3394@linux-mips.org>
	<Pine.LNX.4.64N.0609281448310.3949@blysk.ds.pg.gda.pl>
	<20060928142840.GB3394@linux-mips.org>
	<17691.56721.616378.698325@zeus.sw.starentnetworks.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Return-Path: <djohnson@sw.starentnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: djohnson@sw.starentnetworks.com
Precedence: bulk
X-list: linux-mips

Dave Johnson <djohnson+linux-mips@sw.starentnetworks.com>, writes:
> Ralf Baechle writes:
> > I would suggest to disable interrupts around accesses that potencially
> > could result in DB exceptions and just to make sure he is not getting
> > trapped by a non-blocking load by making some use of any value read
> > from the device.  Writes could be posted depending on bus type.  So
> > having a read from the same device would force the write to complete.

Disabling interrupts around the accesses works ok.  My test program
has caused about 400000 DBEs so far with no problem.

Thanks.

-- 
Dave Johnson
Starent Networks
