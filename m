Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2007 23:53:18 +0000 (GMT)
Received: from [66.201.51.66] ([66.201.51.66]:36393 "EHLO ripper.onstor.net")
	by ftp.linux-mips.org with ESMTP id S20038881AbXBSXxO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Feb 2007 23:53:14 +0000
Received: from andys by ripper.onstor.net with local (Exim 4.63)
	(envelope-from <andy.sharp@onstor.com>)
	id 1HJIJg-0003AO-QK
	for linux-mips@linux-mips.org; Mon, 19 Feb 2007 15:53:08 -0800
Date:	Mon, 19 Feb 2007 15:53:08 -0800
From:	Andrew Sharp <tigerand@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] 98% of the changes necessary to support SMP on Sibyte 1250 without CFE.
Message-ID: <20070219235300.GA12148@onstor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tigerand@gmail.com
Precedence: bulk
X-list: linux-mips

This patch goes most of the way to adding SMP support to non-CFE Sibyte
machines.  Unfortunately I didn't quite get a chance to finish every
last bit, but perhaps I will get back to it later or someone else will
take a crack at it.

Since it isn't finished I didn't include any of the changes to the Kconfig
that are necessary to actually use the code.
