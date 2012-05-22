Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2012 20:57:43 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:34187 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903700Ab2EVS5j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 May 2012 20:57:39 +0200
Received: from localhost (cpe-66-108-119-99.nyc.res.rr.com [66.108.119.99])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id q4MIvRfn011622
        (version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
        Tue, 22 May 2012 11:57:30 -0700
Date:   Tue, 22 May 2012 14:57:26 -0400 (EDT)
Message-Id: <20120522.145726.979935187891590882.davem@davemloft.net>
To:     ddaney.cavm@gmail.com
Cc:     devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca,
        rob.herring@calxeda.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        afleming@freescale.com, david.daney@cavium.com
Subject: Re: [PATCH 0/5] netdev/phy: 10G PHY support.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1337709592-23347-1-git-send-email-ddaney.cavm@gmail.com>
References: <1337709592-23347-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: Mew version 6.5 on Emacs 24.0.95 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Tue, 22 May 2012 11:57:31 -0700 (PDT)
X-archive-position: 33425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


As mentioned the other day in my announement, right now it is
inappropriate to submit new feature patches.

You will need to resend these changes when the net-next tree opens
back up, please monitor the netdev list to learn when that has
happened.
