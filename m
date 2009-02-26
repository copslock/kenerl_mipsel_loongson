Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2009 17:49:14 +0000 (GMT)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47282 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20808689AbZBZRtM (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2009 17:49:12 +0000
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n1QHn94t001666;
	Thu, 26 Feb 2009 17:49:10 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n1QHn7Ks001662;
	Thu, 26 Feb 2009 17:49:07 GMT
Date:	Thu, 26 Feb 2009 17:49:07 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mark Asselstine <mark.asselstine@windriver.com>
Cc:	linux-mips@linux-mips.org, oprofile-list@lists.sf.net
Subject: Re: [PATCH] oprofile: VR5500 performance counter driver
Message-ID: <20090226174907.GA1222@linux-mips.org>
References: <1235406394-2650-1-git-send-email-mark.asselstine@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1235406394-2650-1-git-send-email-mark.asselstine@windriver.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 23, 2009 at 11:26:34AM -0500, Mark Asselstine wrote:

> +static int vr5500_perfcount_handler(void)
> +{
> +	unsigned int control;
> +	unsigned int counter;
> +	int handled = IRQ_NONE;
> +	unsigned int counters = NUM_COUNTERS;
> +
> +	if (cpu_has_mips_r2 && !(read_c0_cause() & (1 << 26)))
> +		return handled;

The Vr5500 is no R2 processor so these two lines are dead code.

  Ralf
