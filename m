Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Dec 2012 17:22:29 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56330 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6829678Ab2LDQWZQYc1n (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Dec 2012 17:22:25 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id qB4GMN9Y021324;
        Tue, 4 Dec 2012 17:22:23 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id qB4GMN1x021323;
        Tue, 4 Dec 2012 17:22:23 +0100
Date:   Tue, 4 Dec 2012 17:22:23 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: Pull request for v3.8 Octeon specific changes.
Message-ID: <20121204162222.GA21111@linux-mips.org>
References: <50B94DEB.3020608@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50B94DEB.3020608@caviumnetworks.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, Nov 30, 2012 at 04:23:07PM -0800, David Daney wrote:

> 
> The ATA changes are alredy Acked-by the ATA mainainer.
> 
> The EDAC changes are just an extension of what you added for 3.8, they
> were sent to the EDAC list here:
> 
> http://marc.info/?l=linux-edac&m=135302283022318&w=2
> 
> But no response yet.  My reasoning is that they should be OK as they
> just improve things that only touch OCTEON.

Yes and it'd be nice to have EDAC flying properly.

Lots of MIPS hardware has some EDAC capability.  I hope now that there is
at least one well supported platform EDAC support will spread.

Thanks,

  Ralf
