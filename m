Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2012 04:17:08 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:57659 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903389Ab2HWCQ7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Aug 2012 04:16:59 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 19F9C5883FD;
        Wed, 22 Aug 2012 19:16:57 -0700 (PDT)
Date:   Wed, 22 Aug 2012 19:16:54 -0700 (PDT)
Message-Id: <20120822.191654.1727215659090597701.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        david.daney@cavium.com
Subject: Re: [PATCH 0/8] netdev/MIPS: Improvements to octeon_mgmt Ethernet
 driver.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
References: <1345574712-21444-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 34348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: David Daney <ddaney.cavm@gmail.com>
Date: Tue, 21 Aug 2012 11:45:04 -0700

> From: David Daney <david.daney@cavium.com>
> 
> Recent additions to the OCTEON SoC family have included enhancements
> to the MIX (octeon_mgmt) Ethernet hardware.  These include:
> 
> o 1Gig support (up from 100M).
> 
> o Hardware timestamping for PTP.
> 
> Here we add support for these two features as well as some ethtool
> improvements and cleanup of the MAC address handling.
> 
> Patch 1/8 is a prerequisite for the rest, and lives in the MIPS
> architecture part of the tree.  Since octeon_mgmt devices are only
> found in OCTEON SoCs we could merge the whole set via Ralf's tree, or
> get Ralf to affix his Acked-by and have it go via the netdev tree.

You can send this all via the MIPS tree, and feel free to add my:

Acked-by: David S. Miller <davem@davemloft.net>
