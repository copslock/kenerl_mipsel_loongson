Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jan 2003 03:04:27 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:9978 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225223AbTA1DE0>;
	Tue, 28 Jan 2003 03:04:26 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h0S34Nw25713;
	Mon, 27 Jan 2003 19:04:23 -0800
Date: Mon, 27 Jan 2003 19:04:23 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: when does do_fpe() get called? (or when does FPE happen?)
Message-ID: <20030127190423.U11633@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


Can someone enlighten me a little?  I am trying
to figure out what the FPU state should be (or can be) when
we are inside do_fpe() routine.

Jun
