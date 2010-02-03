Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2010 15:36:32 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41994 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492652Ab0BCOg2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Feb 2010 15:36:28 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o13EajGi029194;
        Wed, 3 Feb 2010 15:36:45 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o13EailD029190;
        Wed, 3 Feb 2010 15:36:44 +0100
Date:   Wed, 3 Feb 2010 15:36:43 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH urgent] MIPS: fix micro-assembly overflow in
 set_except_vector
Message-ID: <20100203143643.GA27068@linux-mips.org>
References: <201002011027.37521.florian@openwrt.org>
 <20100201103628.GA15661@alpha.franken.de>
 <201002021006.35731.florian@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201002021006.35731.florian@openwrt.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 02, 2010 at 10:06:35AM +0100, Florian Fainelli wrote:

> On Monday 01 February 2010 11:36:28 Thomas Bogendoerfer wrote:
> > On Mon, Feb 01, 2010 at 10:27:37AM +0100, Florian Fainelli wrote:
> > > Commit 24a6d9866c5f15ba7e5b14dc17be4b6edba21d0e broke
> > > the installation of handlers for boards which have their
> > > handlers above a 1 << 26 address. Fix this by making sure that
> > > jump_mask does not excess 0xfc000000 and add the missing ~ operator
> > 
> > j can handle 28 bit jump targets (26 bit in instruction plus two 0 bits
> > for 32bit aligment), so 0xf000000 was IMHO fine.
> 
> Corrected version below, thanks.

Folded into the existing -queue patch.

Thanks,

  Ralf
