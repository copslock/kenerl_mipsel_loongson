Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 03:19:55 +0200 (CEST)
Received: from bsdimp.com ([199.45.160.85]:60064 "EHLO harmony.bsdimp.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491107Ab0JOBTi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Oct 2010 03:19:38 +0200
Received: from localhost (localhost [127.0.0.1])
        by harmony.bsdimp.com (8.14.3/8.14.1) with ESMTP id o9F1D912012600;
        Thu, 14 Oct 2010 19:13:10 -0600 (MDT)
        (envelope-from imp@bsdimp.com)
Date:   Thu, 14 Oct 2010 19:13:09 -0600 (MDT)
Message-Id: <20101014.191309.515504596.imp@bsdimp.com>
To:     grant.likely@secretlab.ca
Cc:     ddaney@caviumnetworks.com, prasun.kapoor@caviumnetworks.com,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org
Subject: Re: Device Tree questions WRT MIPS/Octeon SOCs.
From:   Warner Losh <imp@bsdimp.com>
In-Reply-To: <AANLkTi=UM2p26JJMqv-cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
References: <4CB79D93.6090500@caviumnetworks.com>
        <AANLkTi=UM2p26JJMqv-cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <imp@bsdimp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28081
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imp@bsdimp.com
Precedence: bulk
X-list: linux-mips

In message: <AANLkTi=UM2p26JJMqv-cNh8xACS_KPf_dCst5cgmh5VR@mail.gmail.com>
            Grant Likely <grant.likely@secretlab.ca> writes:
: Overall the plan makes sense, however I would suggest the following.
: instead of 'live' modifying the tree, another option is to carry a set
: of 'stock' device trees in the kernel; one per board.  Of course this
: assumes that your current ad-hoc code is keying on the specific board.
:  If it is interpreting data provided by the firmware, then your
: suggestion of modifying a single stock tree probably makes more sense,
: or possibly a combination of the too.  In general you should avoid
: live modification as much as possible.

The one draw back on this is that there's lots of different "stock"
boards that the Cavium Octeon SDK supports.  These will be difficult
to drag along for every kernel.  And they'd be mostly the same to,
which is why I think that David is suggesting the live modification
thing...

I know that FreeBSD will have exactly the same problem as we move to
using the FDT for FreeBSD/mips' configuration.

Warner
