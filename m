Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2009 16:58:12 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:55227 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20808686AbZBZQ6I (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2009 16:58:08 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n1QGw2mL000352;
	Thu, 26 Feb 2009 16:58:03 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n1QGw0Fx000350;
	Thu, 26 Feb 2009 16:58:00 GMT
Date:	Thu, 26 Feb 2009 16:58:00 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Handle removal of 'h' constraint in GCC 4.4
Message-ID: <20090226165800.GA31972@linux-mips.org>
References: <1235516662-24919-1-git-send-email-ddaney@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1235516662-24919-1-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 24, 2009 at 03:04:22PM -0800, David Daney wrote:

> Due to the removal of the 'h' asm constraint in GCC-4.4, we need to
> adjust the computation in delay.h

It's time to take a step back and think over the whole thing once more.

Inlining __udelay can be problematic on some processors where the
execution performance of the delay loop will be different if the loop is
crossing a cacheline or not.  That seems to particularly hit R10000
systems often.  The number of the loop interations does the wrong tradeoff
between accuracy and the value range needed.  The resulting overflows on a
HZ=128 4000 BogoMIPS machine are fantastic :-)

Time to reimplement udelay I'd say.

  Ralf
