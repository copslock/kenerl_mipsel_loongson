Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2009 14:07:54 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57783 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492249AbZGMMHr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Jul 2009 14:07:47 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n6DC7rEj026145;
	Mon, 13 Jul 2009 13:07:53 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n6DC7qlh026143;
	Mon, 13 Jul 2009 13:07:52 +0100
Date:	Mon, 13 Jul 2009 13:07:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Define MIPS34K_MISSED_ITLB_WAR for non-MSP7120 boards
Message-ID: <20090713120752.GC25606@linux-mips.org>
References: <E1MQ2LI-00069m-AX@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1MQ2LI-00069m-AX@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23732
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jul 12, 2009 at 10:56:00AM -0600, Shane McDonald wrote:
> From: Shane McDonald <mcdonald.shane@gmail.com>
> Date: Sun, 12 Jul 2009 10:56:00 -0600
> To: linux-mips@linux-mips.org, ralf@linux-mips.org
> Subject: [PATCH] Define MIPS34K_MISSED_ITLB_WAR for non-MSP7120 boards
> 
> The msp71xx/war.h file defines the value of MIPS34K_MISSED_ITLB_WAR
> for the various MSP7120 boards, but doesn't specify a value for other
> board types.  Set it to 0 for other boards.
> 
> This fixes a compile error when building for the MSP4200 boards.

Thanks for the patch; I applied Florian's identical patch on the merrit
that it was submitted earlier.

  Ralf
