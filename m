Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jun 2011 05:45:21 +0200 (CEST)
Received: from shards.monkeyblade.net ([198.137.202.13]:49134 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491044Ab1FQDpS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jun 2011 05:45:18 +0200
Received: from localhost (69-46-168-130.ip.tor.radiant.net [69.46.168.130])
        (authenticated bits=0)
        by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p5H3jAFu011447
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 16 Jun 2011 20:45:11 -0700
Date:   Thu, 16 Jun 2011 23:45:11 -0400 (EDT)
Message-Id: <20110616.234511.1859847259391796967.davem@davemloft.net>
To:     ralf@linux-mips.org
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        ffainelli@freebox.fr
Subject: Re: [PATCH] phylib: Allow BCM63XX PHY to be selected only on
 BCM63XX.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20110615080758.GA3226@linux-mips.org>
References: <20110615080758.GA3226@linux-mips.org>
X-Mailer: Mew version 6.3 on Emacs 23.2 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Thu, 16 Jun 2011 20:45:12 -0700 (PDT)
X-archive-position: 30431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14283

From: Ralf Baechle <ralf@linux-mips.org>
Date: Wed, 15 Jun 2011 09:07:58 +0100

> This PHY is available integrated into BCM63xx series SOCs only.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Applied, thanks.
