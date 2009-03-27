Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Mar 2009 22:47:56 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:20142 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20027332AbZC0Wry (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 27 Mar 2009 22:47:54 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n2RMlp8S027429;
	Fri, 27 Mar 2009 23:47:51 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n2RMlo85027427;
	Fri, 27 Mar 2009 23:47:50 +0100
Date:	Fri, 27 Mar 2009 23:47:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: __raw_spin_lock() spins forever on ticket wrap.
Message-ID: <20090327224750.GA26631@linux-mips.org>
References: <1238173622-12585-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1238173622-12585-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22161
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 27, 2009 at 10:07:02AM -0700, David Daney wrote:

> If the lock is not acquired and has to spin *and* the second attempt
> to acquire the lock fails, the delay time is not masked by the ticket
> range mask.  If the ticket number wraps around to zero, the result is
> that the lock sampling delay is essentially infinite (due to casting
> -1 to an unsigned int).
> 
> The fix: Always mask the difference between my_ticket and the current
> ticket value before calculating the delay.

Thanks, applied!

  Ralf
