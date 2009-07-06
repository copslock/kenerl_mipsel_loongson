Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jul 2009 12:22:32 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58292 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492880AbZGFKWZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 6 Jul 2009 12:22:25 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n66AFUP5014132;
	Mon, 6 Jul 2009 11:15:30 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n66AFTL3014130;
	Mon, 6 Jul 2009 11:15:29 +0100
Date:	Mon, 6 Jul 2009 11:15:29 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Akinobu Mita <akinobu.mita@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: drop mmap_sem in pagefault oom path
Message-ID: <20090706101529.GB11727@linux-mips.org>
References: <20090703163307.GA25268@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090703163307.GA25268@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23660
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 04, 2009 at 01:33:09AM +0900, Akinobu Mita wrote:

Thanks, applied!

  Ralf
