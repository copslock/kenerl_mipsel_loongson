Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2012 16:56:21 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:46695 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903760Ab2FMO4R (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jun 2012 16:56:17 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q5DEuG2T014596;
        Wed, 13 Jun 2012 15:56:16 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q5DEuFT2014595;
        Wed, 13 Jun 2012 15:56:15 +0100
Date:   Wed, 13 Jun 2012 15:56:15 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Bolle <pebolle@tiscali.nl>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: remove three unused headers
Message-ID: <20120613145614.GC5516@linux-mips.org>
References: <1339491792.30984.110.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1339491792.30984.110.camel@x61.thuisdomein>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33626
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

On Tue, Jun 12, 2012 at 11:03:12AM +0200, Paul Bolle wrote:

> No file includes these three headers. It seems they have never been
> included since at least v2.6.12-rc2. They can safely be removed.

>  arch/mips/include/asm/sibyte/sb1250_l2c.h |  131 -------
>  arch/mips/include/asm/sibyte/sb1250_ldt.h |  422 ----------------------
>  arch/mips/include/asm/sibyte/sb1250_mc.h  |  550 -----------------------------

These headers describe the on-chip hardware of the SB1250 SOC.  Some of
the drivers to use them are currently stuck midflight on their path to
submission.  The remaining ones I'd like to keep around as documentation
or for later use.  Ditto for your other BCM1480 related patch....

Thanks,

  Ralf
