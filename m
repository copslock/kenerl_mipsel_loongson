Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Feb 2003 23:23:11 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:43672 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8225192AbTBPXXK>;
	Sun, 16 Feb 2003 23:23:10 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h1GNN6G8003535
	for <@external-mail-relay.sgi.com:linux-mips@linux-mips.org>; Sun, 16 Feb 2003 15:23:07 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id KAA26502 for <linux-mips@linux-mips.org>; Mon, 17 Feb 2003 10:23:05 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h1GNN18G028430
	for <linux-mips@linux-mips.org>; Mon, 17 Feb 2003 10:23:01 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h1GNN08B028428
	for linux-mips@linux-mips.org; Mon, 17 Feb 2003 10:23:00 +1100
Date: Mon, 17 Feb 2003 10:23:00 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Linux-MIPS <linux-mips@linux-mips.org>
Subject: bug in ip27 PROM
Message-ID: <20030216232300.GN8408@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1438
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Hi all,

I haven't been able to boot a kernel (neither IRIX nor Linux) directly
from the volume header on the ip27 (Origin 200).  I can only load
it from XFS partitions.

I've looked at the PROM source, and figured out that the XFS loader
loads in 64k chunks, but the volume header's loader loads in one
big read.  So, it's either failing due to a low timeout (old crappy
hard disks!), or the "large" buffer size isn't supported.

Anyone else experiencing this?

Anyway, the end result of this is it makes Flo's hack for embedding
a volume header on an ISO more Interesting.  I'll try making
a partition inside the ISO file system (overlapping with a file)
which contains an XFS file system containing kernels...

Cheers,
Andrew
