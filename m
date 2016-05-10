Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 12:24:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40256 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028620AbcEJKYHqevop (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 May 2016 12:24:07 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4AAO6cq020859;
        Tue, 10 May 2016 12:24:06 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4AAO6u2020858;
        Tue, 10 May 2016 12:24:06 +0200
Date:   Tue, 10 May 2016 12:24:06 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Matt Redfearn <Matt.Redfearn@imgtec.com>
Subject: Re: [PATCH 2/5] MIPS: Add defs & probing of 64-bit CP0_EBase
Message-ID: <20160510102406.GF16402@linux-mips.org>
References: <1461937563-13199-1-git-send-email-james.hogan@imgtec.com>
 <1461937563-13199-3-git-send-email-james.hogan@imgtec.com>
 <20160510100209.GB12554@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160510100209.GB12554@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53341
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

On Tue, May 10, 2016 at 11:02:09AM +0100, James Hogan wrote:

> On Fri, Apr 29, 2016 at 02:46:00PM +0100, James Hogan wrote:
> > MIPS64r2 and later cores may optionally have a 64-bit CP0_EBase
> > register, with a write gate (WG) bit to allow the upper half to be
> > written. The presence of this feature will need to be known about for VZ
> > support in order to correctly save and restore the guest CP0_EBase
> > register, so add CPU feature definitions and probing for this
> > capability.
> 
> Okay, so it turns out EBase.WG can be present on MIPS32 too, to allow
> writing of bits 31:30 (thanks Matt!), so this needs a little more
> thought.

So drop the series for now or do you want to patch it up later?

  Ralf
