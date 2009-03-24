Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Mar 2009 13:17:12 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:25304 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S21366676AbZCXNRK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Mar 2009 13:17:10 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2ODH8lH011515;
	Tue, 24 Mar 2009 14:17:09 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2ODH7Ji011513;
	Tue, 24 Mar 2009 14:17:07 +0100
Date:	Tue, 24 Mar 2009 14:17:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kevin Hickey <khickey@rmicorp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH v2 5/6] Alchemy: DB1300 blink leds on timer tick
Message-ID: <20090324131707.GA6509@linux-mips.org>
References: <1237582306-10800-1-git-send-email-khickey@rmicorp.com> <1237582306-10800-2-git-send-email-khickey@rmicorp.com> <1237582306-10800-3-git-send-email-khickey@rmicorp.com> <1237582306-10800-4-git-send-email-khickey@rmicorp.com> <1237582306-10800-5-git-send-email-khickey@rmicorp.com> <1237582306-10800-6-git-send-email-khickey@rmicorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1237582306-10800-6-git-send-email-khickey@rmicorp.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 20, 2009 at 03:51:45PM -0500, Kevin Hickey wrote:

> Blinks the dots on the hex display on the DB1300 board every 1000 timer ticks.
> This can help tell the difference between a soft and hard hung board.

How about putting this into a software timer.  The Malta does that for its
ASCII display, see arch/mips/mti-malta/malta-display.c.

  Ralf
