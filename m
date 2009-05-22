Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 21:33:36 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34312 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021485AbZEVUd3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 May 2009 21:33:29 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4MKXD5H017689;
	Fri, 22 May 2009 21:33:13 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4MKXC0P017688;
	Fri, 22 May 2009 21:33:12 +0100
Date:	Fri, 22 May 2009 21:33:12 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	matthieu castet <castet.matthieu@free.fr>
Cc:	linux-mips@linux-mips.org, Michael Buesch <mb@bu3sch.de>
Subject: Re: [PATCH] bc47xx : export ssb_watchdog_timer_set
Message-ID: <20090522203312.GA17677@linux-mips.org>
References: <4A170A20.5050608@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A170A20.5050608@free.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 22, 2009 at 10:25:04PM +0200, matthieu castet wrote:

> this patch export ssb_watchdog_timer_set to allow to use it in a Linux 
> watchdog driver.

Thanks, queued up for Linus.

  Ralf
