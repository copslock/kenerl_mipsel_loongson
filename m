Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2003 05:59:22 +0100 (BST)
Received: from p508B6A7B.dip.t-dialin.net ([IPv6:::ffff:80.139.106.123]:25802
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225205AbTFYE7U>; Wed, 25 Jun 2003 05:59:20 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5P4xIML029426;
	Wed, 25 Jun 2003 06:59:19 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5P4xG4Y029425;
	Wed, 25 Jun 2003 06:59:16 +0200
Date: Wed, 25 Jun 2003 06:59:16 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Joseph Chiu <joseph@omnilux.net>
Cc: Pete Popov <ppopov@mvista.com>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
Subject: Re: wired tlb entry?
Message-ID: <20030625045916.GA28556@linux-mips.org>
References: <1055873800.4383.220.camel@zeus.mvista.com> <BPEELMGAINDCONKDGDNCMEGADMAA.joseph@omnilux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BPEELMGAINDCONKDGDNCMEGADMAA.joseph@omnilux.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2701
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 17, 2003 at 11:51:13AM -0700, Joseph Chiu wrote:

> Michael Guo suggested add_wired_entry -- I'm giving that a try now.  I'm
> trying to stick to "the kernel that we trust" (from the perspective here)
> because I'm worried about what I end up breaking trying to take a new
> kernel.
> 
> I am behind the time, though, so I'll try to test out 2.4.21-pre4 when I get
> back (I'm not available to run the tests during the rest of this week).

Usual warning - wired entries are almost always a bad idea.  TLB entries
are a scarce resource and wiring will reduce the number available for
random replacement even further raising the amount of CPU burned in the
TLB reload handler.

  Ralf
