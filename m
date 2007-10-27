Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Oct 2007 08:06:59 +0100 (BST)
Received: from host182-219-dynamic.8-87-r.retail.telecomitalia.it ([87.8.219.182]:34186
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20023376AbXJ0HGv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 27 Oct 2007 08:06:51 +0100
Received: from eppesuig3 ([192.168.2.50])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1Ilfkr-0001Xh-Vg
	for linux-mips@linux-mips.org; Sat, 27 Oct 2007 09:06:47 +0200
Subject: 2.4.24-rc1 does not boot on SGI
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Date:	Sat, 27 Oct 2007 09:07:05 +0200
Message-Id: <1193468825.7474.6.camel@scarafaggio>
Mime-Version: 1.0
X-Mailer: Evolution 2.10.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

This is quick note about a problem with the latest kernel (yesterday
snapshot from linux-mips git repository).

The new kernel once again does not boot on SGI O2. What happens is that
arcboot write its messages and nothing more is displayed on the screen.
The last message is "Starting ELF64 kernel". The previous running kernel
were 2.6.23 from linux-mips.org and 2.6.23.1 from kernel.org.

Does anyone have a suggestion about what to look for? I will start
looking at all diffs in arch/mips/sgi-ip32.

Bye,
Giuseppe
