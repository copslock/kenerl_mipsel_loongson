Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Nov 2014 17:09:49 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48527 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012688AbaKEQJrrrGUg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 5 Nov 2014 17:09:47 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sA5G9kgZ017345;
        Wed, 5 Nov 2014 17:09:46 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sA5G9kWa017344;
        Wed, 5 Nov 2014 17:09:46 +0100
Date:   Wed, 5 Nov 2014 17:09:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
Message-ID: <20141105160945.GB13785@linux-mips.org>
References: <54560D3B.8060602@gentoo.org>
 <5457CF0A.7020303@gmail.com>
 <5458272A.7050309@gentoo.org>
 <54582A91.8040401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54582A91.8040401@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43876
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

On Mon, Nov 03, 2014 at 05:23:29PM -0800, David Daney wrote:

> I haven't checked, but there may be workarounds required in the TLB
> management code that are not in place for the huge page case.  When the huge
> TLB code was developed, we didn't do any testing on R10K.  Somebody should
> dump the exception handlers and carefully look at the rest of the huge TLB
> management code, and check to see that any required workarounds are in
> place.

Joshua, if you happen to have R10000 errata sheets around, maybe you could
check if there's anything suspicious?  Off the top of my head I don't recall
any R10000 TLB erratas but the R10000 had plenty of erratas due to it's - by
the standards of the time - high complexity.

  Ralf
