Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2003 14:25:55 +0000 (GMT)
Received: from p508B69C2.dip.t-dialin.net ([IPv6:::ffff:80.139.105.194]:61620
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225241AbTA2OZz>; Wed, 29 Jan 2003 14:25:55 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h0TEPht26540;
	Wed, 29 Jan 2003 15:25:43 +0100
Date: Wed, 29 Jan 2003 15:25:43 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Mike Uhler <uhler@mips.com>
Cc: Jun Sun <jsun@mvista.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: unaligned load in branch delay slot
Message-ID: <20030129152543.B25701@linux-mips.org>
References: <20030128095347.W11633@mvista.com> <200301281948.h0SJmug29073@uhler-linux.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301281948.h0SJmug29073@uhler-linux.mips.com>; from uhler@mips.com on Tue, Jan 28, 2003 at 11:48:56AM -0800
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Mike,

On Tue, Jan 28, 2003 at 11:48:56AM -0800, Mike Uhler wrote:

> Let me give the list some background on this to aid in understanding.

Thanks for elaborating on this problem.

My workaround was trying so deal with a different problem so I'm going to
pull that patch again until the nature of Geert's problem is fully
understood.

  Ralf
