Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Mar 2009 10:24:42 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:59588 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S21369799AbZCTKYe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Mar 2009 10:24:34 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1Lkbtw-0007Lf-00; Fri, 20 Mar 2009 11:24:32 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 1E552C2B2E; Fri, 20 Mar 2009 11:15:49 +0100 (CET)
Date:	Fri, 20 Mar 2009 11:15:49 +0100
To:	Craig Nadler <craig@nadler.us>
Cc:	linux-mips@linux-mips.org
Subject: Re: PCI IO access problem on BCM1480
Message-ID: <20090320101548.GA6747@alpha.franken.de>
References: <0124667e2b16bc6c1ec9870b17e5ddbb.squirrel@www.eskimo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0124667e2b16bc6c1ec9870b17e5ddbb.squirrel@www.eskimo.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Thu, Mar 19, 2009 at 07:27:25PM -0400, Craig Nadler wrote:
>      I'm have problems using a Technobox 4960 4-port RS-232 PMC (PCI) card
> on a board based on the Broadcom 1480 (MIPS) SOC. Each serial port on
> the PMC card uses a 16550A UART accessed using BAR2 thru BAR5. The
> BCM1480 based system board is running Linux 2.6.20.1 and a boot
> loader software called CFE from Broadcom.

could you try a newer kernel ? I've fixed PCI IO access some time ago.
It should be included in 2.6.25 and newer.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
