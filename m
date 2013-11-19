Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Nov 2013 18:22:25 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51358 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817040Ab3KSRWUNsX1H (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Nov 2013 18:22:20 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id rAJHMBe0017061;
        Tue, 19 Nov 2013 18:22:12 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id rAJHM6Cp017060;
        Tue, 19 Nov 2013 18:22:06 +0100
Date:   Tue, 19 Nov 2013 18:22:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Florian Fainelli <florian@openwrt.org>,
        Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>,
        Jayachandran C <jchandra@broadcom.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>
Subject: Re: [PATCH v2] panic: Make panic_timeout configurable
Message-ID: <20131119172205.GE10382@linux-mips.org>
References: <20131118210436.233B5202A@prod-mail-relay06.akamai.com>
 <20131119090211.GN10382@linux-mips.org>
 <528B9BC1.7090402@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <528B9BC1.7090402@akamai.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38549
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

On Tue, Nov 19, 2013 at 12:11:29PM -0500, Jason Baron wrote:

> > I propose to kill these overrides for sanity unless somebody comes up
> > with a good argument.  Patch below.
> > 
> 
> And so have the mips default be 0? IE drop the arch/mips/Kconfig bits from
> the patch I posted? (Which could of course be configured to a non-zero value
> by the user, if desired.)

Yes.

  Ralf
