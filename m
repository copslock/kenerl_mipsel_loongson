Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Nov 2007 13:01:43 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:49871 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28575513AbXK2NBl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Nov 2007 13:01:41 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lATD1Vge015527;
	Thu, 29 Nov 2007 13:01:31 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lATD1UEN015526;
	Thu, 29 Nov 2007 13:01:30 GMT
Date:	Thu, 29 Nov 2007 13:01:30 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [UPDATED PATCH] IP28 support
Message-ID: <20071129130130.GA14655@linux-mips.org>
References: <20071129095442.C6679C2B39@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20071129095442.C6679C2B39@solo.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17641
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 29, 2007 at 10:54:42AM +0100, Thomas Bogendoerfer wrote:

> Add support for SGI IP28 machines (Indigo 2 with R10k CPUs)
> This work is mainly based on Peter Fuersts work.

Queued for 2.6.25.  There clearly is work remaining to be done but the
code is now in an acceptable shape and the best way to push it forward
is integrating it.  Thanks for all the work and especially to Peter
Fürst for the initial heavyweight lifting!

  Ralf
