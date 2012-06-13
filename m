Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2012 16:00:02 +0200 (CEST)
Received: from h9.dl5rb.org.uk ([81.2.74.9]:45165 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903750Ab2FMN75 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 13 Jun 2012 15:59:57 +0200
Received: from h5.dl5rb.org.uk (h5.dl5rb.org.uk [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.5/8.14.3) with ESMTP id q5DDxs0d008148;
        Wed, 13 Jun 2012 14:59:54 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.5/8.14.5/Submit) id q5DDxr1H008147;
        Wed, 13 Jun 2012 14:59:53 +0100
Date:   Wed, 13 Jun 2012 14:59:53 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 1/8] MIPS: BCM63XX: move flash registration out of
 board_bcm963xx.c
Message-ID: <20120613135953.GB6839@linux-mips.org>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com>
 <1339489425-19037-2-git-send-email-jonas.gorski@gmail.com>
 <20120613134801.GA5516@linux-mips.org>
 <2177534.JpaDVG7JnB@flexo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2177534.JpaDVG7JnB@flexo>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33624
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

On Wed, Jun 13, 2012 at 03:51:30PM +0200, Florian Fainelli wrote:

> > And the grand cure for that sort of issue is FDT - we by now have built
> > big deserts of code just registering platform devices like this..  See
> > John Crispin's Lantiq work or David's Cavium code for FDT examples.
> 
> I have some patches to convert bcm63xx to FDT but that is still work in 
> progress, and I don't want them to hold support for newer BCM63xx CPUs.

Oh absolutely.  I'm just nagging to make it clear to everybody into what
direction the world is moving.

> > I suggest to make bcm63xx_flash_register an arch_initcall.  It already is
> > being called indirectly from an bcm63xx_flash_register() so this would
> > allow making the function static, get rid of bcm63xx_dev_flash.h which
> > only exists to silence checkpatch warnings and make board_register_devices
> > a little cleaner.
> 
> Well, yes, this makes it easier, but this is not robust, because you rely on 
> the function alphabetical name to make sure that everything gets registered in 
> the right order. Plus, the big advantage of letting this code separate and 
> explicitely called, is to let out-of-tree boards use it as they wish too.

Ok.  That sort of dependency was not immediately obvious from the patches
and generally can be handled nicely by using the available set of priorities
for initcalls.

  Ralf
