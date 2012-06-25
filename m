Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 01:34:02 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:54178 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903739Ab2FYXd6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 01:33:58 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 99D9E583B63;
        Mon, 25 Jun 2012 16:33:56 -0700 (PDT)
Date:   Mon, 25 Jun 2012 16:33:55 -0700 (PDT)
Message-Id: <20120625.163355.2058784474741116830.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     grant.likely@secretlab.ca, rob.herring@calxeda.com,
        devicetree-discuss@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@gmail.com, david.daney@cavium.com
Subject: Re: [PATCH 1/4] netdev/phy: Handle IEEE802.3 clause 45 Ethernet
 PHYs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <4FE8F01B.2020207@gmail.com>
References: <1340411056-18988-2-git-send-email-ddaney.cavm@gmail.com>
        <20120625.153440.17010814246237639.davem@davemloft.net>
        <4FE8F01B.2020207@gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.0.97 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 33805
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
Date: Mon, 25 Jun 2012 16:11:23 -0700

> Do you realize that at the time get_phy_device() is called, there is
> no PHY device?  So there can be no attribute, nor are we passing a
> register address.  Neither of these suggestions apply to this
> situation.
> 
> We need to know a priori if it is c22 or c45.  So we need to
> communicate the type somehow to get_phy_device().  I chose an unused
> bit in the addr parameter to do this, another option would be to add a
> separate parameter to get_phy_device() specifying the type.

Then pass it in to the get() routine and store the attribute there
in the device we end up with.

There are many parameters that go into a PHY register access, so
we'll probably some day end up with a descriptor struct that the
caller prepares on-stack to pass into the actual read/write ops
via reference.

> ... and this one too I guess.  Really you and Linus should come to a
> consensus on this one.

We did come up with a consensus, which is that subsystem maintainers
such as myself are at liberty to enforce localized coding style for
the bodies of code they maintain.
