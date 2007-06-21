Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2007 18:13:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:34278 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021764AbXFURNu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 21 Jun 2007 18:13:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l5LH61Dl027890;
	Thu, 21 Jun 2007 18:06:02 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l5LH617A027889;
	Thu, 21 Jun 2007 18:06:01 +0100
Date:	Thu, 21 Jun 2007 18:06:01 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Gary Smith <gary.smith@3phoenix.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Question About Timers for Performance Analysis on BCM1480/1250
	Systems
Message-ID: <20070621170601.GD21938@linux-mips.org>
References: <005a01c7b28b$ed279120$8facaac0@3PiGAS>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005a01c7b28b$ed279120$8facaac0@3PiGAS>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 19, 2007 at 12:07:21PM -0400, Gary Smith wrote:

> The following message thread is present in the Linux-Mips archives regarding
> the use of gettimeofday on Broadcom MIPS systems.
> http://www.linux-mips.org/archives/linux-mips/2006-01/msg00144.html  The
> message thread specifically addresses the Dual-core Broadcom 1250 system,
> and the kernel version mentioned in the message thread is 2.6.12.  I looked
> at the files mentioned in the message thread in the 2.6.17 kernel, and the
> changes suggested for arch/mips/dec/time.c were present in 2.6.17.  However,
> the subsequent patches suggested in the message thread were not present in
> the version of the 2.6.17 kernel I checked.  We'd like to ask if the patches
> suggested in the message thread have been observed to influence performance
> numbers obtained by other Linux system developers for Quad-core Broadcom
> 1480 systems?  If so, do the Linux-Mips developers suggest that we apply the
> patches suggested in the message thread for our Broadcom 1480 MIPS specific
> Linux 2.6.17 system implementation?

The patch never went in.

I'm currently turning the entire time code upside down which will also solve
this issue.

  Ralf
