Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jun 2004 00:45:57 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:10991 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225609AbUFXXpx>;
	Fri, 25 Jun 2004 00:45:53 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i5ONjp4O001493;
	Thu, 24 Jun 2004 16:45:51 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i5ONjpT5001492;
	Thu, 24 Jun 2004 16:45:51 -0700
Date: Thu, 24 Jun 2004 16:45:51 -0700
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: IDE woos in BE mode 2.6 kernel
Message-ID: <20040624164551.H29225@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5361
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


Anybody has tried IDE disks in big endian mode with 2.6 kernel?
I seem to have troubles with Malta board.

Current malta board has CONFIG_SWAP_IO_SPACE defined and therefore
all inw, inl and their friends are byte-swapped in BE mode.  As a
results all IDE IO ops (such as ide_inw, etc) do swapping too.

A quick experiement shows those IDE IO ops should not do swapping.
Anybody knows why?

Apparently fixing the above is not enough.  I either encountered
failure to read partition table or having DMA error.  Any clues
here?

I suppose this problem really should exist for other arches
with BE support.  Anybody knows how other arches deal with this?

Thanks.

Jun
