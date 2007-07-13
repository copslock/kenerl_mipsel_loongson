Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jul 2007 15:48:49 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:5322 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023694AbXGMOsW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 13 Jul 2007 15:48:22 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l6DEmKGo008791;
	Fri, 13 Jul 2007 15:48:20 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l6DEmIwD008790;
	Fri, 13 Jul 2007 15:48:18 +0100
Date:	Fri, 13 Jul 2007 15:48:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Morton <akpm@linux-foundation.org>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Mark Mason <mason@broadcom.com>,
	Andy Whitcroft <apw@shadowen.org>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Joel Schopp <jschopp@austin.ibm.com>,
	linux-mips@linux-mips.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb1250-duart.c: SB1250 DUART serial support
Message-ID: <20070713144818.GC8190@linux-mips.org>
References: <Pine.LNX.4.64N.0707121745010.3029@blysk.ds.pg.gda.pl> <20070712114712.de5d6c9d.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070712114712.de5d6c9d.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 12, 2007 at 11:47:12AM -0700, Andrew Morton wrote:

> There is no power management support in this driver.

There is hardly anything software could do to safe power on Sibyte SOCs.
Just like most other MIPS SOCs power managment is mostly left to the
hardware which does it by using extensive clockgating and other design
techniques.  As a SW person I can't protest that approach :-)

  Ralf
