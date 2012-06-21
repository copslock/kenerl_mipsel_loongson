Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Jun 2012 13:32:45 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:34635 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903660Ab2FULcl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Jun 2012 13:32:41 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q5LBWa7q012798;
        Thu, 21 Jun 2012 12:32:36 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q5LBWYB4012797;
        Thu, 21 Jun 2012 12:32:34 +0100
Date:   Thu, 21 Jun 2012 12:32:34 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wuzhangjin@gmail.com, zhzhl555@gmail.com
Subject: Re: [PATCH V7 2/4] MIPS: Add board support for Loongson1B
Message-ID: <20120621113234.GB7175@linux-mips.org>
References: <1339757617-2187-1-git-send-email-keguang.zhang@gmail.com>
 <20120620192551.GC29446@linux-mips.org>
 <4FE225F3.4080806@mvista.com>
 <1463808.aB2kcWCEuH@bender>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1463808.aB2kcWCEuH@bender>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33755
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

On Wed, Jun 20, 2012 at 10:10:26PM +0200, Florian Fainelli wrote:

> > > This redefines a function that already is declared in <linux/clk.h> and
> > > defined in drivers/clk/clkdev.c.  Why?
> > 
> >     Because he doesn't support clkdev? clkdev support is optional.
> 
> I don't think it is a good idea not to support clkdev for new targets. Ralf 
> what do you think about it?

My gut feeling is that if there's a suitable generic infrastructure we
should use it, so use clkdev for new targets.  I was just wondering if
there's a good reason to doing things the way he did.

  Ralf
