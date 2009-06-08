Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 19:59:35 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59290 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023602AbZFHS72 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jun 2009 19:59:28 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n58IwrTo019955;
	Mon, 8 Jun 2009 19:58:53 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n58IwqWV019953;
	Mon, 8 Jun 2009 19:58:52 +0100
Date:	Mon, 8 Jun 2009 19:58:52 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] SIBYTE: remove irritating printk from set_affinity
Message-ID: <20090608185851.GB15590@linux-mips.org>
References: <20090606075355.C0A64C35B8@solo.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090606075355.C0A64C35B8@solo.franken.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jun 06, 2009 at 09:53:55AM +0200, Thomas Bogendoerfer wrote:

> set_affinity() will be called with cpui masks, which have more than one
> cpu set. Instead of generating noise we now select the first set
> cpu and use that for setting affinity.

Thanks, applied.

  Ralf
