Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Dec 2005 10:06:57 +0000 (GMT)
Received: from smtp.uk.colt.net ([195.110.64.125]:45773 "EHLO smtp.uk.colt.net")
	by ftp.linux-mips.org with ESMTP id S8133581AbVL3KGk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 30 Dec 2005 10:06:40 +0000
Received: from [10.0.1.4] (117-21-161-212.DSL.ONCOLT.COM [212.161.21.117])
	by smtp.uk.colt.net (Postfix) with ESMTP id 299A0E2CF5
	for <linux-mips@linux-mips.org>; Fri, 30 Dec 2005 09:59:39 +0000 (GMT)
From:	David Goodenough <david.goodenough@btconnect.com>
To:	linux-mips@linux-mips.org
Subject: Watchdog support on Broadcomm MIPS chips
Date:	Fri, 30 Dec 2005 10:08:35 +0000
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512301008.35788.david.goodenough@btconnect.com>
Return-Path: <david.goodenough@btconnect.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9755
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.goodenough@btconnect.com
Precedence: bulk
X-list: linux-mips

I was referred to this list as I am interested in extending the kind of 
support that I am used to with SC200 based systems to the systems
supported by OpenWrt such as the Netgear WGT634U which is built
around a Broadcomm BCM947XX chip.

In the bcm947xx arch directory on OpenWrt (and I am not quite sure
how it got there) there is some code (marked as copyright Broadcomm)
which talks about Watchdog functionality, but does not seem to link
it into the rest of the linux watchdog functionality which Alan Cox 
seems to have either written or rewritten.  There is a /dev/watchdog
that is used by a watchdog daemon (in the OpenWrt case this would be
the BusyBox watchdog function) to refresh the watchdog and stop
the box rebooting itself.

Does anyone know anything about watchdog functionality in the 
Broadcomm chips, or about the code that Broadcomm seem to have
written for it and how to use it?

Thanks in advance

David
