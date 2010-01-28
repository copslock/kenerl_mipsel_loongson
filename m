Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 14:53:49 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50958 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492362Ab0A1NxZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jan 2010 14:53:25 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0SDrZe6021914;
        Thu, 28 Jan 2010 14:53:35 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0SDrYRd021911;
        Thu, 28 Jan 2010 14:53:34 +0100
Date:   Thu, 28 Jan 2010 14:53:34 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     pascal@pabr.org, linux-mips@linux-mips.org
Subject: Re: [RFC] Support 36-bit iomem on 32-bit Au1x00
Message-ID: <20100128135334.GA14978@linux-mips.org>
References: <hhq35v$m1q$1@ger.gmane.org>
 <f861ec6f1001261246y545e7a9ahe11eaf16fd587959@mail.gmail.com>
 <i8xpr4wftsy.fsf@pabr.org>
 <20100128131858.GA13807@linux-mips.org>
 <f861ec6f1001280522u5689e1f5i4527101a48e5f347@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f861ec6f1001280522u5689e1f5i4527101a48e5f347@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18223

On Thu, Jan 28, 2010 at 02:22:55PM +0100, Manuel Lauss wrote:

> > Today I think it would be preferable to get rid of the the fixups, pay the
> > small price for the larger resources and get sanity in exchange.  My gut
> > feeling is that the bloat factor should be small.  Either way, I'll let
> > you two sort this out for Alchemy and mark this patch as defered.
> 
> I'm fine with it as-is; it doesn't break anything.  I was experimenting with
> extending the PCMCIA socket code to pass on 36bit addresses and got
> bitten by the driver core.

Fine, so I applied the patch and fixed up the reject.

Pascal, please include a Signed-off-by: line in future patches.

  Ralf
