Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Feb 2007 23:54:37 +0000 (GMT)
Received: from [66.201.51.66] ([66.201.51.66]:61224 "EHLO ripper.onstor.net")
	by ftp.linux-mips.org with ESMTP id S20038883AbXBSXyc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 19 Feb 2007 23:54:32 +0000
Received: from andys by ripper.onstor.net with local (Exim 4.63)
	(envelope-from <andy.sharp@onstor.com>)
	id 1HJIKw-0003Aw-Hy
	for linux-mips@linux-mips.org; Mon, 19 Feb 2007 15:54:26 -0800
Date:	Mon, 19 Feb 2007 15:54:26 -0800
From:	Andrew Sharp <tigerand@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] 98% of the changes necessary to support SMP on Sibyte 1250 without CFE.
Message-ID: <20070219235419.GA12181@onstor.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <andy.sharp@onstor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tigerand@gmail.com
Precedence: bulk
X-list: linux-mips


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch goes most of the way to adding SMP support to non-CFE Sibyte
machines.  Unfortunately I didn't quite get a chance to finish every
last bit, but perhaps I will get back to it later or someone else will
take a crack at it.

Since it isn't finished I didn't include any of the changes to the Kconfig
that are necessary to actually use the code.

Might as well attach the patch this time.

a


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0005-98-of-the-changes-necessary-to-support-SMP-on-Sibyte-1250-without-CFE.txt"
