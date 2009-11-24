Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 02:39:05 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33822 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1493513AbZKXBjC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 02:39:02 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAO1dGWB004212;
	Tue, 24 Nov 2009 01:39:16 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAO1dFNo004210;
	Tue, 24 Nov 2009 01:39:15 GMT
Date:	Tue, 24 Nov 2009 01:39:15 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Disable EARLY_PRINTK on IP22 to make the system boot
Message-ID: <20091124013915.GA3991@linux-mips.org>
References: <20091119164009.GA15038@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091119164009.GA15038@deprecation.cyrius.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 19, 2009 at 04:40:09PM +0000, Martin Michlmayr wrote:

> Some Debian users have reported that the kernel hangs early
> during boot on some IP22 systems.  Thomas Bogendoerfer found
> that this is due to a "bad interaction between CONFIG_EARLY_PRINTK
> and overwritten prom memory during early boot".  Since there's
> no fix yet, disable CONFIG_EARLY_PRINTK for now.
> 
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

Patch looks ok but I think IP28 needs the same change applied.  Will post
a new patch in separate mail.

  Ralf
