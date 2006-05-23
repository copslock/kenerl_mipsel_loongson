Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 May 2006 17:33:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44170 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133894AbWEWPdM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 May 2006 17:33:12 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k4NFXCu4019679;
	Tue, 23 May 2006 16:33:12 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k4NFXBun019678;
	Tue, 23 May 2006 16:33:11 +0100
Date:	Tue, 23 May 2006 16:33:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Late console
Message-ID: <20060523153311.GA3260@linux-mips.org>
References: <20060523134012.GB28124@enneenne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060523134012.GB28124@enneenne.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 23, 2006 at 03:40:12PM +0200, Rodolfo Giometti wrote:

> due my job on sleep I need the serial console till sleep time so let
> me propose this patch that disables serial port suspend if a console
> is running on it and the kernel has CONFIG_DEBUG_KERNEL flag on.

Patches for drivers/serial/ to:

8250/16?50 (AND CLONE UARTS) SERIAL DRIVER
P:      Russell King
M:      rmk+serial@arm.linux.org.uk
L:      linux-serial@vger.kernel.org
W:      http://serial.sourceforge.net
S:      Maintained

  Ralf
