Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 01:50:57 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:54280 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903739Ab2FYXuy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 01:50:54 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CD4D9583B7C;
        Mon, 25 Jun 2012 16:50:52 -0700 (PDT)
Date:   Mon, 25 Jun 2012 16:50:51 -0700 (PDT)
Message-Id: <20120625.165051.1449022290472192376.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     grant.likely@secretlab.ca, rob.herring@calxeda.com,
        devicetree-discuss@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, david.daney@cavium.com
Subject: Re: [PATCH 1/4] netdev/phy: Handle IEEE802.3 clause 45 Ethernet
 PHYs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4FE8F8D8.1050009@gmail.com>
References: <4FE8F01B.2020207@gmail.com>
        <20120625.163355.2058784474741116830.davem@davemloft.net>
        <4FE8F8D8.1050009@gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.0.97 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 33807
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
Date: Mon, 25 Jun 2012 16:48:40 -0700

> Therefore, I am going to propose that we add a 'flags' parameter to
> get_phy_device() and change the (two) callers.

Since there is only one flag, make it simply a bool for now.
