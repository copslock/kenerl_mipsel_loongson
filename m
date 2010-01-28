Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 14:18:56 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53040 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492304Ab0A1NSw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 28 Jan 2010 14:18:52 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o0SDIx8A014736;
        Thu, 28 Jan 2010 14:19:00 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o0SDIw0j014725;
        Thu, 28 Jan 2010 14:18:58 +0100
Date:   Thu, 28 Jan 2010 14:18:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     pascal@pabr.org
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>,
        linux-mips@linux-mips.org
Subject: Re: [RFC] Support 36-bit iomem on 32-bit Au1x00
Message-ID: <20100128131858.GA13807@linux-mips.org>
References: <hhq35v$m1q$1@ger.gmane.org>
 <f861ec6f1001261246y545e7a9ahe11eaf16fd587959@mail.gmail.com>
 <i8xpr4wftsy.fsf@pabr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i8xpr4wftsy.fsf@pabr.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 25710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18201

On Tue, Jan 26, 2010 at 10:19:22PM +0100, pascal@pabr.org wrote:

The whole fixing up of I/O addresses was necessary because the generic
code was written to assume that sizeof(unsigned long) == sizeof(void *)
and that mostly because it was handy for Linus' i386 world.

Today I think it would be preferable to get rid of the the fixups, pay the
small price for the larger resources and get sanity in exchange.  My gut
feeling is that the bloat factor should be small.  Either way, I'll let
you two sort this out for Alchemy and mark this patch as defered.

  Ralf
