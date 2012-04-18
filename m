Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2012 04:53:25 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:45596 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901334Ab2DRCxS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2012 04:53:18 +0200
Received: from localhost (cpe-66-108-118-54.nyc.res.rr.com [66.108.118.54])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id q3I2r8KH000882
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Tue, 17 Apr 2012 19:53:09 -0700
Date:   Tue, 17 Apr 2012 22:53:08 -0400 (EDT)
Message-Id: <20120417.225308.1588669089502246200.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     grant.likely@secretlab.ca, rob.herring@calxeda.com,
        devicetree-discuss@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, galak@kernel.crashing.org,
        david.daney@cavium.com
Subject: Re: [PATCH v4 3/3] netdev/of/phy: Add MDIO bus multiplexer driven
 by GPIO lines.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1334683966-12112-4-git-send-email-ddaney.cavm@gmail.com>
References: <1334683966-12112-1-git-send-email-ddaney.cavm@gmail.com>
        <1334683966-12112-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: Mew version 6.4 on Emacs 24.0.95 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Tue, 17 Apr 2012 19:53:11 -0700 (PDT)
X-archive-position: 32959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <ddaney.cavm@gmail.com>
Date: Tue, 17 Apr 2012 10:32:46 -0700

> From: David Daney <david.daney@cavium.com>
> 
> The GPIO pins select which sub bus is connected to the master.
> 
> Initially tested with an sn74cbtlv3253 switch device wired into the
> MDIO bus.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Are you sure the Kconfig dependencies are sufficient?  This code seems
to depend upon OF, and in particular the OF_MDIO stuff.
