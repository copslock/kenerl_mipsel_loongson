Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Nov 2004 13:25:20 +0000 (GMT)
Received: from pD95621F5.dip.t-dialin.net ([IPv6:::ffff:217.86.33.245]:37180
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225346AbUKINZQ>; Tue, 9 Nov 2004 13:25:16 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id iA9DP9Gt001029;
	Tue, 9 Nov 2004 14:25:09 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id iA9DP9H4001028;
	Tue, 9 Nov 2004 14:25:09 +0100
Date: Tue, 9 Nov 2004 14:25:09 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Koeller <thomas.koeller@baslerweb.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Function / prototype mismatch
Message-ID: <20041109132509.GA983@linux-mips.org>
References: <200411091328.42360.thomas.koeller@baslerweb.com> <20041109124547.GA5766@lst.de> <20041109125418.GC5652@linux-mips.org> <20041109125912.GA6222@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109125912.GA6222@lst.de>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 09, 2004 at 01:59:12PM +0100, Christoph Hellwig wrote:

> Well, 90% of it as __do_IRQ ;-)

Would seem natural to have the same prototype for both, wouldn't it?

  Ralf
