Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 13 Jun 2004 01:07:36 +0100 (BST)
Received: from quechua.inka.de ([IPv6:::ffff:193.197.184.2]:56234 "EHLO
	mail.inka.de") by linux-mips.org with ESMTP id <S8225238AbUFMAHc>;
	Sun, 13 Jun 2004 01:07:32 +0100
Received: from pcde.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1BZIX4-0000EE-00; Sun, 13 Jun 2004 02:07:30 +0200
Received: by aton.pcde.inka.de (Postfix, from userid 1001)
	id 428761E5C7; Sun, 13 Jun 2004 02:04:52 +0200 (CEST)
Date: Sun, 13 Jun 2004 02:04:52 +0200
From: Dennis Grevenstein <dennis@pcde.inka.de>
To: linux-mips@linux-mips.org
Subject: network problems with cobalt raq2
Message-ID: <20040613000452.GA3861@aton.pcde.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Return-Path: <dennis@pcde.inka.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis@pcde.inka.de
Precedence: bulk
X-list: linux-mips

Hi,

I've got some problems with my raq2. I want to set up the machine
as an internet gateway, because it can be perfectly silent if
you change that little fan.
The problem is that network performance is extremely bad.
I can transfer about 1MB/s at the very best. When it runs as
a masquerading router for my internal network performance
goes down even more. I can now ftp about 64kb/s to the raq.
Of course, I didn't expect that this little CPU would be a killer
router, but:
tessa:~# uptime
 02:01:21 up 55 min,  1 user,  load average: 0.00, 0.00, 0.00

There is essentially no load.This machine is about 95% idle.

I'm running Debian and the standard 2.4.26-r5k-cobalt.
I could not compile the current CVS kernel, but any hints
are greatly appreciated.

TIA
Dennis

-- 
de-moc-ra-cy (di mok' ra see) n.
Three wolves and a sheep voting on what's for dinner.
