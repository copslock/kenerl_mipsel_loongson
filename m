Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 20:16:46 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47274 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022992AbZETTQj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 May 2009 20:16:39 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4KJGJIO002205;
	Wed, 20 May 2009 20:16:19 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4KJGIX8002204;
	Wed, 20 May 2009 20:16:18 +0100
Date:	Wed, 20 May 2009 20:16:18 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Sharp <andy.sharp@onstor.com>
Cc:	Laurent GUERBY <laurent@guerby.net>,
	Jon Fraser <jfraser@broadcom.com>,
	Andrew Wiley <debio264@gmail.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: Bigsur?
Message-ID: <20090520191618.GA32295@linux-mips.org>
References: <ecbbfeda0905152014t62281c79k2001e428da65a442@mail.gmail.com> <1242663215.18301.26.camel@chaos.ne.broadcom.com> <20090518222334.GD16847@linux-mips.org> <alpine.LFD.1.10.0905182335510.20791@ftp.linux-mips.org> <1242735440.6098.101.camel@localhost> <20090519125310.GA17733@linux-mips.org> <20090520110105.6fb81573@ripper.onstor.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090520110105.6fb81573@ripper.onstor.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 20, 2009 at 11:01:05AM -0700, Andrew Sharp wrote:

> Question: are machines that must be NFS-root and tftp booted acceptable
> or not acceptable for such work?  The machines in question would 750MHz
> Sibyte 1250s, so 3 Gigabit ports natively, and 2 serial consoles.

For many uses that will be decent but there are still a few things out
there that don't quite work the same way on NFS that they do on other
filesystems and that tends to break some software and autoconf-like
things.  I'd probably give such a config a 90% score - good for most stuff.

  Ralf
