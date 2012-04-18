Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2012 19:45:35 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:52391 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903692Ab2DRRp3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2012 19:45:29 +0200
Received: from localhost (cpe-66-108-118-54.nyc.res.rr.com [66.108.118.54])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id q3IHjIwN020463
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Wed, 18 Apr 2012 10:45:19 -0700
Date:   Wed, 18 Apr 2012 13:45:18 -0400 (EDT)
Message-Id: <20120418.134518.381699921667230604.davem@davemloft.net>
To:     david.daney@cavium.com
Cc:     ddaney.cavm@gmail.com, grant.likely@secretlab.ca,
        rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, afleming@gmail.com,
        galak@kernel.crashing.org
Subject: Re: [PATCH v4 3/3] netdev/of/phy: Add MDIO bus multiplexer driven
 by GPIO lines.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4F8EEAD8.8050205@cavium.com>
References: <1334683966-12112-4-git-send-email-ddaney.cavm@gmail.com>
        <20120417.225308.1588669089502246200.davem@davemloft.net>
        <4F8EEAD8.8050205@cavium.com>
X-Mailer: Mew version 6.4 on Emacs 24.0.95 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Wed, 18 Apr 2012 10:45:22 -0700 (PDT)
X-archive-position: 32964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>
Date: Wed, 18 Apr 2012 09:24:56 -0700

> B) Regenerate the entire set with said patch rolled in?

Already regenerate patch sets with fixes incorporated into the
original patches.
