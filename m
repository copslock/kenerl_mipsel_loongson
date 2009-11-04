Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Nov 2009 14:48:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:44313 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493272AbZKDNsv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Nov 2009 14:48:51 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nA4DoI0t017455;
	Wed, 4 Nov 2009 14:50:18 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nA4DoHUd017453;
	Wed, 4 Nov 2009 14:50:17 +0100
Date:	Wed, 4 Nov 2009 14:50:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Maxime Bizon <mbizon@freebox.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: BCM63xx: Fix serial driver compile breakage.
Message-ID: <20091104135017.GA15430@linux-mips.org>
References: <1257340275.2926.7.camel@sakura.staff.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257340275.2926.7.camel@sakura.staff.proxad.net>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 04, 2009 at 02:11:15PM +0100, Maxime Bizon wrote:

> To: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

> bcm63xx does not compile on current linus' tree, could you please apply
> the attached patch and send it to linus ? Thanks !

Will do - but (rant starts here) please remember to cc the respective
mailing lists and and maintainers for drivers in the future.

  Ralf
