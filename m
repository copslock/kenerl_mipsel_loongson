Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 22:30:21 +0000 (GMT)
Received: from nixon.xkey.com ([IPv6:::ffff:209.245.148.124]:31105 "HELO
	nixon.xkey.com") by linux-mips.org with SMTP id <S8225304AbSLQWaU>;
	Tue, 17 Dec 2002 22:30:20 +0000
Received: (qmail 6686 invoked from network); 17 Dec 2002 22:30:15 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 17 Dec 2002 22:30:15 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id gBHMTDL02135
	for linux-mips@linux-mips.org; Tue, 17 Dec 2002 14:29:13 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Tue, 17 Dec 2002 14:29:13 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips <linux-mips@linux-mips.org>
Subject: Re: PATCH
Message-ID: <20021217142913.A1921@wumpus.internal.keyresearch.com>
Mail-Followup-To: linux-mips <linux-mips@linux-mips.org>
References: <1039841567.25391.13.camel@adsl.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1039841567.25391.13.camel@adsl.pacbell.net>; from ppopov@mvista.com on Fri, Dec 13, 2002 at 08:52:47PM -0800
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Fri, Dec 13, 2002 at 08:52:47PM -0800, Pete Popov wrote:

> This patch was sent to the RageXL maintainer but I don't think he was
> interested in it. Others might find it useful on embedded systems. It
> initializes the RageXL card when there is no system bios to initialize
> it from the video bios.  Tested on the Pb1500; makes a really good
> workstation.

Pete,

Is there a website with info about graphics cards on non-x86
architectures? Most cards require their own BIOS to be run at boot
time. This issue ought to be of interest to lots of other communities
than MIPS.

-- greg
