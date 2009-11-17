Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2009 00:05:46 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48972 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493919AbZKQXFn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Nov 2009 00:05:43 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAHN5lLd002000;
	Wed, 18 Nov 2009 00:05:48 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAHN5iv0001997;
	Wed, 18 Nov 2009 00:05:44 +0100
Date:	Wed, 18 Nov 2009 00:05:44 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Gleixner <tglx@linutronix.de>
Cc:	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	linux-mips@linux-mips.org
Subject: Re: [patch 08/13] mips: Fixup last users of irq_chip->typename
Message-ID: <20091117230544.GA1866@linux-mips.org>
References: <20091117224852.846805939@linutronix.de> <20091117224916.642102675@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091117224916.642102675@linutronix.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 17, 2009 at 10:51:03PM -0000, Thomas Gleixner wrote:

> The typename member of struct irq_chip was kept for migration purposes
> and is obsolete since more than 2 years. Fix up the leftovers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

Looks good.  I assume you want to merge the whole series via tip, so

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
