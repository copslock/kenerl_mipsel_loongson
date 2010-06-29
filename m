Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jun 2010 09:00:34 +0200 (CEST)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:47621
        "EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492144Ab0F2HAJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jun 2010 09:00:09 +0200
Received: from localhost (localhost [127.0.0.1])
        by sunset.davemloft.net (Postfix) with ESMTP id 3FB0424C08E;
        Tue, 29 Jun 2010 00:00:22 -0700 (PDT)
Date:   Tue, 29 Jun 2010 00:00:22 -0700 (PDT)
Message-Id: <20100629.000022.241448825.davem@davemloft.net>
To:     ddaney@caviumnetworks.com
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] netdev: mdio-octeon: Fix section mismatch errors.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1277406888-26309-3-git-send-email-ddaney@caviumnetworks.com>
References: <1277406888-26309-1-git-send-email-ddaney@caviumnetworks.com>
        <1277406888-26309-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: Mew version 6.3 on Emacs 23.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-archive-position: 27273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19209

From: David Daney <ddaney@caviumnetworks.com>
Date: Thu, 24 Jun 2010 12:14:48 -0700

> We started getting:
> 
> WARNING: vmlinux.o(.data+0x20bd0): Section mismatch in reference from
> the variable octeon_mdiobus_driver to the function
> .init.text:octeon_mdiobus_probe()
> 
> This fixes it.
> 
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

Applied to net-next-2.6
