Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2012 21:13:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:37948 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903662Ab2CFUNK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2012 21:13:10 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id q26KD5Uu028943;
        Tue, 6 Mar 2012 21:13:05 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id q26KD1CO028937;
        Tue, 6 Mar 2012 21:13:01 +0100
Date:   Tue, 6 Mar 2012 21:13:01 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, devel@driverdev.osuosl.org,
        David Daney <david.daney@cavium.com>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] staging/octeon: Fix PHY binding in octeon-ethernet
 driver.
Message-ID: <20120306201301.GL4519@linux-mips.org>
References: <1330024771-25396-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1330024771-25396-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32608
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Feb 23, 2012 at 11:19:31AM -0800, David Daney wrote:
> Date:   Thu, 23 Feb 2012 11:19:31 -0800
> From: David Daney <ddaney.cavm@gmail.com>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-mips@linux-mips.org, devel@driverdev.osuosl.org, David Daney
>  <david.daney@cavium.com>, Florian Fainelli <florian@openwrt.org>
> Subject: [PATCH] staging/octeon: Fix PHY binding in octeon-ethernet driver.
> 
> From: David Daney <david.daney@cavium.com>
> 
> Commit d6c25be (mdio-octeon: use an unique MDIO bus name.) changed the
> names used to refer to MDIO buses.  The ethernet driver must be
> changed to match, so that the PHY drivers can be attached.

No objections heared, so applied.

  Ralf
