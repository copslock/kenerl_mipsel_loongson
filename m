Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 10:03:16 +0100 (WEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:33114 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20022544AbZFCJDJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 Jun 2009 10:03:09 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5392eFn031999;
	Wed, 3 Jun 2009 10:02:40 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5392cLD031997;
	Wed, 3 Jun 2009 10:02:38 +0100
Date:	Wed, 3 Jun 2009 10:02:38 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Matt Mackall <mpm@selenic.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng: Add TX4939 RNG driver (v2)
Message-ID: <20090603090238.GH23561@linux-mips.org>
References: <1243954462-18149-1-git-send-email-anemo@mba.ocn.ne.jp> <1243973584.22069.182.camel@calx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1243973584.22069.182.camel@calx>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 02, 2009 at 03:13:04PM -0500, Matt Mackall wrote:

> On Tue, 2009-06-02 at 23:54 +0900, Atsushi Nemoto wrote:
> > This patch adds support for the integrated RNG of the TX4939 SoC.
> > 
> > Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
> 
> Acked-by: Matt Mackall <mpm@selenic.com>

Ok, I'll send this to Linus for 2.6.31 then.

Thanks,

   Ralf
